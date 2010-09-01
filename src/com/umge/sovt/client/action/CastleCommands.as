package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.castle.*;

    public class CastleCommands extends Object
    {
        public var _getAvailableBuildingListOutside_callback:Function;
        public var _getAvailableBuildingListInside_callback:Function;
        public var _speedUpBuildCommand_callback:Function;
        public var _getAvailableBuildingBean_callback:Function;
        public var _newBuilding_callback:Function;
        public var _upgradeBuilding_callback:Function;
        public var _getDestructBuildBean_callback:Function;
        public var _cancleBuildCommand_callback:Function;
        public var _getCoinsNeed_callback:Function;
        public var _checkOutUpgrade_callback:Function;
        private var sender:Sender;
        public var _destructBuilding_callback:Function;

        public function CastleCommands()
        {
            return;
        }// end function

        public function getAvailableBuildingListOutside(param1:int, param2:Function = null) : AvailableBuilingListResponse
        {
            this._getAvailableBuildingListOutside_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("castle.getAvailableBuildingListOutside", _loc_3);
            }// end if
            return null;
        }// end function

        public function getAvailableBuildingListInside(param1:int, param2:Function = null) : AvailableBuilingListResponse
        {
            this._getAvailableBuildingListInside_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("castle.getAvailableBuildingListInside", _loc_3);
            }// end if
            return null;
        }// end function

        public function getCoinsNeed(param1:int, param2:int, param3:Function = null) : CoinsNeedResponse
        {
            this._getCoinsNeed_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.positionId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.getCoinsNeed", _loc_4);
            }// end if
            return null;
        }// end function

        public function getDestructBuildBean(param1:int, param2:int, param3:Function = null) : AvailableBuilingListResponse
        {
            this._getDestructBuildBean_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.positionId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.getDestructBuildBean", _loc_4);
            }// end if
            return null;
        }// end function

        public function checkOutUpgrade(param1:int, param2:int, param3:Function = null) : CheckOutBuildingResponse
        {
            this._checkOutUpgrade_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.positionId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.checkOutUpgrade", _loc_4);
            }// end if
            return null;
        }// end function

        public function getAvailableBuildingBean(param1:int, param2:int, param3:Function = null) : AvailableBuilingListResponse
        {
            this._getAvailableBuildingBean_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.typeId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.getAvailableBuildingBean", _loc_4);
            }// end if
            return null;
        }// end function

        public function speedUpBuildCommand(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
        {
            this._speedUpBuildCommand_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.positionId = param2;
            _loc_5.itemId = param3;
            if (this.sender != null)
            {
                sender.sendMessage("castle.speedUpBuildCommand", _loc_5);
            }// end if
            return null;
        }// end function

        public function cancleBuildCommand(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._cancleBuildCommand_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.positionId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.cancleBuildCommand", _loc_4);
            }// end if
            return null;
        }// end function

        public function upgradeBuilding(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._upgradeBuilding_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.positionId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.upgradeBuilding", _loc_4);
            }// end if
            return null;
        }// end function

        public function destructBuilding(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._destructBuilding_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.positionId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("castle.destructBuilding", _loc_4);
            }// end if
            return null;
        }// end function

        public function newBuilding(param1:int, param2:int, param3:int, param4:Function = null) : CommandResponse
        {
            this._newBuilding_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.positionId = param2;
            _loc_5.buildingType = param3;
            if (this.sender != null)
            {
                sender.sendMessage("castle.newBuilding", _loc_5);
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
