package com.umge.sovt.common.module.army
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class ArmyPracticeResponse extends BaseBean
    {
        public var msg:String;
        public var attackLostTroop:TroopBean;
        public var packageId:Number;
        public var round:int;
        public var defendLostTroop:TroopBean;
        public var errorMsg:String;
        public var ok:int;
        public var result:int;
        public static const ARMY_PRACTICE_RESULT_GUARD_WIN:int = -1;
        public static const ARMY_PRACTICE_RESULT_ATTACK_WIN:int = 1;

        public function ArmyPracticeResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.attackLostTroop != null)
            {
                this.attackLostTroop = new TroopBean(param2.attackLostTroop);
            }// end if
            if (param2.defendLostTroop != null)
            {
                this.defendLostTroop = new TroopBean(param2.defendLostTroop);
            }// end if
            if (param2.errorMsg != null)
            {
                this.errorMsg = param2.errorMsg;
            }// end if
            if (param2.msg != null)
            {
                this.msg = param2.msg;
            }// end if
            if (param2.ok != null)
            {
                this.ok = param2.ok;
            }// end if
            if (param2.packageId != null)
            {
                this.packageId = param2.packageId;
            }// end if
            if (param2.result != null)
            {
                this.result = param2.result;
            }// end if
            if (param2.round != null)
            {
                this.round = param2.round;
            }// end if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.attackLostTroop = this.attackLostTroop.toObject();
            _loc_1.defendLostTroop = this.defendLostTroop.toObject();
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.msg = this.msg;
            _loc_1.ok = this.ok;
            _loc_1.packageId = this.packageId;
            _loc_1.result = this.result;
            _loc_1.round = this.round;
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            if (attackLostTroop != null)
            {
                _loc_2 = _loc_2 + this.attackLostTroop.toDebugString(param1 + "attackLostTroop.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "attackLostTroop = null\n");
            }// end else if
            if (defendLostTroop != null)
            {
                _loc_2 = _loc_2 + this.defendLostTroop.toDebugString(param1 + "defendLostTroop.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "defendLostTroop = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "errorMsg = " + this.errorMsg + "\n");
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "ok = " + this.ok + "\n");
            _loc_2 = _loc_2 + (param1 + "packageId = " + this.packageId + "\n");
            _loc_2 = _loc_2 + (param1 + "result = " + this.result + "\n");
            _loc_2 = _loc_2 + (param1 + "round = " + this.round + "\n");
            return _loc_2;
        }// end function

        public function copyTo(param1:ArmyPracticeResponse) : void
        {
            if (attackLostTroop != null)
            {
                this.attackLostTroop.copyTo(param1.attackLostTroop);
            }
            else
            {
                param1.attackLostTroop = null;
            }// end else if
            if (defendLostTroop != null)
            {
                this.defendLostTroop.copyTo(param1.defendLostTroop);
            }
            else
            {
                param1.defendLostTroop = null;
            }// end else if
            param1.errorMsg = this.errorMsg;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            param1.result = this.result;
            param1.round = this.round;
            return;
        }// end function

    }
}
