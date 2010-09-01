package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;

    public class ConnectionLost extends BaseBean
    {
        public var reasonCode:int;
        public static const SERVER_SHUTDOWN:int = 2;
        public static const KICK_BY_SERVER:int = 0;
        public static const SERVER_START:int = 1;
        public static const SERVER_MAINTAIN:int = 4;
        public static const KICK_BY_OTHER:int = 3;

        public function ConnectionLost(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.reasonCode != null)
            {
                this.reasonCode = param2.reasonCode;
            }// end if
            return;
        }// end function

        public function copyTo(param1:ConnectionLost) : void
        {
            param1.reasonCode = this.reasonCode;
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.reasonCode = this.reasonCode;
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "reasonCode = " + this.reasonCode + "\n");
            return _loc_2;
        }// end function

    }
}
