package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class PlayerInfoBean extends Object implements IEventDispatcher
    {
        private var _781316064lastLoginTime:Number;
        private var _476980509createrTime:Number;
        private var _1019789636office:String;
        private var _764803337castleCount:int;
        private var _99462250honor:int;
        private var _69784511levelId:int;
        private var _103771895medal:int;
        private var _113766sex:int;
        private var _865966680accountName:String;
        private var _1092354606faceUrl:String;
        private var _3355id:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1750962803allianceLevel:String;
        private var _2023558323population:int;
        private var _3145580flag:String;
        private var _266666762userName:String;
        private var _978111542ranking:int;
        private var _1276224445prestige:int;
        private var _1307249261titleId:int;
        private var _1806944311alliance:String;

        public function PlayerInfoBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.accountName != null)
                {
                    this.accountName = param1.accountName;
                }// end if
                if (param1.alliance != null)
                {
                    this.alliance = param1.alliance;
                }// end if
                if (param1.allianceLevel != null)
                {
                    this.allianceLevel = param1.allianceLevel;
                }// end if
                if (param1.castleCount != null)
                {
                    this.castleCount = param1.castleCount;
                }// end if
                if (param1.createrTime != null)
                {
                    this.createrTime = param1.createrTime;
                }// end if
                if (param1.faceUrl != null)
                {
                    this.faceUrl = param1.faceUrl;
                }// end if
                if (param1.flag != null)
                {
                    this.flag = param1.flag;
                }// end if
                if (param1.honor != null)
                {
                    this.honor = param1.honor;
                }// end if
                if (param1.id != null)
                {
                    this.id = param1.id;
                }// end if
                if (param1.lastLoginTime != null)
                {
                    this.lastLoginTime = param1.lastLoginTime;
                }// end if
                if (param1.levelId != null)
                {
                    this.levelId = param1.levelId;
                }// end if
                if (param1.medal != null)
                {
                    this.medal = param1.medal;
                }// end if
                if (param1.office != null)
                {
                    this.office = param1.office;
                }// end if
                if (param1.population != null)
                {
                    this.population = param1.population;
                }// end if
                if (param1.prestige != null)
                {
                    this.prestige = param1.prestige;
                }// end if
                if (param1.ranking != null)
                {
                    this.ranking = param1.ranking;
                }// end if
                if (param1.sex != null)
                {
                    this.sex = param1.sex;
                }// end if
                if (param1.titleId != null)
                {
                    this.titleId = param1.titleId;
                }// end if
                if (param1.userName != null)
                {
                    this.userName = param1.userName;
                }// end if
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function get allianceLevel() : String
        {
            return this._1750962803allianceLevel;
        }// end function

        public function get medal() : int
        {
            return this._103771895medal;
        }// end function

        public function set medal(param1:int) : void
        {
            var _loc_2:* = this._103771895medal;
            if (_loc_2 !== param1)
            {
                this._103771895medal = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "medal", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get titleId() : int
        {
            return this._1307249261titleId;
        }// end function

        public function set userName(param1:String) : void
        {
            var _loc_2:* = this._266666762userName;
            if (_loc_2 !== param1)
            {
                this._266666762userName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "userName", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.accountName = this.accountName;
            _loc_1.alliance = this.alliance;
            _loc_1.allianceLevel = this.allianceLevel;
            _loc_1.castleCount = this.castleCount;
            _loc_1.createrTime = this.createrTime;
            _loc_1.faceUrl = this.faceUrl;
            _loc_1.flag = this.flag;
            _loc_1.honor = this.honor;
            _loc_1.id = this.id;
            _loc_1.lastLoginTime = this.lastLoginTime;
            _loc_1.levelId = this.levelId;
            _loc_1.medal = this.medal;
            _loc_1.office = this.office;
            _loc_1.population = this.population;
            _loc_1.prestige = this.prestige;
            _loc_1.ranking = this.ranking;
            _loc_1.sex = this.sex;
            _loc_1.titleId = this.titleId;
            _loc_1.userName = this.userName;
            return _loc_1;
        }// end function

        public function set prestige(param1:int) : void
        {
            var _loc_2:* = this._1276224445prestige;
            if (_loc_2 !== param1)
            {
                this._1276224445prestige = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "prestige", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set allianceLevel(param1:String) : void
        {
            var _loc_2:* = this._1750962803allianceLevel;
            if (_loc_2 !== param1)
            {
                this._1750962803allianceLevel = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceLevel", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get id() : int
        {
            return this._3355id;
        }// end function

        public function set faceUrl(param1:String) : void
        {
            var _loc_2:* = this._1092354606faceUrl;
            if (_loc_2 !== param1)
            {
                this._1092354606faceUrl = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "faceUrl", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set titleId(param1:int) : void
        {
            var _loc_2:* = this._1307249261titleId;
            if (_loc_2 !== param1)
            {
                this._1307249261titleId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "titleId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function set population(param1:int) : void
        {
            var _loc_2:* = this._2023558323population;
            if (_loc_2 !== param1)
            {
                this._2023558323population = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "population", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set accountName(param1:String) : void
        {
            var _loc_2:* = this._865966680accountName;
            if (_loc_2 !== param1)
            {
                this._865966680accountName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accountName", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get alliance() : String
        {
            return this._1806944311alliance;
        }// end function

        public function get office() : String
        {
            return this._1019789636office;
        }// end function

        public function get levelId() : int
        {
            return this._69784511levelId;
        }// end function

        public function set lastLoginTime(param1:Number) : void
        {
            var _loc_2:* = this._781316064lastLoginTime;
            if (_loc_2 !== param1)
            {
                this._781316064lastLoginTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lastLoginTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get prestige() : int
        {
            return this._1276224445prestige;
        }// end function

        public function set id(param1:int) : void
        {
            var _loc_2:* = this._3355id;
            if (_loc_2 !== param1)
            {
                this._3355id = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "id", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "accountName = " + this.accountName + "\n");
            _loc_2 = _loc_2 + (param1 + "alliance = " + this.alliance + "\n");
            _loc_2 = _loc_2 + (param1 + "allianceLevel = " + this.allianceLevel + "\n");
            _loc_2 = _loc_2 + (param1 + "castleCount = " + this.castleCount + "\n");
            _loc_2 = _loc_2 + (param1 + "createrTime = " + this.createrTime + "\n");
            _loc_2 = _loc_2 + (param1 + "faceUrl = " + this.faceUrl + "\n");
            _loc_2 = _loc_2 + (param1 + "flag = " + this.flag + "\n");
            _loc_2 = _loc_2 + (param1 + "honor = " + this.honor + "\n");
            _loc_2 = _loc_2 + (param1 + "id = " + this.id + "\n");
            _loc_2 = _loc_2 + (param1 + "lastLoginTime = " + this.lastLoginTime + "\n");
            _loc_2 = _loc_2 + (param1 + "levelId = " + this.levelId + "\n");
            _loc_2 = _loc_2 + (param1 + "medal = " + this.medal + "\n");
            _loc_2 = _loc_2 + (param1 + "office = " + this.office + "\n");
            _loc_2 = _loc_2 + (param1 + "population = " + this.population + "\n");
            _loc_2 = _loc_2 + (param1 + "prestige = " + this.prestige + "\n");
            _loc_2 = _loc_2 + (param1 + "ranking = " + this.ranking + "\n");
            _loc_2 = _loc_2 + (param1 + "sex = " + this.sex + "\n");
            _loc_2 = _loc_2 + (param1 + "titleId = " + this.titleId + "\n");
            _loc_2 = _loc_2 + (param1 + "userName = " + this.userName + "\n");
            return _loc_2;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function copyTo(param1:PlayerInfoBean) : void
        {
            param1.accountName = this.accountName;
            param1.alliance = this.alliance;
            param1.allianceLevel = this.allianceLevel;
            param1.castleCount = this.castleCount;
            param1.createrTime = this.createrTime;
            param1.faceUrl = this.faceUrl;
            param1.flag = this.flag;
            param1.honor = this.honor;
            param1.id = this.id;
            param1.lastLoginTime = this.lastLoginTime;
            param1.levelId = this.levelId;
            param1.medal = this.medal;
            param1.office = this.office;
            param1.population = this.population;
            param1.prestige = this.prestige;
            param1.ranking = this.ranking;
            param1.sex = this.sex;
            param1.titleId = this.titleId;
            param1.userName = this.userName;
            return;
        }// end function

        public function get faceUrl() : String
        {
            return this._1092354606faceUrl;
        }// end function

        public function set sex(param1:int) : void
        {
            var _loc_2:* = this._113766sex;
            if (_loc_2 !== param1)
            {
                this._113766sex = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sex", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set honor(param1:int) : void
        {
            var _loc_2:* = this._99462250honor;
            if (_loc_2 !== param1)
            {
                this._99462250honor = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "honor", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set createrTime(param1:Number) : void
        {
            var _loc_2:* = this._476980509createrTime;
            if (_loc_2 !== param1)
            {
                this._476980509createrTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "createrTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get accountName() : String
        {
            return this._865966680accountName;
        }// end function

        public function get population() : int
        {
            return this._2023558323population;
        }// end function

        public function set flag(param1:String) : void
        {
            var _loc_2:* = this._3145580flag;
            if (_loc_2 !== param1)
            {
                this._3145580flag = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "flag", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get lastLoginTime() : Number
        {
            return this._781316064lastLoginTime;
        }// end function

        public function get createrTime() : Number
        {
            return this._476980509createrTime;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function get flag() : String
        {
            return this._3145580flag;
        }// end function

        public function get sex() : int
        {
            return this._113766sex;
        }// end function

        public function set castleCount(param1:int) : void
        {
            var _loc_2:* = this._764803337castleCount;
            if (_loc_2 !== param1)
            {
                this._764803337castleCount = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleCount", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get ranking() : int
        {
            return this._978111542ranking;
        }// end function

        public function get honor() : int
        {
            return this._99462250honor;
        }// end function

        public function set ranking(param1:int) : void
        {
            var _loc_2:* = this._978111542ranking;
            if (_loc_2 !== param1)
            {
                this._978111542ranking = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ranking", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set alliance(param1:String) : void
        {
            var _loc_2:* = this._1806944311alliance;
            if (_loc_2 !== param1)
            {
                this._1806944311alliance = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alliance", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get userName() : String
        {
            return this._266666762userName;
        }// end function

        public function get castleCount() : int
        {
            return this._764803337castleCount;
        }// end function

        public function set office(param1:String) : void
        {
            var _loc_2:* = this._1019789636office;
            if (_loc_2 !== param1)
            {
                this._1019789636office = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "office", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set levelId(param1:int) : void
        {
            var _loc_2:* = this._69784511levelId;
            if (_loc_2 !== param1)
            {
                this._69784511levelId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "levelId", _loc_2, param1));
            }// end if
            return;
        }// end function

    }
}
