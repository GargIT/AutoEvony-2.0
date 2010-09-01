package com.umge.sovt.common.module.trade
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;
    import mx.collections.*;

    public class SearchTradesResponse extends BaseBean
    {
        public var buyersArray:ArrayCollection;
        public var packageId:Number;
        public var sellersArray:ArrayCollection;
        public var msg:String;
        public var errorMsg:String;
        public var ok:int;

        public function SearchTradesResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            var _loc_6:MarketTradeBean;
            var _loc_7:MarketTradeBean;
            buyersArray = new ArrayCollection();
            sellersArray = new ArrayCollection();
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
            if (param2.buyers)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.buyers.length)
                {
                    // label
                    _loc_6 = new MarketTradeBean(param2.buyers[_loc_5]);
                    this.buyersArray.addItem(_loc_6);
                    _loc_5++;
                }// end while
            }// end if
            if (param2.sellers)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.sellers.length)
                {
                    // label
                    _loc_7 = new MarketTradeBean(param2.sellers[_loc_5]);
                    this.sellersArray.addItem(_loc_7);
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
            while (_loc_3 < this.buyersArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getBuyers(_loc_3).toDebugString(param1 + "buyers[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.sellersArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getSellers(_loc_3).toDebugString(param1 + "sellers[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function copyTo(param1:SearchTradesResponse) : void
        {
            param1.errorMsg = this.errorMsg;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.buyersArray, param1.buyersArray);
            CommonUtil.arrayCopy(this.sellersArray, param1.sellersArray);
            return;
        }// end function

        public function setSellers(param1:MarketTradeBean, param2:int) : void
        {
            this.sellersArray[param2] = param1;
            return;
        }// end function

        public function getBuyers(param1:int) : MarketTradeBean
        {
            var _loc_2:* = this.buyersArray[param1] as MarketTradeBean;
            return _loc_2;
        }// end function

        public function setBuyers(param1:MarketTradeBean, param2:int) : void
        {
            this.buyersArray[param2] = param1;
            return;
        }// end function

        public function getSellers(param1:int) : MarketTradeBean
        {
            var _loc_2:* = this.sellersArray[param1] as MarketTradeBean;
            return _loc_2;
        }// end function

    }
}
