package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.city.*;

    public class CityCommands extends Object
    {
        public var _advMoveCastle_callback:Function;
        public var _modifyCastleName_callback:Function;
        public var _modifyUserName_callback:Function;
        public var _moveCastle_callback:Function;
        public var _modifyFlag_callback:Function;
        public var _giveupCastle_callback:Function;
        public var _getStoreList_callback:Function;
        public var _modifyStorePercent_callback:Function;
        public var _constructCastle_callback:Function;
        private var sender:Sender;
        public var _setStopWarState_callback:Function;

        public function CityCommands()
        {
            return;
        }// end function

        public function giveupCastle(param1:String, param2:int, param3:Function = null) : CommandResponse
        {
            this._giveupCastle_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.password = param1;
            _loc_4.castleId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("city.giveupCastle", _loc_4);
            }// end if
            return null;
        }// end function

        public function modifyStorePercent(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Function = null) : CommandResponse
        {
            this._modifyStorePercent_callback = param6;
            var _loc_7:* = new Object();
            _loc_7.castleId = param1;
            _loc_7.foodrate = param2;
            _loc_7.woodrate = param3;
            _loc_7.stonerate = param4;
            _loc_7.ironrate = param5;
            if (this.sender != null)
            {
                sender.sendMessage("city.modifyStorePercent", _loc_7);
            }// end if
            return null;
        }// end function

        public function modifyFlag(param1:String, param2:Function = null) : CommandResponse
        {
            this._modifyFlag_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.newFlag = param1;
            if (this.sender != null)
            {
                sender.sendMessage("city.modifyFlag", _loc_3);
            }// end if
            return null;
        }// end function

        public function modifyUserName(param1:String, param2:String, param3:Function = null) : CommandResponse
        {
            this._modifyUserName_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.userName = param1;
            _loc_4.itemId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("city.modifyUserName", _loc_4);
            }// end if
            return null;
        }// end function

        public function getStoreList(param1:int, param2:Function = null) : StoreListResponse
        {
            this._getStoreList_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("city.getStoreList", _loc_3);
            }// end if
            return null;
        }// end function

        public function setStopWarState(param1:String, param2:String, param3:Function = null) : CommandResponse
        {
            this._setStopWarState_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.ItemId = param1;
            _loc_4.passWord = param2;
            if (this.sender != null)
            {
                sender.sendMessage("city.setStopWarState", _loc_4);
            }// end if
            return null;
        }// end function

        public function constructCastle(param1:int, param2:int, param3:Boolean, param4:Function = null) : CommandResponse
        {
            this._constructCastle_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.fieldId = param2;
            _loc_5.isTroopBack = param3;
            if (this.sender != null)
            {
                sender.sendMessage("city.constructCastle", _loc_5);
            }// end if
            return null;
        }// end function

        public function moveCastle(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._moveCastle_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.zoneId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("city.moveCastle", _loc_4);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

        public function advMoveCastle(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._advMoveCastle_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.targetId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("city.advMoveCastle", _loc_4);
            }// end if
            return null;
        }// end function

        public function modifyCastleName(param1:int, param2:String, param3:String, param4:Function = null) : CommandResponse
        {
            this._modifyCastleName_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.name = param2;
            _loc_5.logUrl = param3;
            if (this.sender != null)
            {
                sender.sendMessage("city.modifyCastleName", _loc_5);
            }// end if
            return null;
        }// end function

    }
}
