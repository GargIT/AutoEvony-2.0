package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;

    public class NewMail extends BaseBean
    {
        public var count_inbox:int;
        public var count:int;
        public var count_system:int;

        public function NewMail(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.count != null)
            {
                this.count = param2.count;
            }// end if
            if (param2.count_inbox != null)
            {
                this.count_inbox = param2.count_inbox;
            }// end if
            if (param2.count_system != null)
            {
                this.count_system = param2.count_system;
            }// end if
            return;
        }// end function

        public function copyTo(param1:NewMail) : void
        {
            param1.count = this.count;
            param1.count_inbox = this.count_inbox;
            param1.count_system = this.count_system;
            return;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "count = " + this.count + "\n");
            _loc_2 = _loc_2 + (param1 + "count_inbox = " + this.count_inbox + "\n");
            _loc_2 = _loc_2 + (param1 + "count_system = " + this.count_system + "\n");
            return _loc_2;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.count = this.count;
            _loc_1.count_inbox = this.count_inbox;
            _loc_1.count_system = this.count_system;
            return _loc_1;
        }// end function

    }
}
