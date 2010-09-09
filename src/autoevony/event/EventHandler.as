package autoevony.event
{
	public class EventHandler
	{
		public var type:String;
		public var callBack:Function;

		public function EventHandler(eventType:String, eventCallBack:Function)
		{
			type = eventType;
			callBack = eventCallBack;
		}
	}
}