package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.troop.*;

    public class TroopCommands extends Object
    {
        public var _produceTroop_callback:Function;
        public var _accTroopProduce_callback:Function;
        public var _checkIdleBarrack_callback:Function;
        public var _getProduceQueue_callback:Function;
        public var _cancelTroopProduce_callback:Function;
        public var _getTroopProduceList_callback:Function;
        private var sender:Sender;
        public var _disbandTroop_callback:Function;

        public function TroopCommands()
        {
            return;
        }// end function

        public function getProduceQueue(param1:int, param2:Function = null) : ProduceQueueResponse
        {
            this._getProduceQueue_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("troop.getProduceQueue", _loc_3);
            }// end if
            return null;
        }// end function

        public function cancelTroopProduce(param1:int, param2:int, param3:int, param4:Function = null) : CommandResponse
        {
            this._cancelTroopProduce_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.positionId = param2;
            _loc_5.queueId = param3;
            if (this.sender != null)
            {
                sender.sendMessage("troop.cancelTroopProduce", _loc_5);
            }// end if
            return null;
        }// end function

        public function checkIdleBarrack(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._checkIdleBarrack_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.troopType = param2;
            if (this.sender != null)
            {
                sender.sendMessage("troop.checkIdleBarrack", _loc_4);
            }// end if
            return null;
        }// end function

        public function disbandTroop(param1:int, param2:int, param3:int, param4:Function = null) : CommandResponse
        {
            this._disbandTroop_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.troopType = param2;
            _loc_5.num = param3;
            if (this.sender != null)
            {
                sender.sendMessage("troop.disbandTroop", _loc_5);
            }// end if
            return null;
        }// end function

        public function produceTroop(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:Boolean, param7:Function = null) : CommandResponse
        {
            this._produceTroop_callback = param7;
            var _loc_8:* = new Object();
            _loc_8.castleId = param1;
            _loc_8.positionId = param2;
            _loc_8.troopType = param3;
            _loc_8.num = param4;
            _loc_8.isShare = param5;
            _loc_8.toIdle = param6;
            if (this.sender != null)
            {
                sender.sendMessage("troop.produceTroop", _loc_8);
            }// end if
            return null;
        }// end function

        public function accTroopProduce(param1:int, param2:int, param3:int, param4:String, param5:Function = null) : CommandResponse
        {
            this._accTroopProduce_callback = param5;
            var _loc_6:* = new Object();
            _loc_6.castleId = param1;
            _loc_6.positionId = param2;
            _loc_6.queueId = param3;
            _loc_6.itemId = param4;
            if (this.sender != null)
            {
                sender.sendMessage("troop.accTroopProduce", _loc_6);
            }// end if
            return null;
        }// end function

        public function getTroopProduceList(param1:int, param2:int, param3:Function = null) : TroopProduceListResponse
        {
            this._getTroopProduceList_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.positionId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("troop.getTroopProduceList", _loc_4);
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
