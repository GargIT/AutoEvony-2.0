package com.umge.sovt.net.client
{
    import flash.events.*;

    public class KickoutEvent extends Event
    {
        public var message:String;
        public static const KICKOUT:String = "gameClient.kickout";

        public function KickoutEvent(param1:String, param2:Object)
        {
            super(param1);
            message = param2.msg;
            trace("message is : " + message);
            return;
        }// end function

    }
}
