package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.trade.*;

    public class TradeCommands extends Object
    {
        public var _newTrade_callback:Function;
        public var _getMyTradeList_callback:Function;
        public var _searchTrades_callback:Function;
        public var _getTransingTradeList_callback:Function;
        private var sender:Sender;
        public var _cancelTrade_callback:Function;
        public var _speedUpTrans_callback:Function;

        public function TradeCommands()
        {
            return;
        }// end function

        public function getMyTradeList(param1:int, param2:Function = null) : TradeListResponse
        {
            this._getMyTradeList_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("trade.getMyTradeList", _loc_3);
            }// end if
            return null;
        }// end function

        public function newTrade(param1:int, param2:int, param3:int, param4:int, param5:String, param6:Function = null) : CommandResponse
        {
            this._newTrade_callback = param6;
            var _loc_7:* = new Object();
            _loc_7.castleId = param1;
            _loc_7.resType = param2;
            _loc_7.tradeType = param3;
            _loc_7.amount = param4;
            _loc_7.price = param5;
            if (this.sender != null)
            {
                sender.sendMessage("trade.newTrade", _loc_7);
            }// end if
            return null;
        }// end function

        public function cancelTrade(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._cancelTrade_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.tradeId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("trade.cancelTrade", _loc_4);
            }// end if
            return null;
        }// end function

        public function speedUpTrans(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
        {
            this._speedUpTrans_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.transingTradeId = param2;
            _loc_5.itemId = param3;
            if (this.sender != null)
            {
                sender.sendMessage("trade.speedUpTrans", _loc_5);
            }// end if
            return null;
        }// end function

        public function searchTrades(param1:int, param2:Function = null) : SearchTradesResponse
        {
            this._searchTrades_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.resType = param1;
            if (this.sender != null)
            {
                sender.sendMessage("trade.searchTrades", _loc_3);
            }// end if
            return null;
        }// end function

        public function getTransingTradeList(param1:int, param2:Function = null) : TransingTradeListResponse
        {
            this._getTransingTradeList_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("trade.getTransingTradeList", _loc_3);
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
