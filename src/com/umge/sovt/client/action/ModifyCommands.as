package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.gamemaster.*;

    public class ModifyCommands extends Object
    {
        public var _removeHero_callback:Function;
        public var _removeBuilding_callback:Function;
        public var _removeItem_callback:Function;
        public var _setTechnology_callback:Function;
        public var _setResources_callback:Function;
        public var _addItems_callback:Function;
        public var _addHero_callback:Function;
        public var _addBuilding_callback:Function;
        private var sender:Sender;

        public function ModifyCommands()
        {
            return;
        }// end function

        public function removeBuilding(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._removeBuilding_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.position = param2;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.removeBuilding", _loc_4);
            }// end if
            return null;
        }// end function

        public function setTechnology(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._setTechnology_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.technologyType = param1;
            _loc_4.level = param2;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.setTechnology", _loc_4);
            }// end if
            return null;
        }// end function

        public function removeHero(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._removeHero_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.heroId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.removeHero", _loc_4);
            }// end if
            return null;
        }// end function

        public function addItems(param1:String, param2:int, param3:Function = null) : CommandResponse
        {
            this._addItems_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.type = param1;
            _loc_4.amount = param2;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.addItems", _loc_4);
            }// end if
            return null;
        }// end function

        public function setResources(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Function = null) : CommandResponse
        {
            this._setResources_callback = param8;
            var _loc_9:* = new Object();
            _loc_9.castleId = param1;
            _loc_9.wood = param2;
            _loc_9.iron = param3;
            _loc_9.stone = param4;
            _loc_9.food = param5;
            _loc_9.gold = param6;
            _loc_9.population = param7;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.setResources", _loc_9);
            }// end if
            return null;
        }// end function

        public function addBuilding(param1:int, param2:int, param3:int, param4:int, param5:Function = null) : CommandResponse
        {
            this._addBuilding_callback = param5;
            var _loc_6:* = new Object();
            _loc_6.castleId = param1;
            _loc_6.buildingType = param2;
            _loc_6.position = param3;
            _loc_6.level = param4;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.addBuilding", _loc_6);
            }// end if
            return null;
        }// end function

        public function removeItem(param1:String, param2:Function = null) : CommandResponse
        {
            this._removeItem_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.type = param1;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.removeItem", _loc_3);
            }// end if
            return null;
        }// end function

        public function addHero(param1:int, param2:String, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:Function = null) : CreateHeroResponse
        {
            this._addHero_callback = param11;
            var _loc_12:* = new Object();
            _loc_12.castleId = param1;
            _loc_12.name = param2;
            _loc_12.level = param3;
            _loc_12.experience = param4;
            _loc_12.loyalty = param5;
            _loc_12.status = param6;
            _loc_12.management = param7;
            _loc_12.power = param8;
            _loc_12.stratagem = param9;
            _loc_12.remain = param10;
            if (this.sender != null)
            {
                sender.sendMessage("gamemaster.addHero", _loc_12);
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
