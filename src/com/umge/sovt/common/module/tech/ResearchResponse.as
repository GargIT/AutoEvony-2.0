package com.umge.sovt.common.module.tech
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class ResearchResponse extends BaseBean
    {
        public var packageId:Number;
        public var msg:String;
        public var tech:AvailableResearchListBean;
        public var errorMsg:String;
        public var ok:int;

        public function ResearchResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
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
            if (param2.tech != null)
            {
                this.tech = new AvailableResearchListBean(param2.tech);
            }// end if
            return;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "errorMsg = " + this.errorMsg + "\n");
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "ok = " + this.ok + "\n");
            _loc_2 = _loc_2 + (param1 + "packageId = " + this.packageId + "\n");
            if (tech != null)
            {
                _loc_2 = _loc_2 + this.tech.toDebugString(param1 + "tech.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "tech = null\n");
            }// end else if
            return _loc_2;
        }// end function

        public function copyTo(param1:ResearchResponse) : void
        {
            param1.errorMsg = this.errorMsg;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            if (tech != null)
            {
                this.tech.copyTo(param1.tech);
            }
            else
            {
                param1.tech = null;
            }// end else if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.msg = this.msg;
            _loc_1.ok = this.ok;
            _loc_1.packageId = this.packageId;
            _loc_1.tech = this.tech.toObject();
            return _loc_1;
        }// end function

    }
}
