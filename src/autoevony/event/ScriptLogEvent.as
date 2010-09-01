package autoevony.event
{
	import flash.events.Event;

	public class ScriptLogEvent extends Event
	{
		public static const TYPE:String = "LogEventType";

		public static const MESSAGE:int = 0;
		public static const ERROR:int = 1;

		public var logText:String;
		public var logType:int;

		public function ScriptLogEvent(logText:String, logType:int=MESSAGE)
		{
			super(TYPE);
			this.logType = logType;
			this.logText = logText;
		}

	}
}