package autoevony.net
{
	import autoevony.common.Utils;
	import autoevony.event.ScriptLogEvent;
	import autoevony.player.Context;
	import com.adobe.crypto.SHA1;
	import com.umge.net.client.GameClientEvent;
	import com.umge.sovt.client.action.ActionFactory;
	import com.umge.sovt.client.response.ResponseDispatcher;
	import com.umge.sovt.common.Sender;
	import com.umge.sovt.common.constants.CommonConstants;
	import com.umge.sovt.common.server.events.LoginResponse;
	
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	
	public class Connection extends Sprite implements Sender
	{
		private static const MAX_PACKAGE_SIZE:int = 1048576;
		private static var conn:Connection = new Connection();
		
		private var initialized:Boolean = false;
		private var username:String;
		private var password:String;
		private var server:String;
		
		private var socket:Socket;
		private var buffer:ByteArray;
		private var packageSize:int;
		private var busy:Boolean;
		
		private var connectAttempts:int;
		public var reconnectTimer:Timer = new Timer(10000);
		public var authenticated:Boolean;
		public var paused:Boolean;
		
		public static function getInstance() : Connection {
			return conn;
		}
		
		public function init(username:String, password:String, server:String) : void {
			if (initialized) return;
			
			initialized = true;
			this.username = username;
			this.password = password;
			this.server = server;
			
			socket = new Socket();
			reconnectTimer.addEventListener(TimerEvent.TIMER, reconnectHandle);

			addEventListener(GameClientEvent.ON_EXTENSION_RESPONSE, onExtensionResponseHandle);
			ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_LOGIN_RESPONSE, onLogin);
			ActionFactory.getInstance().setSender(this);
			
			socket.addEventListener(Event.CONNECT, connectHandler);
			socket.addEventListener(Event.CLOSE, closeHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
			socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ioErrorHandler);
			
			connect();	
		}
		
		public function getHashedPassword() : String {
			return SHA1.hash(password);;
		}
				
		private function reconnectHandle(event:TimerEvent) : void {
			var MAXQUICKATTEMPTS:int = 3;
			if (paused) return;
			if (authenticated) {
				reconnectTimer.stop();
				return;
			}
			
			dispatchEvent(new ScriptLogEvent("Attempt to reconnect..."));
			connect();
			connectAttempts++;
			if (connectAttempts > MAXQUICKATTEMPTS) {
				if (socket.connected) {
					try {
						socket.close();
					} catch (e:Error) {}
				}

				if (connectAttempts == MAXQUICKATTEMPTS+1) {
					reconnectTimer.delay = Utils.rand(8*60*1000, 10*60*1000); // 8-10 min
					dispatchEvent(new ScriptLogEvent("Too many failed reconnections, next retry in " + Utils.formatTime(reconnectTimer.delay/1000)));
				}
			}			
		}

		private function onLogin(response:LoginResponse) : void {
			trace("receive login response");
	
			if (response.player == null) {
				switch (response.ok) {
					case LoginResponse.LOGIN_RESULT_NEED_CREATE_PLAYER:
						Alert.show("You have not logged in to this server ever before. So use the real game client to setup your name and other details," +
							"then use this client to connect.");
						break;
					case LoginResponse.LOGIN_RESULT_SERVER_FULL:
						Alert.show("Server full, please try again later");
						break;
					case LoginResponse.LOGIN_RESULT_ERROR_USERNAME:
						Alert.show("Invalid user name or password, please try again");
						break;
					default:
						Alert.show("Login failed: " + response.errorMsg);				
				}
				return;
			}
			
			Context.setPlayerBean(response.player);
			
			reconnectTimer.delay = Utils.rand(15000, 30000);
			authenticated = true;
			connectAttempts = 0;			
		}
		
		private function connectHandler(event:Event) : void {
			trace("send version");
		    directSendMessage("gameClient.version", Version.GAMECLIENTVERSION);

			trace("send login info");
			var obj:Object = new Object();
			obj.user = username;
			obj.pwd = getHashedPassword();
			directSendMessage(CommonConstants.LOGIN_CMD, obj);		
		}
		
		private function closeHandler(event:Event) : void {
			authenticated = false;
			if (paused) {
				dispatchEvent(new ScriptLogEvent("Disconnected from server"));
			} else {
				dispatchEvent(new ScriptLogEvent("Disconnected from server, retry in " + Utils.formatTime(reconnectTimer.delay/1000)));
			}
			
			try {
				disconnect();				
			} catch(e:IOError) {}

			dispatchEvent(new GameClientEvent(ResponseDispatcher.SERVER_CONNECTION_LOST));
			reconnectTimer.start();			
		}
		
		private function ioErrorHandler(event:Event) : void {
			authenticated = false;
			dispatchEvent(new GameClientEvent(GameClientEvent.ON_ERROR));			
			
		}		
		private function onExtensionResponseHandle(gameClientEvent:GameClientEvent) : void {
			ResponseDispatcher.getInstance().dispatch(gameClientEvent.cmd, gameClientEvent.data);
		};
		
		public function connect() : void {
			busy = false;
			packageSize = -1;
			socket.connect(server, 443);
		}
		
		public function disconnect() : void
		{
			try {
				socket.close();	
			}
			catch (e:Error) {}
			
			authenticated = false;
			packageSize = -1;
		}
		
		public function sendMessage(cmd:String, data:Object):void {
			if(!authenticated) return;
			directSendMessage(cmd, data);
		}
		
		private function directSendMessage(cmd:String, data:Object):void {
			if (socket.connected) {
				var obj:Object = new Object();

				obj.cmd = cmd;
				obj.data = data;

				var buffer:ByteArray = new ByteArray();
				buffer.writeObject(obj);
				socket.writeInt(buffer.length);
				socket.writeBytes(buffer);
				socket.flush();
			}
		}

		private function socketDataHandler(event:Event) : void {
			if (busy) return;
			busy = true;

			try {
				while (socket.bytesAvailable > 0) {
					if (packageSize == -1) {
						// try to read object size
						if (socket.bytesAvailable < 4) break;

						try {
							packageSize = socket.readInt();
						} catch (error:Error) {
							dispatchEvent(new ScriptLogEvent("An error occurred while talking to the server (read package size). Reconnect..."));
							reconnectTimer.delay = Utils.rand(8*60*1000, 10*60*1000); // 8-10 min
							closeHandler(null);
							return;				
						}	
						
						if (packageSize < 0 || packageSize > MAX_PACKAGE_SIZE) {
							reconnectTimer.delay = Utils.rand(8*60*1000, 10*60*1000); // 8-10 min
							dispatchEvent(new ScriptLogEvent("An error occurred while talking to the server (invalid package size " + packageSize + "). Reconnect..."));
							closeHandler(null);
							return;	
						}
						buffer = new ByteArray();
						continue;
					}
					
					// try to read socket data into buffer
					var nBytes:int = Math.min(socket.bytesAvailable, packageSize - buffer.length);
					try {
						socket.readBytes(buffer, buffer.length, nBytes);
					} catch (error:Error) {
						reconnectTimer.delay = Utils.rand(8*60*1000, 10*60*1000); // 8-10 min
						dispatchEvent(new ScriptLogEvent("An error occurred while talking to the server (read object). Reconnect..."));
						closeHandler(null);
						return;				
					}
					
					// check to see if the whole package has been read
					if (buffer.length == packageSize) {
						trace("Package read");
						var obj:Object;
						try {
							obj = buffer.readObject();
						} catch (error:Error) {
							reconnectTimer.delay = Utils.rand(8*60*1000, 10*60*1000); // 8-10 min
							dispatchEvent(new ScriptLogEvent("An error occurred while talking to the server (convert object). Reconnect..."));
							closeHandler(null);
							return;
						}
						
						if (!obj || obj.cmd == undefined || obj.data == undefined) {
							reconnectTimer.delay = Utils.rand(8*60*1000, 10*60*1000); // 8-10 min
							dispatchEvent(new ScriptLogEvent("An error occurred while talking to the server (invalid object). Reconnect..."));
							closeHandler(null);
							return;
						}
						
						packageSize = -1;
						dispatchEvent(new GameClientEvent(GameClientEvent.ON_EXTENSION_RESPONSE, obj));
					}
				}
			} catch(error:Error) {
				dispatchEvent(new ScriptLogEvent("Unknown error reading data from server"));
				trace(error.getStackTrace());			
			}
			
			busy = false;
		}
	}
}