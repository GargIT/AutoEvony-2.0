package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.hero.*;

    public class HeroCommand extends Object
    {
        public var _getHerosListFromTavern_callback:Function;
        public var _awardGold_callback:Function;
        public var _refreshHerosListFromTavern_callback:Function;
        public var _releaseHero_callback:Function;
        public var _callBackHero_callback:Function;
        public var _useItem_callback:Function;
        public var _fireHero_callback:Function;
        public var _addPoint_callback:Function;
        public var _hireHero_callback:Function;
        public var _tryGetSeizedHero_callback:Function;
        public var _dischargeChief_callback:Function;
        public var _levelUp_callback:Function;
        public var _resetPoint_callback:Function;
        public var _changeName_callback:Function;
        private var sender:Sender;
        public var _promoteToChief_callback:Function;

        public function HeroCommand()
        {
            return;
        }// end function

        public function resetPoint(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._resetPoint_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.heroId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.resetPoint", _loc_4);
            }// end if
            return null;
        }// end function

        public function getHerosListFromTavern(param1:int, param2:Function = null) : HeroListResponse
        {
            this._getHerosListFromTavern_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("hero.getHerosListFromTavern", _loc_3);
            }// end if
            return null;
        }// end function

        public function tryGetSeizedHero(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._tryGetSeizedHero_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.heroId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.tryGetSeizedHero", _loc_4);
            }// end if
            return null;
        }// end function

        public function changeName(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
        {
            this._changeName_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.heroId = param2;
            _loc_5.newName = param3;
            if (this.sender != null)
            {
                sender.sendMessage("hero.changeName", _loc_5);
            }// end if
            return null;
        }// end function

        public function refreshHerosListFromTavern(param1:int, param2:Function = null) : HeroListResponse
        {
            this._refreshHerosListFromTavern_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("hero.refreshHerosListFromTavern", _loc_3);
            }// end if
            return null;
        }// end function

        public function fireHero(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._fireHero_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.heroId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.fireHero", _loc_4);
            }// end if
            return null;
        }// end function

        public function callBackHero(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._callBackHero_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.heroId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.callBackHero", _loc_4);
            }// end if
            return null;
        }// end function

        public function releaseHero(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._releaseHero_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.heroId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.releaseHero", _loc_4);
            }// end if
            return null;
        }// end function

        public function addPoint(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Function = null) : CommandResponse
        {
            this._addPoint_callback = param6;
            var _loc_7:* = new Object();
            _loc_7.castleId = param1;
            _loc_7.heroId = param2;
            _loc_7.management = param3;
            _loc_7.power = param4;
            _loc_7.stratagem = param5;
            if (this.sender != null)
            {
                sender.sendMessage("hero.addPoint", _loc_7);
            }// end if
            return null;
        }// end function

        public function hireHero(param1:int, param2:String, param3:Function = null) : CommandResponse
        {
            this._hireHero_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.heroName = param2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.hireHero", _loc_4);
            }// end if
            return null;
        }// end function

        public function dischargeChief(param1:int, param2:Function = null) : CommandResponse
        {
            this._dischargeChief_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("hero.dischargeChief", _loc_3);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

        public function levelUp(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._levelUp_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.heroId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.levelUp", _loc_4);
            }// end if
            return null;
        }// end function

        public function useItem(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
        {
            this._useItem_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.heroId = param2;
            _loc_5.itemId = param3;
            if (this.sender != null)
            {
                sender.sendMessage("hero.useItem", _loc_5);
            }// end if
            return null;
        }// end function

        public function promoteToChief(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._promoteToChief_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.heroId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.promoteToChief", _loc_4);
            }// end if
            return null;
        }// end function

        public function awardGold(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._awardGold_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.heroId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("hero.awardGold", _loc_4);
            }// end if
            return null;
        }// end function

    }
}
