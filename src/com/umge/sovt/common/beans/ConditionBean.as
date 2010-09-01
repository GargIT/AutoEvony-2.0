package com.umge.sovt.common.beans
{
    import com.umge.sovt.common.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.events.*;

    public class ConditionBean extends Object implements IEventDispatcher
    {
        private var _109770853stone:int;
        private var _3178592gold:int;
        private var _3241160iron:int;
        private var _895975549destructTime:Number;
        private var _1425640839itemsArray:ArrayCollection;
        private var _1578480708techsArray:ArrayCollection;
        private var _3655341wood:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _2023558323population:int;
        private var _3148894food:int;
        private var _1632439642buildingsArray:ArrayCollection;
        private var _3560141time:Number;

        public function ConditionBean(param1:Object = null)
        {
            var _loc_2:int;
            var _loc_3:ConditionDependBuildingBean;
            var _loc_4:ConditionDependItemBean;
            var _loc_5:ConditionDependTechBean;
            _1632439642buildingsArray = new ArrayCollection();
            _1425640839itemsArray = new ArrayCollection();
            _1578480708techsArray = new ArrayCollection();
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.destructTime != null)
                {
                    this.destructTime = param1.destructTime;
                }// end if
                if (param1.food != null)
                {
                    this.food = param1.food;
                }// end if
                if (param1.gold != null)
                {
                    this.gold = param1.gold;
                }// end if
                if (param1.iron != null)
                {
                    this.iron = param1.iron;
                }// end if
                if (param1.population != null)
                {
                    this.population = param1.population;
                }// end if
                if (param1.stone != null)
                {
                    this.stone = param1.stone;
                }// end if
                if (param1.time != null)
                {
                    this.time = param1.time;
                }// end if
                if (param1.wood != null)
                {
                    this.wood = param1.wood;
                }// end if
                if (param1.buildings)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.buildings.length)
                    {
                        // label
                        _loc_3 = new ConditionDependBuildingBean(param1.buildings[_loc_2]);
                        this.buildingsArray.addItem(_loc_3);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.items)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.items.length)
                    {
                        // label
                        _loc_4 = new ConditionDependItemBean(param1.items[_loc_2]);
                        this.itemsArray.addItem(_loc_4);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.techs)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.techs.length)
                    {
                        // label
                        _loc_5 = new ConditionDependTechBean(param1.techs[_loc_2]);
                        this.techsArray.addItem(_loc_5);
                        _loc_2++;
                    }// end while
                }// end if
            }// end if
            return;
        }// end function

        public function get destructTime() : Number
        {
            return this._895975549destructTime;
        }// end function

        public function set destructTime(param1:Number) : void
        {
            var _loc_2:* = this._895975549destructTime;
            if (_loc_2 !== param1)
            {
                this._895975549destructTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "destructTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function getBuildings(param1:int) : ConditionDependBuildingBean
        {
            var _loc_2:* = this.buildingsArray[param1] as ConditionDependBuildingBean;
            return _loc_2;
        }// end function

        public function getItems(param1:int) : ConditionDependItemBean
        {
            var _loc_2:* = this.itemsArray[param1] as ConditionDependItemBean;
            return _loc_2;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function set iron(param1:int) : void
        {
            var _loc_2:* = this._3241160iron;
            if (_loc_2 !== param1)
            {
                this._3241160iron = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iron", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set time(param1:Number) : void
        {
            var _loc_2:* = this._3560141time;
            if (_loc_2 !== param1)
            {
                this._3560141time = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "time", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.destructTime = this.destructTime;
            _loc_1.food = this.food;
            _loc_1.gold = this.gold;
            _loc_1.iron = this.iron;
            _loc_1.population = this.population;
            _loc_1.stone = this.stone;
            _loc_1.time = this.time;
            _loc_1.wood = this.wood;
            return _loc_1;
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

        public function get wood() : int
        {
            return this._3655341wood;
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

        public function set food(param1:int) : void
        {
            var _loc_2:* = this._3148894food;
            if (_loc_2 !== param1)
            {
                this._3148894food = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "food", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get techsArray() : ArrayCollection
        {
            return this._1578480708techsArray;
        }// end function

        public function get iron() : int
        {
            return this._3241160iron;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "destructTime = " + this.destructTime + "\n");
            _loc_2 = _loc_2 + (param1 + "food = " + this.food + "\n");
            _loc_2 = _loc_2 + (param1 + "gold = " + this.gold + "\n");
            _loc_2 = _loc_2 + (param1 + "iron = " + this.iron + "\n");
            _loc_2 = _loc_2 + (param1 + "population = " + this.population + "\n");
            _loc_2 = _loc_2 + (param1 + "stone = " + this.stone + "\n");
            _loc_2 = _loc_2 + (param1 + "time = " + this.time + "\n");
            _loc_2 = _loc_2 + (param1 + "wood = " + this.wood + "\n");
            _loc_3 = 0;
            while (_loc_3 < this.buildingsArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getBuildings(_loc_3).toDebugString(param1 + "buildings[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.itemsArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getItems(_loc_3).toDebugString(param1 + "items[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.techsArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getTechs(_loc_3).toDebugString(param1 + "techs[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function set stone(param1:int) : void
        {
            var _loc_2:* = this._109770853stone;
            if (_loc_2 !== param1)
            {
                this._109770853stone = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stone", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get population() : int
        {
            return this._2023558323population;
        }// end function

        public function set gold(param1:int) : void
        {
            var _loc_2:* = this._3178592gold;
            if (_loc_2 !== param1)
            {
                this._3178592gold = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gold", _loc_2, param1));
            }// end if
            return;
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

        public function get buildingsArray() : ArrayCollection
        {
            return this._1632439642buildingsArray;
        }// end function

        public function setTechs(param1:ConditionDependTechBean, param2:int) : void
        {
            this.techsArray[param2] = param1;
            return;
        }// end function

        public function get time() : Number
        {
            return this._3560141time;
        }// end function

        public function get food() : int
        {
            return this._3148894food;
        }// end function

        public function copyTo(param1:ConditionBean) : void
        {
            param1.destructTime = this.destructTime;
            param1.food = this.food;
            param1.gold = this.gold;
            param1.iron = this.iron;
            param1.population = this.population;
            param1.stone = this.stone;
            param1.time = this.time;
            param1.wood = this.wood;
            CommonUtil.arrayCopy(this.buildingsArray, param1.buildingsArray);
            CommonUtil.arrayCopy(this.itemsArray, param1.itemsArray);
            CommonUtil.arrayCopy(this.techsArray, param1.techsArray);
            return;
        }// end function

        public function set wood(param1:int) : void
        {
            var _loc_2:* = this._3655341wood;
            if (_loc_2 !== param1)
            {
                this._3655341wood = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wood", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get stone() : int
        {
            return this._109770853stone;
        }// end function

        public function get gold() : int
        {
            return this._3178592gold;
        }// end function

        public function getTechs(param1:int) : ConditionDependTechBean
        {
            var _loc_2:* = this.techsArray[param1] as ConditionDependTechBean;
            return _loc_2;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function set itemsArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._1425640839itemsArray;
            if (_loc_2 !== param1)
            {
                this._1425640839itemsArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemsArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function set techsArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._1578480708techsArray;
            if (_loc_2 !== param1)
            {
                this._1578480708techsArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "techsArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get itemsArray() : ArrayCollection
        {
            return this._1425640839itemsArray;
        }// end function

        public function setBuildings(param1:ConditionDependBuildingBean, param2:int) : void
        {
            this.buildingsArray[param2] = param1;
            return;
        }// end function

        public function setItems(param1:ConditionDependItemBean, param2:int) : void
        {
            this.itemsArray[param2] = param1;
            return;
        }// end function

    }
}
