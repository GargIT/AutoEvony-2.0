package com.umge.sovt.net.client
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class GameClient extends EventDispatcher
    {
        private var serverIp:String;
        private var version:String = null;
        private var mainBuffer:ByteArray;
        private var amfObj:Object;
        private var processedCount:int;
        private var serverPort:int;
        private var lock:Boolean = false;
        private var readed:int = 0;
        private var dataLength:int = 0;
        private var socket:Socket;
        private static const MAX_PACKAGE_LEN:int = 1048576;
        private static const VERSION_COMMAND:String = "gameClient.version";

        public function GameClient()
        {
            socket = new Socket();
            socket.addEventListener(Event.CONNECT, connectionHandler);
            socket.addEventListener(Event.CLOSE, disconnectionHandler);
            socket.addEventListener(ProgressEvent.SOCKET_DATA, incomingDataHandler);
            socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ioErrorHandler2);
            return;
        }// end function

        public function getServerIp() : String
        {
            return serverIp;
        }// end function

        public function isConnectioned() : Boolean
        {
            return socket.connected;
        }// end function

        private function incomingDataHandler(param1:ProgressEvent) : void
        {
            var needRead:int;
            var tempBuffer:ByteArray;
            var e:* = param1;
            if (lock)
            {
                throw new Error("Socket.bytesAvailable=" + socket.bytesAvailable + "\tprocessedCount=" + processedCount + "\treaded=" + readed + " dataLength:" + dataLength);
            }// end if
            lock = true;
            while (socket.bytesAvailable > 0)
            {
                // label
                trace("GameClient.incomingDataHandler(): incoming data length:" + socket.bytesAvailable);
                if (dataLength == 0)
                {
                    dataLength = socket.readInt();
                    readed = 0;
                    if (dataLength > MAX_PACKAGE_LEN || dataLength < 0)
                    {
                        throw new Error("The package size is illegal. len=" + dataLength);
                    }// end if
                    mainBuffer = new ByteArray();
                    processedCount = 0;
                    trace("GameClient.incomingDataHandler(): New package.incomingLen:" + socket.bytesAvailable + " dataLength:" + dataLength);
                }// end if
                needRead = dataLength - readed;
                if (needRead > this.socket.bytesAvailable)
                {
                    needRead = this.socket.bytesAvailable;
                }// end if
                if (needRead < 0)
                {
                    throw new Error("The package available size is illegal .lenNeedRead=" + needRead + "\tremain=" + socket.bytesAvailable + "\tprocessedCount=" + processedCount + "\treaded=" + readed);
                }// end if
                try
                {
                    this.readed = this.readed + needRead;
                    tempBuffer = new ByteArray();
                    socket.readBytes(tempBuffer, 0, needRead);
                    mainBuffer.writeBytes(tempBuffer);
                    processedCount++;
                }// end try
                catch (err:Error)
                {
                    dispatchEvent(new GameClientEvent(GameClientEvent.ON_ERROR));
                }// end catch
                trace("GameClient.incomingDataHandler(): reading data. lenNeedRead=" + needRead + "\tremain=" + socket.bytesAvailable + "\tprocessedCount=" + processedCount + "\treaded=" + readed);
                if (readed == dataLength)
                {
                    trace("GameClient.incomingDataHandler(): object length: " + readed);
                    this.lock = false;
                    mainBuffer.position = 0;
                    amfObj = mainBuffer.readObject();
                    mainBuffer = null;
                    dataLength = 0;
                    processedCount = 0;
                    readed = 0;
                    if (!amfObj)
                    {
                        dispatchEvent(new GameClientEvent(GameClientEvent.ON_ERROR));
                        return;
                    }// end if
                    if (checkCommand(amfObj))
                    {
                        return;
                    }// end if
                    dispatchEvent(new GameClientEvent(GameClientEvent.ON_EXTENSION_RESPONSE, amfObj));
                }// end if
            }// end while
            this.lock = false;
            return;
        }// end function

        private function connectionHandler(param1:Event) : void
        {
            trace("socket connection event");
            sendMessage(VERSION_COMMAND, version);
            dispatchEvent(new GameClientEvent(GameClientEvent.ON_CONNECTION));
            return;
        }// end function

        private function ioErrorHandler2(param1:SecurityErrorEvent) : void
        {
            trace("the network connection has IOError : " + param1.text);
            dispatchEvent(new GameClientEvent(GameClientEvent.ON_ERROR));
            return;
        }// end function

        public function setVersion(param1:String) : void
        {
            this.version = param1;
            return;
        }// end function

        public function getServerPort() : int
        {
            return serverPort;
        }// end function

        public function connection(param1:String, param2:int) : void
        {
            if (!version)
            {
                throw new RequiredVersionError("the GameClient required a version.");
            }// end if
            trace("connect the server : " + param1);
            if (!isConnectioned())
            {
                socket.connect(param1, param2);
                dataLength = 0;
            }// end if
            return;
        }// end function

        public function sendMessage(param1:String, param2:Object) : void
        {
            if (!isConnectioned())
            {
                throw new NotConnectionedError("the connection is not ready, yet.");
            }// end if
            var _loc_3:* = new Object();
            _loc_3.cmd = param1;
            _loc_3.data = param2;
            var _loc_4:* = new ByteArray();
            _loc_4.writeObject(_loc_3);
            socket.writeInt(_loc_4.length);
            socket.writeBytes(_loc_4);
            socket.flush();
            return;
        }// end function

        private function checkCommand(param1:Object) : Boolean
        {
            trace("package id : " + param1.data.packageId);
            switch(param1.cmd)
            {
                case KickoutEvent.KICKOUT:
                {
                    dispatchEvent(new KickoutEvent(KickoutEvent.KICKOUT, param1.data));
                    disconnection();
                    return true;
                }// end case
                case ErrorVersionEvent.ERROR_VERSION:
                {
                    dispatchEvent(new ErrorVersionEvent(ErrorVersionEvent.ERROR_VERSION, param1.data));
                    disconnection();
                    return true;
                }// end case
                default:
                {
                    break;
                }// end default
            }// end switch
            return false;
        }// end function

        private function ioErrorHandler(param1:IOErrorEvent) : void
        {
            trace("the network connection has IOError : " + param1.text);
            dispatchEvent(new GameClientEvent(GameClientEvent.ON_ERROR));
            return;
        }// end function

        public function disconnection() : void
        {
            try
            {
                socket.close();
            }// end try
            catch (e:Error)
            {
                trace(e.message);
            }// end catch
            disconnectionHandler(new Event(Event.CLOSE));
            return;
        }// end function

        private function disconnectionHandler(param1:Event) : void
        {
            trace("socket connection was disconnect");
            dispatchEvent(new GameClientEvent(GameClientEvent.ON_CONNECTION_LOST));
            return;
        }// end function

    }
}
