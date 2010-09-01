package com.umge.sovt.common.module.alliance
{
    import com.umge.sovt.common.*;

    public class AllianceInfoResponse extends BaseBean
    {
        public var errorMsg:String;
        public var msg:String;
        public var packageId:Number;
        public var leader:String;
        public var allinaceInfo:String;
        public var creator:String;
        public var memberCount:int;
        public var prestigeCount:int;
        public var ok:int;
        public var ranking:int;

        public function AllianceInfoResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.allinaceInfo != null)
            {
                this.allinaceInfo = param2.allinaceInfo;
            }// end if
            if (param2.creator != null)
            {
                this.creator = param2.creator;
            }// end if
            if (param2.errorMsg != null)
            {
                this.errorMsg = param2.errorMsg;
            }// end if
            if (param2.leader != null)
            {
                this.leader = param2.leader;
            }// end if
            if (param2.memberCount != null)
            {
                this.memberCount = param2.memberCount;
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
            if (param2.prestigeCount != null)
            {
                this.prestigeCount = param2.prestigeCount;
            }// end if
            if (param2.ranking != null)
            {
                this.ranking = param2.ranking;
            }// end if
            return;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "allinaceInfo = " + this.allinaceInfo + "\n");
            _loc_2 = _loc_2 + (param1 + "creator = " + this.creator + "\n");
            _loc_2 = _loc_2 + (param1 + "errorMsg = " + this.errorMsg + "\n");
            _loc_2 = _loc_2 + (param1 + "leader = " + this.leader + "\n");
            _loc_2 = _loc_2 + (param1 + "memberCount = " + this.memberCount + "\n");
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "ok = " + this.ok + "\n");
            _loc_2 = _loc_2 + (param1 + "packageId = " + this.packageId + "\n");
            _loc_2 = _loc_2 + (param1 + "prestigeCount = " + this.prestigeCount + "\n");
            _loc_2 = _loc_2 + (param1 + "ranking = " + this.ranking + "\n");
            return _loc_2;
        }// end function

        public function copyTo(param1:AllianceInfoResponse) : void
        {
            param1.allinaceInfo = this.allinaceInfo;
            param1.creator = this.creator;
            param1.errorMsg = this.errorMsg;
            param1.leader = this.leader;
            param1.memberCount = this.memberCount;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            param1.prestigeCount = this.prestigeCount;
            param1.ranking = this.ranking;
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.allinaceInfo = this.allinaceInfo;
            _loc_1.creator = this.creator;
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.leader = this.leader;
            _loc_1.memberCount = this.memberCount;
            _loc_1.msg = this.msg;
            _loc_1.ok = this.ok;
            _loc_1.packageId = this.packageId;
            _loc_1.prestigeCount = this.prestigeCount;
            _loc_1.ranking = this.ranking;
            return _loc_1;
        }// end function

    }
}
