package com.umge.sovt.common.beans
{
    import com.umge.sovt.common.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.events.*;

    public class CastleBean extends Object implements IEventDispatcher
    {
        private var _1225376224herosArray:ArrayCollection;
        private var _892481550status:int;
        private var _3373707name:String;
        private var _637336720transingTradesArray:ArrayCollection;
        private var _341064690resource:CastleResourceBean;
        private var _1236765024allowAlliance:Boolean;
        private var _1458231286tradesArray:ArrayCollection;
        private var _861252683fieldId:int;
        private var _3355id:int;
        private var _233906701fortification:FortificationsBean;
        private var _1632439642buildingsArray:ArrayCollection;
        private var _1228099360fieldsArray:ArrayCollection;
        private var _116645134hasEnemy:Boolean;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1097354357logUrl:String;
        private var _45571131goOutForBattle:Boolean;
        private var _110634834troop:TroopBean;

        public function CastleBean(param1:Object = null)
        {
            var _loc_2:int;
            var _loc_3:BuildingBean;
            var _loc_4:FieldBean;
            var _loc_5:HeroBean;
            var _loc_6:TradeBean;
            var _loc_7:TransingTradeBean;
            _1632439642buildingsArray = new ArrayCollection();
            _1228099360fieldsArray = new ArrayCollection();
            _1225376224herosArray = new ArrayCollection();
            _1458231286tradesArray = new ArrayCollection();
            _637336720transingTradesArray = new ArrayCollection();
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.fieldId != null)
                {
                    this.fieldId = param1.fieldId;
                }// end if
                if (param1.fortification != null)
                {
                    this.fortification = new FortificationsBean(param1.fortification);
                }// end if
                if (param1.id != null)
                {
                    this.id = param1.id;
                }// end if
                if (param1.logUrl != null)
                {
                    this.logUrl = param1.logUrl;
                }// end if
                if (param1.name != null)
                {
                    this.name = param1.name;
                }// end if
                if (param1.resource != null)
                {
                    this.resource = new CastleResourceBean(param1.resource);
                }// end if
                if (param1.status != null)
                {
                    this.status = param1.status;
                }// end if
                if (param1.troop != null)
                {
                    this.troop = new TroopBean(param1.troop);
                }// end if
                if (param1.allowAlliance != null)
                {
                    this.allowAlliance = param1.allowAlliance;
                }// end if
                if (param1.goOutForBattle != null)
                {
                    this.goOutForBattle = param1.goOutForBattle;
                }// end if
                if (param1.hasEnemy != null)
                {
                    this.hasEnemy = param1.hasEnemy;
                }// end if
                if (param1.buildings)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.buildings.length)
                    {
                        // label
                        _loc_3 = new BuildingBean(param1.buildings[_loc_2]);
                        this.buildingsArray.addItem(_loc_3);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.fields)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.fields.length)
                    {
                        // label
                        _loc_4 = new FieldBean(param1.fields[_loc_2]);
                        this.fieldsArray.addItem(_loc_4);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.heros)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.heros.length)
                    {
                        // label
                        _loc_5 = new HeroBean(param1.heros[_loc_2]);
                        this.herosArray.addItem(_loc_5);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.trades)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.trades.length)
                    {
                        // label
                        _loc_6 = new TradeBean(param1.trades[_loc_2]);
                        this.tradesArray.addItem(_loc_6);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.transingTrades)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.transingTrades.length)
                    {
                        // label
                        _loc_7 = new TransingTradeBean(param1.transingTrades[_loc_2]);
                        this.transingTradesArray.addItem(_loc_7);
                        _loc_2++;
                    }// end while
                }// end if
            }// end if
            return;
        }// end function

        public function getHeros(param1:int) : HeroBean
        {
            var _loc_2:* = this.herosArray[param1] as HeroBean;
            return _loc_2;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function getBuildings(param1:int) : BuildingBean
        {
            var _loc_2:* = this.buildingsArray[param1] as BuildingBean;
            return _loc_2;
        }// end function

        public function get logUrl() : String
        {
            return this._1097354357logUrl;
        }// end function

        public function getTrades(param1:int) : TradeBean
        {
            var _loc_2:* = this.tradesArray[param1] as TradeBean;
            return _loc_2;
        }// end function

        public function setTrades(param1:TradeBean, param2:int) : void
        {
            this.tradesArray[param2] = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this._3373707name;
        }// end function

        public function set tradesArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._1458231286tradesArray;
            if (_loc_2 !== param1)
            {
                this._1458231286tradesArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tradesArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set logUrl(param1:String) : void
        {
            var _loc_2:* = this._1097354357logUrl;
            if (_loc_2 !== param1)
            {
                this._1097354357logUrl = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "logUrl", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get tradesArray() : ArrayCollection
        {
            return this._1458231286tradesArray;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.fieldId = this.fieldId;
            _loc_1.fortification = this.fortification.toObject();
            _loc_1.id = this.id;
            _loc_1.logUrl = this.logUrl;
            _loc_1.name = this.name;
            _loc_1.resource = this.resource.toObject();
            _loc_1.status = this.status;
            _loc_1.troop = this.troop.toObject();
            _loc_1.allowAlliance = this.allowAlliance;
            _loc_1.goOutForBattle = this.goOutForBattle;
            _loc_1.hasEnemy = this.hasEnemy;
            return _loc_1;
        }// end function

        public function get id() : int
        {
            return this._3355id;
        }// end function

        public function get allowAlliance() : Boolean
        {
            return this._1236765024allowAlliance;
        }// end function

        public function set resource(param1:CastleResourceBean) : void
        {
            var _loc_2:* = this._341064690resource;
            if (_loc_2 !== param1)
            {
                this._341064690resource = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resource", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set troop(param1:TroopBean) : void
        {
            var _loc_2:* = this._110634834troop;
            if (_loc_2 !== param1)
            {
                this._110634834troop = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troop", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get resource() : CastleResourceBean
        {
            return this._341064690resource;
        }// end function

        public function get fieldsArray() : ArrayCollection
        {
            return this._1228099360fieldsArray;
        }// end function

        public function set hasEnemy(param1:Boolean) : void
        {
            var _loc_2:* = this._116645134hasEnemy;
            if (_loc_2 !== param1)
            {
                this._116645134hasEnemy = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasEnemy", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function getFields(param1:int) : FieldBean
        {
            var _loc_2:* = this.fieldsArray[param1] as FieldBean;
            return _loc_2;
        }// end function

        public function get hasEnemy() : Boolean
        {
            return this._116645134hasEnemy;
        }// end function

        public function set buildingsArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._1632439642buildingsArray;
            if (_loc_2 !== param1)
            {
                this._1632439642buildingsArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingsArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get fieldId() : int
        {
            return this._861252683fieldId;
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

        public function set name(param1:String) : void
        {
            var _loc_2:* = this._3373707name;
            if (_loc_2 !== param1)
            {
                this._3373707name = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "name", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function setFields(param1:FieldBean, param2:int) : void
        {
            this.fieldsArray[param2] = param1;
            return;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "fieldId = " + this.fieldId + "\n");
            if (fortification != null)
            {
                _loc_2 = _loc_2 + this.fortification.toDebugString(param1 + "fortification.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "fortification = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "id = " + this.id + "\n");
            _loc_2 = _loc_2 + (param1 + "logUrl = " + this.logUrl + "\n");
            _loc_2 = _loc_2 + (param1 + "name = " + this.name + "\n");
            if (resource != null)
            {
                _loc_2 = _loc_2 + this.resource.toDebugString(param1 + "resource.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "resource = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "status = " + this.status + "\n");
            if (troop != null)
            {
                _loc_2 = _loc_2 + this.troop.toDebugString(param1 + "troop.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "troop = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "allowAlliance = " + this.allowAlliance + "\n");
            _loc_2 = _loc_2 + (param1 + "goOutForBattle = " + this.goOutForBattle + "\n");
            _loc_2 = _loc_2 + (param1 + "hasEnemy = " + this.hasEnemy + "\n");
            _loc_3 = 0;
            while (_loc_3 < this.buildingsArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getBuildings(_loc_3).toDebugString(param1 + "buildings[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.fieldsArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getFields(_loc_3).toDebugString(param1 + "fields[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.herosArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getHeros(_loc_3).toDebugString(param1 + "heros[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.tradesArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getTrades(_loc_3).toDebugString(param1 + "trades[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.transingTradesArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getTransingTrades(_loc_3).toDebugString(param1 + "transingTrades[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function get herosArray() : ArrayCollection
        {
            return this._1225376224herosArray;
        }// end function

        public function set allowAlliance(param1:Boolean) : void
        {
            var _loc_2:* = this._1236765024allowAlliance;
            if (_loc_2 !== param1)
            {
                this._1236765024allowAlliance = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allowAlliance", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function copyTo(param1:CastleBean) : void
        {
            param1.fieldId = this.fieldId;
            if (fortification != null)
            {
                this.fortification.copyTo(param1.fortification);
            }
            else
            {
                param1.fortification = null;
            }// end else if
            param1.id = this.id;
            param1.logUrl = this.logUrl;
            param1.name = this.name;
            if (resource != null)
            {
                this.resource.copyTo(param1.resource);
            }
            else
            {
                param1.resource = null;
            }// end else if
            param1.status = this.status;
            if (troop != null)
            {
                this.troop.copyTo(param1.troop);
            }
            else
            {
                param1.troop = null;
            }// end else if
            param1.allowAlliance = this.allowAlliance;
            param1.goOutForBattle = this.goOutForBattle;
            param1.hasEnemy = this.hasEnemy;
            CommonUtil.arrayCopy(this.buildingsArray, param1.buildingsArray);
            CommonUtil.arrayCopy(this.fieldsArray, param1.fieldsArray);
            CommonUtil.arrayCopy(this.herosArray, param1.herosArray);
            CommonUtil.arrayCopy(this.tradesArray, param1.tradesArray);
            CommonUtil.arrayCopy(this.transingTradesArray, param1.transingTradesArray);
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function get troop() : TroopBean
        {
            return this._110634834troop;
        }// end function

        public function get goOutForBattle() : Boolean
        {
            return this._45571131goOutForBattle;
        }// end function

        public function set fieldsArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._1228099360fieldsArray;
            if (_loc_2 !== param1)
            {
                this._1228099360fieldsArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldsArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set goOutForBattle(param1:Boolean) : void
        {
            var _loc_2:* = this._45571131goOutForBattle;
            if (_loc_2 !== param1)
            {
                this._45571131goOutForBattle = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "goOutForBattle", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get buildingsArray() : ArrayCollection
        {
            return this._1632439642buildingsArray;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function getTransingTrades(param1:int) : TransingTradeBean
        {
            var _loc_2:* = this.transingTradesArray[param1] as TransingTradeBean;
            return _loc_2;
        }// end function

        public function set herosArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._1225376224herosArray;
            if (_loc_2 !== param1)
            {
                this._1225376224herosArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "herosArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set status(param1:int) : void
        {
            var _loc_2:* = this._892481550status;
            if (_loc_2 !== param1)
            {
                this._892481550status = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "status", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set fortification(param1:FortificationsBean) : void
        {
            var _loc_2:* = this._233906701fortification;
            if (_loc_2 !== param1)
            {
                this._233906701fortification = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fortification", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set transingTradesArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._637336720transingTradesArray;
            if (_loc_2 !== param1)
            {
                this._637336720transingTradesArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "transingTradesArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function setTransingTrades(param1:TransingTradeBean, param2:int) : void
        {
            this.transingTradesArray[param2] = param1;
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get transingTradesArray() : ArrayCollection
        {
            return this._637336720transingTradesArray;
        }// end function

        public function set fieldId(param1:int) : void
        {
            var _loc_2:* = this._861252683fieldId;
            if (_loc_2 !== param1)
            {
                this._861252683fieldId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get status() : int
        {
            return this._892481550status;
        }// end function

        public function get fortification() : FortificationsBean
        {
            return this._233906701fortification;
        }// end function

        public function setHeros(param1:HeroBean, param2:int) : void
        {
            this.herosArray[param2] = param1;
            return;
        }// end function

        public function setBuildings(param1:BuildingBean, param2:int) : void
        {
            this.buildingsArray[param2] = param1;
            return;
        }// end function

    }
}
