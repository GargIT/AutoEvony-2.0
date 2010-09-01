package com.umge.sovt.net.client
{
    import flash.events.*;

    public class ErrorVersionEvent extends Event
    {
        public var requiredVersion:String;
        public var message:String;
        public static const ERROR_VERSION:String = "gameClient.errorVersion";

        public function ErrorVersionEvent(param1:String, param2:Object)
        {
            super(param1);
            message = param2.msg;
            trace("message is : " + message);
            requiredVersion = param2.version;
            trace("required version is : " + requiredVersion);
            return;
        }// end function

    }
}
