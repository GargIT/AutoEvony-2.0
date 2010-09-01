package com.umge.sovt.common.module.alliance
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;
    import mx.collections.*;

    public class AllianceInviteBeanResponse extends BaseBean
    {
        public var packageId:Number;
        public var msg:String;
        public var allianceAddPlayerInfoBeanListArray:ArrayCollection;
        public var errorMsg:String;
        public var ok:int;

        public function AllianceInviteBeanResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            var _loc_6:AllianceAddPlayerInfoBean;
            allianceAddPlayerInfoBeanListArray = new ArrayCollection();
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
            if (param2.allianceAddPlayerInfoBeanList)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.allianceAddPlayerInfoBeanList.length)
                {
                    // label
                    _loc_6 = new AllianceAddPlayerInfoBean(param2.allianceAddPlayerInfoBeanList[_loc_5]);
                    this.allianceAddPlayerInfoBeanListArray.addItem(_loc_6);
                    _loc_5++;
                }// end while
            }// end if
            return;
        }// end function

        public function setAllianceAddPlayerInfoBeanList(param1:AllianceAddPlayerInfoBean, param2:int) : void
        {
            this.allianceAddPlayerInfoBeanListArray[param2] = param1;
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
            _loc_3 = 0;
            while (_loc_3 < this.allianceAddPlayerInfoBeanListArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getAllianceAddPlayerInfoBeanList(_loc_3).toDebugString(param1 + "allianceAddPlayerInfoBeanList[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function copyTo(param1:AllianceInviteBeanResponse) : void
        {
            param1.errorMsg = this.errorMsg;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.allianceAddPlayerInfoBeanListArray, param1.allianceAddPlayerInfoBeanListArray);
            return;
        }// end function

        public function getAllianceAddPlayerInfoBeanList(param1:int) : AllianceAddPlayerInfoBean
        {
            var _loc_2:* = this.allianceAddPlayerInfoBeanListArray[param1] as AllianceAddPlayerInfoBean;
            return _loc_2;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.msg = this.msg;
            _loc_1.ok = this.ok;
            _loc_1.packageId = this.packageId;
            return _loc_1;
        }// end function

    }
}
