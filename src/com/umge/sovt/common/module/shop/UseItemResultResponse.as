package com.umge.sovt.common.module.shop
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;
    import mx.collections.*;

    public class UseItemResultResponse extends BaseBean
    {
        public var packageId:Number;
        public var msg:String;
        public var itemBeansArray:ArrayCollection;
        public var gamblingItemsBeansArray:ArrayCollection;
        public var errorMsg:String;
        public var ok:int;

        public function UseItemResultResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            var _loc_6:GamblingItemBean;
            var _loc_7:ItemBean;
            gamblingItemsBeansArray = new ArrayCollection();
            itemBeansArray = new ArrayCollection();
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
            if (param2.gamblingItemsBeans)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.gamblingItemsBeans.length)
                {
                    // label
                    _loc_6 = new GamblingItemBean(param2.gamblingItemsBeans[_loc_5]);
                    this.gamblingItemsBeansArray.addItem(_loc_6);
                    _loc_5++;
                }// end while
            }// end if
            if (param2.itemBeans)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.itemBeans.length)
                {
                    // label
                    _loc_7 = new ItemBean(param2.itemBeans[_loc_5]);
                    this.itemBeansArray.addItem(_loc_7);
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

        public function getItemBeans(param1:int) : ItemBean
        {
            var _loc_2:* = this.itemBeansArray[param1] as ItemBean;
            return _loc_2;
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
            while (_loc_3 < this.gamblingItemsBeansArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getGamblingItemsBeans(_loc_3).toDebugString(param1 + "gamblingItemsBeans[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.itemBeansArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getItemBeans(_loc_3).toDebugString(param1 + "itemBeans[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function setGamblingItemsBeans(param1:GamblingItemBean, param2:int) : void
        {
            this.gamblingItemsBeansArray[param2] = param1;
            return;
        }// end function

        public function setItemBeans(param1:ItemBean, param2:int) : void
        {
            this.itemBeansArray[param2] = param1;
            return;
        }// end function

        public function copyTo(param1:UseItemResultResponse) : void
        {
            param1.errorMsg = this.errorMsg;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.gamblingItemsBeansArray, param1.gamblingItemsBeansArray);
            CommonUtil.arrayCopy(this.itemBeansArray, param1.itemBeansArray);
            return;
        }// end function

        public function getGamblingItemsBeans(param1:int) : GamblingItemBean
        {
            var _loc_2:* = this.gamblingItemsBeansArray[param1] as GamblingItemBean;
            return _loc_2;
        }// end function

    }
}
