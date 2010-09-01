package com.umge.sovt.common.module.castle
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class CheckOutBuildingResponse extends BaseBean
    {
        public var packageId:Number;
        public var msg:String;
        public var conditionBean:ConditionBean;
        public var errorMsg:String;
        public var ok:int;

        public function CheckOutBuildingResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.conditionBean != null)
            {
                this.conditionBean = new ConditionBean(param2.conditionBean);
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
            if (conditionBean != null)
            {
                _loc_2 = _loc_2 + this.conditionBean.toDebugString(param1 + "conditionBean.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "conditionBean = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "errorMsg = " + this.errorMsg + "\n");
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "ok = " + this.ok + "\n");
            _loc_2 = _loc_2 + (param1 + "packageId = " + this.packageId + "\n");
            return _loc_2;
        }// end function

        public function copyTo(param1:CheckOutBuildingResponse) : void
        {
            if (conditionBean != null)
            {
                this.conditionBean.copyTo(param1.conditionBean);
            }
            else
            {
                param1.conditionBean = null;
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
            _loc_1.conditionBean = this.conditionBean.toObject();
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.msg = this.msg;
            _loc_1.ok = this.ok;
            _loc_1.packageId = this.packageId;
            return _loc_1;
        }// end function

    }
}
