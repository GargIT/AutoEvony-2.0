package org.smtp.events

{
	
	import flash.events.Event;
	
	public class SMTPEvent extends Event 
	
	{
		
		public static const MAIL_SENT:String = "mailSent";
		public static const ACTION_OK:String = "actionOk";
		public static const AUTHENTICATED:String = "authenticated";
		public static const MAIL_ERROR:String = "mailError";
		public static const BAD_SEQUENCE:String = "badSequence";
		public static const CONNECTED:String = "connected";
		public static const DISCONNECTED:String = "disconnected";
		public static const DATA:String = "data";
		public static const AUTH_USER:String = "authUser";
		public static const AUTH_PASS:String = "authPass";
		
		public var result:Object;
		
		public function SMTPEvent ( pEvent:String, pInfos:Object )
		
		{
			
			super ( pEvent );
			
			result = pInfos;
			
		}
		
	}
	
}