package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;

    public class NewReport extends BaseBean
    {
        public var other_count:int;
        public var trade_count:int;
        public var army_count:int;
        public var count:int;

        public function NewReport(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.army_count != null)
            {
                this.army_count = param2.army_count;
            }// end if
            if (param2.count != null)
            {
                this.count = param2.count;
            }// end if
            if (param2.other_count != null)
            {
                this.other_count = param2.other_count;
            }// end if
            if (param2.trade_count != null)
            {
                this.trade_count = param2.trade_count;
            }// end if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.army_count = this.army_count;
            _loc_1.count = this.count;
            _loc_1.other_count = this.other_count;
            _loc_1.trade_count = this.trade_count;
            return _loc_1;
        }// end function

        public function copyTo(param1:NewReport) : void
        {
            param1.army_count = this.army_count;
            param1.count = this.count;
            param1.other_count = this.other_count;
            param1.trade_count = this.trade_count;
            return;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "army_count = " + this.army_count + "\n");
            _loc_2 = _loc_2 + (param1 + "count = " + this.count + "\n");
            _loc_2 = _loc_2 + (param1 + "other_count = " + this.other_count + "\n");
            _loc_2 = _loc_2 + (param1 + "trade_count = " + this.trade_count + "\n");
            return _loc_2;
        }// end function

    }
}
