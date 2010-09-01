package com.umge.sovt.common.module.alliance
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class AllianceArmyResponse extends BaseBean
    {
        public var packageId:Number;
        public var msg:String;
        public var errorMsg:String;
        public var armyInfoBean:BettleResultBean;
        public var ok:int;

        public function AllianceArmyResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.armyInfoBean != null)
            {
                this.armyInfoBean = new BettleResultBean(param2.armyInfoBean);
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
            return;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            if (armyInfoBean != null)
            {
                _loc_2 = _loc_2 + this.armyInfoBean.toDebugString(param1 + "armyInfoBean.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "armyInfoBean = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "errorMsg = " + this.errorMsg + "\n");
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "ok = " + this.ok + "\n");
            _loc_2 = _loc_2 + (param1 + "packageId = " + this.packageId + "\n");
            return _loc_2;
        }// end function

        public function copyTo(param1:AllianceArmyResponse) : void
        {
            if (armyInfoBean != null)
            {
                this.armyInfoBean.copyTo(param1.armyInfoBean);
            }
            else
            {
                param1.armyInfoBean = null;
            }// end else if
            param1.errorMsg = this.errorMsg;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.armyInfoBean = this.armyInfoBean.toObject();
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.msg = this.msg;
            _loc_1.ok = this.ok;
            _loc_1.packageId = this.packageId;
            return _loc_1;
        }// end function

    }
}
