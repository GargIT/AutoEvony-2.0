package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;

    public class KickedOut extends BaseBean
    {
        public var ip:String;

        public function KickedOut(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.ip != null)
            {
                this.ip = param2.ip;
            }// end if
            return;
        }// end function

        public function copyTo(param1:KickedOut) : void
        {
            param1.ip = this.ip;
            return;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "ip = " + this.ip + "\n");
            return _loc_2;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.ip = this.ip;
            return _loc_1;
        }// end function

    }
}
