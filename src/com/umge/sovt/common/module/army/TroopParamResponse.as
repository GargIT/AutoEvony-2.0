package com.umge.sovt.common.module.army
{
    import com.umge.sovt.common.*;

    public class TroopParamResponse extends BaseBean
    {
        public var msg:String;
        public var loadSkillParam:int;
        public var driveSkillParam:int;
        public var packageId:Number;
        public var errorMsg:String;
        public var transportStationParam:int;
        public var ok:int;
        public var marchSkillParam:int;

        public function TroopParamResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.driveSkillParam != null)
            {
                this.driveSkillParam = param2.driveSkillParam;
            }// end if
            if (param2.errorMsg != null)
            {
                this.errorMsg = param2.errorMsg;
            }// end if
            if (param2.loadSkillParam != null)
            {
                this.loadSkillParam = param2.loadSkillParam;
            }// end if
            if (param2.marchSkillParam != null)
            {
                this.marchSkillParam = param2.marchSkillParam;
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
            if (param2.transportStationParam != null)
            {
                this.transportStationParam = param2.transportStationParam;
            }// end if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.driveSkillParam = this.driveSkillParam;
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.loadSkillParam = this.loadSkillParam;
            _loc_1.marchSkillParam = this.marchSkillParam;
            _loc_1.msg = this.msg;
            _loc_1.ok = this.ok;
            _loc_1.packageId = this.packageId;
            _loc_1.transportStationParam = this.transportStationParam;
            return _loc_1;
        }// end function

        public function copyTo(param1:TroopParamResponse) : void
        {
            param1.driveSkillParam = this.driveSkillParam;
            param1.errorMsg = this.errorMsg;
            param1.loadSkillParam = this.loadSkillParam;
            param1.marchSkillParam = this.marchSkillParam;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            param1.transportStationParam = this.transportStationParam;
            return;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "driveSkillParam = " + this.driveSkillParam + "\n");
            _loc_2 = _loc_2 + (param1 + "errorMsg = " + this.errorMsg + "\n");
            _loc_2 = _loc_2 + (param1 + "loadSkillParam = " + this.loadSkillParam + "\n");
            _loc_2 = _loc_2 + (param1 + "marchSkillParam = " + this.marchSkillParam + "\n");
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "ok = " + this.ok + "\n");
            _loc_2 = _loc_2 + (param1 + "packageId = " + this.packageId + "\n");
            _loc_2 = _loc_2 + (param1 + "transportStationParam = " + this.transportStationParam + "\n");
            return _loc_2;
        }// end function

    }
}
