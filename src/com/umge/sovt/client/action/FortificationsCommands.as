package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.fortifications.*;
    import com.umge.sovt.common.module.troop.*;

    public class FortificationsCommands extends Object
    {
        public var _produceWallProtect_callback:Function;
        public var _accTroopProduce_callback:Function;
        private var sender:Sender;
        public var _destructWallProtect_callback:Function;
        public var _getProduceQueue_callback:Function;
        public var _getFortificationsProduceList_callback:Function;
        public var _cancelFortificationProduce_callback:Function;

        public function FortificationsCommands()
        {
            return;
        }// end function

        public function getFortificationsProduceList(param1:int, param2:Function = null) : FortProduceListResponse
        {
            this._getFortificationsProduceList_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("fortifications.getFortificationsProduceList", _loc_3);
            }// end if
            return null;
        }// end function

        public function produceWallProtect(param1:int, param2:int, param3:int, param4:Function = null) : CommandResponse
        {
            this._produceWallProtect_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.wallProtectType = param2;
            _loc_5.num = param3;
            if (this.sender != null)
            {
                sender.sendMessage("fortifications.produceWallProtect", _loc_5);
            }// end if
            return null;
        }// end function

        public function cancelFortificationProduce(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._cancelFortificationProduce_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.queueId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("fortifications.cancelFortificationProduce", _loc_4);
            }// end if
            return null;
        }// end function

        public function destructWallProtect(param1:int, param2:int, param3:int, param4:Function = null) : CommandResponse
        {
            this._destructWallProtect_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.typeId = param2;
            _loc_5.num = param3;
            if (this.sender != null)
            {
                sender.sendMessage("fortifications.destructWallProtect", _loc_5);
            }// end if
            return null;
        }// end function

        public function accTroopProduce(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
        {
            this._accTroopProduce_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.queueId = param2;
            _loc_5.itemId = param3;
            if (this.sender != null)
            {
                sender.sendMessage("fortifications.accTroopProduce", _loc_5);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

        public function getProduceQueue(param1:int, param2:Function = null) : ProduceQueueResponse
        {
            this._getProduceQueue_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("fortifications.getProduceQueue", _loc_3);
            }// end if
            return null;
        }// end function

    }
}
