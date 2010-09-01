package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;

    public class WorldChatMsg extends BaseBean
    {
        public var msg:String;
        public var channel:String;
        public var fromUser:String;
        public var languageType:int;

        public function WorldChatMsg(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.channel != null)
            {
                this.channel = param2.channel;
            }// end if
            if (param2.fromUser != null)
            {
                this.fromUser = param2.fromUser;
            }// end if
            if (param2.languageType != null)
            {
                this.languageType = param2.languageType;
            }// end if
            if (param2.msg != null)
            {
                this.msg = param2.msg;
            }// end if
            return;
        }// end function

        public function copyTo(param1:WorldChatMsg) : void
        {
            param1.channel = this.channel;
            param1.fromUser = this.fromUser;
            param1.languageType = this.languageType;
            param1.msg = this.msg;
            return;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "channel = " + this.channel + "\n");
            _loc_2 = _loc_2 + (param1 + "fromUser = " + this.fromUser + "\n");
            _loc_2 = _loc_2 + (param1 + "languageType = " + this.languageType + "\n");
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            return _loc_2;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.channel = this.channel;
            _loc_1.fromUser = this.fromUser;
            _loc_1.languageType = this.languageType;
            _loc_1.msg = this.msg;
            return _loc_1;
        }// end function

    }
}
