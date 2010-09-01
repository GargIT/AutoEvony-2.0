package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.shop.*;

    public class ShopCommands extends Object
    {
        public var _useCastleGoods_callback:Function;
        public var _buyResource_callback:Function;
        private var sender:Sender;
        public var _useGoods_callback:Function;
        public var _getBuyResourceInfo_callback:Function;
        public var _buy_callback:Function;

        public function ShopCommands()
        {
            return;
        }// end function

        public function useCastleGoods(param1:int, param2:String, param3:Function = null) : CommandResponse
        {
            this._useCastleGoods_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.itemId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("shop.useCastleGoods", _loc_4);
            }// end if
            return null;
        }// end function

        public function buy(param1:String, param2:int, param3:Function = null) : CommandResponse
        {
            this._buy_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.itemId = param1;
            _loc_4.amount = param2;
            if (this.sender != null)
            {
                sender.sendMessage("shop.buy", _loc_4);
            }// end if
            return null;
        }// end function

        public function useGoods(param1:int, param2:String, param3:int, param4:Function = null) : UseItemResultResponse
        {
            this._useGoods_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.itemId = param2;
            _loc_5.num = param3;
            if (this.sender != null)
            {
                sender.sendMessage("shop.useGoods", _loc_5);
            }// end if
            return null;
        }// end function

        public function getBuyResourceInfo(param1:int, param2:Function = null) : BuyResourceInfoResponse
        {
            this._getBuyResourceInfo_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("shop.getBuyResourceInfo", _loc_3);
            }// end if
            return null;
        }// end function

        public function buyResource(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Function = null) : CommandResponse
        {
            this._buyResource_callback = param6;
            var _loc_7:* = new Object();
            _loc_7.castleId = param1;
            _loc_7.foodUse = param2;
            _loc_7.woodUse = param3;
            _loc_7.ironUse = param4;
            _loc_7.stoneUse = param5;
            if (this.sender != null)
            {
                sender.sendMessage("shop.buyResource", _loc_7);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

    }
}
