package com.umge.sovt.common.module.alliance
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;
    import mx.collections.*;

    public class AllianceUserAddResponse extends BaseBean
    {
        public var packageId:Number;
        public var msg:String;
        public var allianceAddPlayerByUserInfoBeanListArray:ArrayCollection;
        public var errorMsg:String;
        public var ok:int;

        public function AllianceUserAddResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            var _loc_6:AllianceAddPlayerByUserInfoBean;
            allianceAddPlayerByUserInfoBeanListArray = new ArrayCollection();
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
            if (param2.allianceAddPlayerByUserInfoBeanList)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.allianceAddPlayerByUserInfoBeanList.length)
                {
                    // label
                    _loc_6 = new AllianceAddPlayerByUserInfoBean(param2.allianceAddPlayerByUserInfoBeanList[_loc_5]);
                    this.allianceAddPlayerByUserInfoBeanListArray.addItem(_loc_6);
                    _loc_5++;
                }// end while
            }// end if
            return;
        }// end function

        public function setAllianceAddPlayerByUserInfoBeanList(param1:AllianceAddPlayerByUserInfoBean, param2:int) : void
        {
            this.allianceAddPlayerByUserInfoBeanListArray[param2] = param1;
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
            while (_loc_3 < this.allianceAddPlayerByUserInfoBeanListArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getAllianceAddPlayerByUserInfoBeanList(_loc_3).toDebugString(param1 + "allianceAddPlayerByUserInfoBeanList[" + _loc_3 + "].");
                _loc_3++;
            }// end while
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

        public function copyTo(param1:AllianceUserAddResponse) : void
        {
            param1.errorMsg = this.errorMsg;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.allianceAddPlayerByUserInfoBeanListArray, param1.allianceAddPlayerByUserInfoBeanListArray);
            return;
        }// end function

        public function getAllianceAddPlayerByUserInfoBeanList(param1:int) : AllianceAddPlayerByUserInfoBean
        {
            var _loc_2:* = this.allianceAddPlayerByUserInfoBeanListArray[param1] as AllianceAddPlayerByUserInfoBean;
            return _loc_2;
        }// end function

    }
}
