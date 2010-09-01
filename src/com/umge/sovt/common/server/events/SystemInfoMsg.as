package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;

    public class SystemInfoMsg extends BaseBean
    {
        public var msg:String;
        public var tV:Boolean;
        public var noSenderSystemInfo:Boolean;
        public var tVContext:String;
        public var sender:String;
        public var alliance:Boolean;

        public function SystemInfoMsg(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.msg != null)
            {
                this.msg = param2.msg;
            }// end if
            if (param2.sender != null)
            {
                this.sender = param2.sender;
            }// end if
            if (param2.tVContext != null)
            {
                this.tVContext = param2.tVContext;
            }// end if
            if (param2.alliance != null)
            {
                this.alliance = param2.alliance;
            }// end if
            if (param2.noSenderSystemInfo != null)
            {
                this.noSenderSystemInfo = param2.noSenderSystemInfo;
            }// end if
            if (param2.tV != null)
            {
                this.tV = param2.tV;
            }// end if
            return;
        }// end function

        public function copyTo(param1:SystemInfoMsg) : void
        {
            param1.msg = this.msg;
            param1.sender = this.sender;
            param1.tVContext = this.tVContext;
            param1.alliance = this.alliance;
            param1.noSenderSystemInfo = this.noSenderSystemInfo;
            param1.tV = this.tV;
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.msg = this.msg;
            _loc_1.sender = this.sender;
            _loc_1.tVContext = this.tVContext;
            _loc_1.alliance = this.alliance;
            _loc_1.noSenderSystemInfo = this.noSenderSystemInfo;
            _loc_1.tV = this.tV;
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "sender = " + this.sender + "\n");
            _loc_2 = _loc_2 + (param1 + "tVContext = " + this.tVContext + "\n");
            _loc_2 = _loc_2 + (param1 + "alliance = " + this.alliance + "\n");
            _loc_2 = _loc_2 + (param1 + "noSenderSystemInfo = " + this.noSenderSystemInfo + "\n");
            _loc_2 = _loc_2 + (param1 + "tV = " + this.tV + "\n");
            return _loc_2;
        }// end function

    }
}
