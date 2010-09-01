package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class InjuredTroopUpdate extends BaseBean
    {
        public var troop:TroopBean;
        public var castleId:int;
        public var goldNeed:int;

        public function InjuredTroopUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.castleId != null)
            {
                this.castleId = param2.castleId;
            }// end if
            if (param2.goldNeed != null)
            {
                this.goldNeed = param2.goldNeed;
            }// end if
            if (param2.troop != null)
            {
                this.troop = new TroopBean(param2.troop);
            }// end if
            return;
        }// end function

        public function copyTo(param1:InjuredTroopUpdate) : void
        {
            param1.castleId = this.castleId;
            param1.goldNeed = this.goldNeed;
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
            _loc_1.castleId = this.castleId;
            _loc_1.goldNeed = this.goldNeed;
            _loc_1.troop = this.troop.toObject();
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "castleId = " + this.castleId + "\n");
            _loc_2 = _loc_2 + (param1 + "goldNeed = " + this.goldNeed + "\n");
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
