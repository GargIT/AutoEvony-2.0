package com.umge.net.client
{
    import flash.events.*;

    public class GameClientEvent extends Event
    {
        public var data:Object;
        public var cmd:String;
        public static const ON_EXTENSION_RESPONSE:String = "gameClient.onExtensionResponse";
        public static const ON_CONNECTION_LOST:String = "gameClient.onConnectionLost";
        public static const ON_ERROR:String = "gameClient.onError";
        public static const ON_CONNECTION:String = "gameClient.onConnection";

        public function GameClientEvent(param1:String, param2:Object = null)
        {
            super(param1);
            if (param2)
            {
                if (param2.data)
                {
                    this.data = param2.data;
                }// end if
                if (param2.cmd)
                {
                    this.cmd = param2.cmd;
                }// end if
                trace("dispatch Event:" + this.cmd);
            }// end if
            return;
        }// end function

    }
}
