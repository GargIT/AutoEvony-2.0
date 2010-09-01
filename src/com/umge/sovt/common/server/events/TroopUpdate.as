package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class TroopUpdate extends BaseBean
    {
        public var troop:TroopBean;
        public var caslteId:int;

        public function TroopUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.caslteId != null)
            {
                this.caslteId = param2.caslteId;
            }// end if
            if (param2.troop != null)
            {
                this.troop = new TroopBean(param2.troop);
            }// end if
            return;
        }// end function

        public function copyTo(param1:TroopUpdate) : void
        {
            param1.caslteId = this.caslteId;
            if (troop != null)
            {
                this.troop.copyTo(param1.troop);
            }
            else
            {
                param1.troop = null;
            }// end else if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.caslteId = this.caslteId;
            _loc_1.troop = this.troop.toObject();
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "caslteId = " + this.caslteId + "\n");
            if (troop != null)
            {
                _loc_2 = _loc_2 + this.troop.toDebugString(param1 + "troop.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "troop = null\n");
            }// end else if
            return _loc_2;
        }// end function

    }
}
