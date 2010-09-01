package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.alliance.*;
    import com.umge.sovt.common.module.common.*;

    public class CommonCommands extends Object
    {
        public var _mapInfoSimple_callback:Function;
        public var _changeUserFace_callback:Function;
        public var _mapCastle_callback:Function;
        public var _getPackage_callback:Function;
        public var _allianceChat_callback:Function;
        public var _getPackageList_callback:Function;
        public var _mapInfo_callback:Function;
        public var _getPlayerInfoByName_callback:Function;
        public var _createNewPlayer_callback:Function;
        public var _privateChat_callback:Function;
        public var _zoneInfo_callback:Function;
        public var _channelChat_callback:Function;
        private var sender:Sender;
        public var _deleteUserAndRestart_callback:Function;
        public var _worldChat_callback:Function;

        public function CommonCommands()
        {
            return;
        }// end function

        public function mapInfo(param1:int, param2:int, param3:int, param4:int, param5:Function = null) : MapInfoResponse
        {
            this._mapInfo_callback = param5;
            var _loc_6:* = new Object();
            _loc_6.x1 = param1;
            _loc_6.y1 = param2;
            _loc_6.x2 = param3;
            _loc_6.y2 = param4;
            if (this.sender != null)
            {
                sender.sendMessage("common.mapInfo", _loc_6);
            }// end if
            return null;
        }// end function

        public function mapInfoSimple(param1:int, param2:int, param3:int, param4:int, param5:Function = null) : MapInfoSimpleResponse
        {
            this._mapInfoSimple_callback = param5;
            var _loc_6:* = new Object();
            _loc_6.x1 = param1;
            _loc_6.y1 = param2;
            _loc_6.x2 = param3;
            _loc_6.y2 = param4;
            if (this.sender != null)
            {
                sender.sendMessage("common.mapInfoSimple", _loc_6);
            }// end if
            return null;
        }// end function

        public function createNewPlayer(param1:String, param2:int, param3:String, param4:String, param5:String, param6:int, param7:Function = null) : CreatePlayerResponse
        {
            this._createNewPlayer_callback = param7;
            var _loc_8:* = new Object();
            _loc_8.userName = param1;
            _loc_8.sex = param2;
            _loc_8.faceUrl = param3;
            _loc_8.flag = param4;
            _loc_8.castleName = param5;
            _loc_8.zone = param6;
            if (this.sender != null)
            {
                sender.sendMessage("common.createNewPlayer", _loc_8);
            }// end if
            return null;
        }// end function

        public function deleteUserAndRestart(param1:String, param2:Function = null) : CommandResponse
        {
            this._deleteUserAndRestart_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.pwd = param1;
            if (this.sender != null)
            {
                sender.sendMessage("common.deleteUserAndRestart", _loc_3);
            }// end if
            return null;
        }// end function

        public function getPackage(param1:int, param2:String, param3:Function = null) : GetPackageResponse
        {
            this._getPackage_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.ruleId = param1;
            _loc_4.serial = param2;
            if (this.sender != null)
            {
                sender.sendMessage("common.getPackage", _loc_4);
            }// end if
            return null;
        }// end function

        public function privateChat(param1:String, param2:String, param3:Function = null) : ChatResponse
        {
            this._privateChat_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.targetName = param1;
            _loc_4.msg = param2;
            if (this.sender != null)
            {
                sender.sendMessage("common.privateChat", _loc_4);
            }// end if
            return null;
        }// end function

        public function worldChat(param1:String, param2:int, param3:Function = null) : ChatResponse
        {
            this._worldChat_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.msg = param1;
            _loc_4.languageType = param2;
            if (this.sender != null)
            {
                sender.sendMessage("common.worldChat", _loc_4);
            }// end if
            return null;
        }// end function

        public function changeUserFace(param1:String, param2:int, param3:Function = null) : ChangeUserFaceResponse
        {
            this._changeUserFace_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.faceUrl = param1;
            _loc_4.sex = param2;
            if (this.sender != null)
            {
                sender.sendMessage("common.changeUserFace", _loc_4);
            }// end if
            return null;
        }// end function

        public function getPackageList(param1:Function = null) : GetPackageListResponse
        {
            this._getPackageList_callback = param1;
            var _loc_2:* = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("common.getPackageList", _loc_2);
            }// end if
            return null;
        }// end function

        public function getPlayerInfoByName(param1:String, param2:Function = null) : PlayerInfoResponse
        {
            this._getPlayerInfoByName_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.userName = param1;
            if (this.sender != null)
            {
                sender.sendMessage("common.getPlayerInfoByName", _loc_3);
            }// end if
            return null;
        }// end function

        public function mapCastle(param1:int, param2:int, param3:int, param4:int, param5:Function = null) : MapCastleResponse
        {
            this._mapCastle_callback = param5;
            var _loc_6:* = new Object();
            _loc_6.x1 = param1;
            _loc_6.y1 = param2;
            _loc_6.x2 = param3;
            _loc_6.y2 = param4;
            if (this.sender != null)
            {
                sender.sendMessage("common.mapCastle", _loc_6);
            }// end if
            return null;
        }// end function

        public function allianceChat(param1:String, param2:int, param3:Function = null) : ChatResponse
        {
            this._allianceChat_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.msg = param1;
            _loc_4.languageType = param2;
            if (this.sender != null)
            {
                sender.sendMessage("common.allianceChat", _loc_4);
            }// end if
            return null;
        }// end function

        public function zoneInfo(param1:Function = null) : ZoneInfoResponse
        {
            this._zoneInfo_callback = param1;
            var _loc_2:* = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("common.zoneInfo", _loc_2);
            }// end if
            return null;
        }// end function

        public function channelChat(param1:String, param2:String, param3:int, param4:Function = null) : ChatResponse
        {
            this._channelChat_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.channel = param1;
            _loc_5.sendMsg = param2;
            _loc_5.languageType = param3;
            if (this.sender != null)
            {
                sender.sendMessage("common.channelChat", _loc_5);
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
