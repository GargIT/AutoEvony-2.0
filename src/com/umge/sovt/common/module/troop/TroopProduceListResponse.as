package com.umge.sovt.common.module.troop
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;
    import mx.collections.*;

    public class TroopProduceListResponse extends BaseBean
    {
        public var packageId:Number;
        public var msg:String;
        public var troopListArray:ArrayCollection;
        public var errorMsg:String;
        public var ok:int;

        public function TroopProduceListResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            var _loc_6:TroopProduceListBean;
            troopListArray = new ArrayCollection();
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
            if (param2.troopList)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.troopList.length)
                {
                    // label
                    _loc_6 = new TroopProduceListBean(param2.troopList[_loc_5]);
                    this.troopListArray.addItem(_loc_6);
                    _loc_5++;
                }// end while
            }// end if
            return;
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

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "errorMsg = " + this.errorMsg + "\n");
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "ok = " + this.ok + "\n");
            _loc_2 = _loc_2 + (param1 + "packageId = " + this.packageId + "\n");
            _loc_3 = 0;
            while (_loc_3 < this.troopListArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getTroopList(_loc_3).toDebugString(param1 + "troopList[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function setTroopList(param1:TroopProduceListBean, param2:int) : void
        {
            this.troopListArray[param2] = param1;
            return;
        }// end function

        public function copyTo(param1:TroopProduceListResponse) : void
        {
            param1.errorMsg = this.errorMsg;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.troopListArray, param1.troopListArray);
            return;
        }// end function

        public function getTroopList(param1:int) : TroopProduceListBean
        {
            var _loc_2:* = this.troopListArray[param1] as TroopProduceListBean;
            return _loc_2;
        }// end function

    }
}
