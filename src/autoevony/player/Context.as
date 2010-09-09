package autoevony.player 
{
    import com.umge.sovt.client.response.*;
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;
    import com.umge.sovt.common.constants.*;
    import com.umge.sovt.common.server.events.*;
    
    import flash.events.*;
    import flash.net.SharedObject;
    import flash.utils.*;
    
    import mx.collections.ArrayCollection;
    import mx.events.*;
    
    import org.smtp.events.SMTPEvent;
    import org.smtp.mailer.SMTPMailer;
    
    public class Context extends Object implements flash.events.IEventDispatcher
    {
	   	public static const EVENT_PLAYER_LOGIN:String="Context.login";
	    public static const EVENT_CASTLE_CHANGE:String="Context.m_curCastleChange";
	    public static const EVENT_CASTLE_MOVE:String="Context.m_curCastleMove";
	    public static const INNER_BUILDING_POSITION:int=100;
	    public static var CleaningReports:Boolean = false;
	    public static var AudioAlerts:Boolean = false;
	    public static var MailAlerts:Boolean = false;
	    public static var smtpAddress:String;
	    public static var smtpServer:String;
	    public static var smtpUser:String;
	    public static var smtpPassword:String;
	    public static var lastMailStatus:String;
	    public static var MailHandler:SMTPMailer;
	    	    
	    public var army_BlueCount:uint;
	    public var army_RedCount:uint;
	    public var blueCount:uint;
	    public var isLink:Boolean;
	    public var userIsFirstLogin:Boolean=false;
	    public var userName:String="";
	    
	    private static var m_mailMessage:String;
	    private static var m_authSmtp:Boolean = true;
	    private static var m_player:PlayerBean;	    
	    private static var m_instance:Context = new Context();
		private static var m_loginDateTime:Date;
	    private static var m_timeDiff:Number;
	    private static var m_statusTimer:Timer;
	    
	    private static var m_serverMinutes:int;
	    private static var m_serverHours:int;
	    private static var m_serverDate:int;
	    private static var m_serverMonth:int;
	    private static var m_serverYear:int;
	    
	    private var m_loginPrestigeValue:int=-1;
	    private var m_bindingEventDispatcher:EventDispatcher;
	    private var m_curCastle:CastleBean;	    
	    
        public function Context() : void
        {
 /*    		var botSettings:SharedObject = SharedObject.getLocal("botSettings");
			
			if (botSettings.size > 0)
			{
				AudioAlerts = botSettings.data.audioAlerts;
				AutoHeroReward = botSettings.data.autoHeroReward;
				AutoHeroUpgrade = botSettings.data.autoHeroUpgrade;
				AutoTroopHeal = botSettings.data.autoTroopHeal;
				MailAlerts = botSettings.data.mailAlerts;
				smtpAddress = botSettings.data.smtpAddress;
				smtpPassword = botSettings.data.smtpPassword;
				smtpServer = botSettings.data.smtpServer;
				smtpUser = botSettings.data.smtpUser;
			} */
        	
            m_bindingEventDispatcher = new flash.events.EventDispatcher(flash.events.IEventDispatcher(this));
            super();
            //ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_RESOURCE_UPDATE, onResourceUpdate);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_PLAYER_INFO_UPDATE, onPlayerInfoUpdate);
            //ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_TROOP_UPDATE, onTroopUpdate);
            //ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_FORTIFICATIONS_UPDATE, onFortiFicationsUpdate);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_NEW_MAIL, onNewMail);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_NEW_REPORT, onNewReport);
            
            try
            {
            	MailHandler = new SMTPMailer(smtpServer);
            }
            catch (e:Error)
            {
            	lastMailStatus = "Unable to connect to mail server";
            }
            
            if (MailHandler != null)
            {
	            // event dispatched when mail is successfully sent
				MailHandler.addEventListener(SMTPEvent.MAIL_SENT, onMailSent);
				// event dispatched when mail could not be sent
				MailHandler.addEventListener(SMTPEvent.MAIL_ERROR, onMailError);
				// event dispatched when SMTPMailer successfully connected to the SMTP server
				MailHandler.addEventListener(SMTPEvent.CONNECTED, onMailConnect);
				MailHandler.addEventListener(SMTPEvent.BAD_SEQUENCE, onMailError);
				MailHandler.addEventListener(SMTPEvent.AUTHENTICATED, onMailAuth);
				MailHandler.addEventListener(IOErrorEvent.IO_ERROR, onMailError);
				MailHandler.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onMailError);
            }
            
            return;
        }
        
        public static function getInstance():Context
        {
        	if (m_instance == null)
        	{
        		m_instance = new Context();
        	}
            return m_instance;
        }

		public static function refreshSettings() : void
		{
/* 			var botSettings:SharedObject = SharedObject.getLocal("botSettings");
			
			botSettings.data.audioAlerts = Context.AudioAlerts;
			botSettings.data.autoHeroReward = Context.AutoHeroReward;
			botSettings.data.autoHeroUpgrade = Context.AutoHeroUpgrade;
			botSettings.data.autoTroopHeal = Context.AutoTroopHeal;
			botSettings.data.mailAlerts = Context.MailAlerts;
			botSettings.data.smtpAddress = Context.smtpAddress;
			botSettings.data.smtpPassword = Context.smtpPassword;
			botSettings.data.smtpServer = Context.smtpServer;
			botSettings.data.smtpUser = Context.smtpUser; */
		}
		
        public function willTrigger(arg1:String):Boolean
        {
            return m_bindingEventDispatcher.willTrigger(arg1);
        }

        public function get serverHours():int
        {
            return m_serverHours;
        }

        public function get serverDate():int
        {
            return m_serverDate;
        }
		
		private function onNewMail(arg1:NewMail):void
		{
			m_player.newMaileCount_inbox = arg1.count_inbox;
			m_player.newMaileCount_system = arg1.count_system;
			m_player.newMailCount = arg1.count;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "NewMail", null, arg1));			
		}
		
		private function onNewReport(arg1:NewReport):void
		{
			if (Context.CleaningReports)
			{
				return;
			}
			
			m_player.newReportCount_army = arg1.army_count
			m_player.newReportCount_trade = arg1.trade_count
			m_player.newReportCount_other = arg1.other_count
			m_player.newReportCount = arg1.count;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "NewReport", null, arg1));
		}
		
        public function set serverHours(arg1:int):void
        {
            var loc1:*;
            loc1 = m_serverHours;
            if (loc1 !== arg1)
            {
                m_serverHours = arg1;
                this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "serverHours", loc1, arg1));
            }
            return;
        }

        public function get serverYear():int
        {
            return m_serverYear;
        }

        public function get serverMinutes():int
        {
            return m_serverMinutes;
        }

        public static function get Player():PlayerBean
        {
            return m_player;
        }

        public function set serverDate(arg1:int):void
        {
            var loc1:*;
            loc1 = m_serverDate;
            if (loc1 !== arg1)
            {
                m_serverDate = arg1;
                this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "serverDate", loc1, arg1));
            }
            return;
        }

        public function set serverMinutes(arg1:int):void
        {
            var loc1:*;
            loc1 = m_serverMinutes;
            if (loc1 !== arg1)
            {
                m_serverMinutes = arg1;
                this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "serverMinutes", loc1, arg1));
            }
            return;
        }

        public static function setPlayerBean(arg1:PlayerBean):void
        {
            trace("Context.setPlayerBean()");
            m_player = arg1;
            
            if (m_statusTimer == null)
            {
                m_statusTimer = new flash.utils.Timer(1000);
                m_statusTimer.addEventListener(TimerEvent.TIMER, onStatusTimer);
                m_statusTimer.start();
            }
            var now:Date = new Date();
            m_timeDiff = now.valueOf() - arg1.currentTime;
            m_loginDateTime = now;
            return;
        }

        public function set serverYear(arg1:int):void
        {
            var year:int = m_serverYear;
            if (year !== arg1)
            {
                m_serverYear = arg1;
                this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "serverYear", year, arg1));
            }
            return;
        }

        private static function onStatusTimer(arg1:flash.events.TimerEvent):void
        {
            var loc1:Array = m_player.currentDateTime.toString().split(" ");
            var loc2:Array = loc1[0].toString().split(".");
            var loc3:Array = loc1[1].toString().split(".");
            var loc4:Date = new Date(loc2[0], (loc2[1] - 1), loc2[2], loc3[0], loc3[1], loc3[2]);
            var serverTime:Date = new Date(loc4.valueOf() + new Date().valueOf() - m_loginDateTime.valueOf());
            m_serverHours = serverTime.getHours();
            m_serverMinutes = serverTime.getMinutes();
            m_serverYear = serverTime.getFullYear();
            m_serverMonth = serverTime.getMonth() + 1;
            m_serverDate = serverTime.getDate();
 
			m_instance.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(m_instance, "timerUpdate", null, m_serverMinutes));           
            return;
        }

        public function dispatchEvent(arg1:flash.events.Event):Boolean
        {
            return m_bindingEventDispatcher.dispatchEvent(arg1);
        }

        public function addEventListener(arg1:String, arg2:Function, arg3:Boolean=false, arg4:int=0, arg5:Boolean=false):void
        {
            m_bindingEventDispatcher.addEventListener(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        private function onPlayerInfoUpdate(arg1:PlayerInfoUpdate):void
        {
            arg1.playerInfo.copyTo(m_player.playerInfo);
            if (this.m_loginPrestigeValue != -1)
            {
                if (this.m_loginPrestigeValue < 100)
                {
                    if (m_player.playerInfo.prestige >= 100)
                    {
                        this.m_loginPrestigeValue = m_player.playerInfo.prestige;
                    }
                }
            }
            else 
            {
                this.m_loginPrestigeValue = m_player.playerInfo.prestige;
            }
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "PlayerInfoUpdate", null, arg1));
            return;
        }

        public function removeEventListener(arg1:String, arg2:Function, arg3:Boolean=false):void
        {
            m_bindingEventDispatcher.removeEventListener(arg1, arg2, arg3);
            return;
        }

        public function getTimeDiff():Number
        {
            return m_timeDiff;
        }
        
        		/**
		 * Converts a fieldId to human readable coords (x, y)
		 */
		public static function ToCoords(id:int) : String
		{
			var result:String;

			if (id < 0 || id >= (Context.Player.mapSizeX * Context.Player.mapSizeY))
			{
				return "invalid id";
			}

			result = id % Context.Player.mapSizeX + ",";
			result += Math.floor(id/Context.Player.mapSizeX);

			return result;
		}

		/**
		 * Converts field coords (x, y) to a fieldId used
		 * in commands
		 */
		public static function ToFieldId(coords:String) : int
		{			
			var first:int;
			var second:int;
			coords = coords.replace(".", ",");
			var coordArray:Array = coords.split(",");
			
			if (coordArray.length == 2)
			{
				first = int(coordArray[0]);
				second = int(coordArray[1]);
				var teststring:String = "" + first + "," + second
				if (teststring == coords && Context.Player.mapSizeX > 0 && first < Context.Player.mapSizeX && second < Context.Player.mapSizeY)
				{ 
					return second * Context.Player.mapSizeX + first;
				}
			}
			
			// -1 == and invalid coord was passed in.
			return -1;
		}
		


        public static function getCastleById(id:int) : CastleBean
        {
            var castle:CastleBean;

            for each (castle in m_player.castlesArray)
            {
                if (castle.id == id)
                {
                    return castle;
                }                
            }
            
            return null;
        }

        public function hasEventListener(arg1:String):Boolean
        {
            return m_bindingEventDispatcher.hasEventListener(arg1);
        }

        public function set serverMonth(arg1:int):void
        {
            var loc1:*;
            loc1 = m_serverMonth;
            if (loc1 !== arg1)
            {
                m_serverMonth = arg1;
                this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "serverMonth", loc1, arg1));
            }
            return;
        }

        public function get serverMonth():int
        {
            return m_serverMonth;
        }

        public static function sendAlert(message:String) : void
        {
        	if (!Context.MailAlerts)
        	{
        		return;
        	}
        	
        	if (MailHandler == null)
    		{
    			if (smtpServer.length > 0)
    			{
    				MailHandler = new SMTPMailer(smtpServer)
    			}	
    		}
    		
    		m_authSmtp = smtpUser.length > 0 && smtpPassword.length > 0;
    		
    		m_mailMessage = message;
    		try
    		{
    			MailHandler.connect(smtpServer, 25);
    		}
    		catch (err:Error)
    		{
    			lastMailStatus = "Unable to connect to e-mail server";
    		}    		
        }
        
        private static function onMailAuth(response:Object) : void
        {
			sendMail();        	
        }
        
        private static function onMailConnect(response:Object) : void
        {
        	if (m_authSmtp)
        	{
        		MailHandler.authenticate(smtpUser, smtpPassword);
        	}
        	else
        	{
        		sendMail();
        	}
        }
        
        private static function sendMail() : void
        {
        		if (!MailHandler.connected)
        		{
        			trace("Not connected to mail server");
        			return;
        		}        		
        		
        		MailHandler.sendHTMLMail("evobot@evo-bot.com", smtpAddress, "Alert from evobot", m_mailMessage);
        }
        
        private static function onMailSent(response:Object) : void
        {
        	lastMailStatus = "Mail sent";
        	MailHandler.close();
        }
        
        private static function onMailError(response:Object) : void
        {
        	lastMailStatus = "Last attempt to send mail failed";
        	try
        	{
        		MailHandler.close();
        	}
        	catch (e:Error) {}
        }
    }
}
 