package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class CastleResourceBean extends Object implements IEventDispatcher
    {
        private var _1418848857texRate:int;
        private var _2140939619buildPeople:int;
        private var _109770853stone:ResourceInfoBean;
        private var _359111346populationDirection:int;
        private var _3178592gold:Number;
        private var _3241160iron:ResourceInfoBean;
        private var _216564141curPopulation:int;
        private var _1403061077complaint:int;
        private var _636575436taxIncome:int;
        private var _3655341wood:ResourceInfoBean;
        private var _3148894food:ResourceInfoBean;
        private var _1854767153support:int;
        private var _1007641795troopCostFood:int;
        private var _996698880workPeople:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1167488739herosSalary:int;
        private var _1099040721maxPopulation:int;

        public function CastleResourceBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.buildPeople != null)
                {
                    this.buildPeople = param1.buildPeople;
                }// end if
                if (param1.complaint != null)
                {
                    this.complaint = param1.complaint;
                }// end if
                if (param1.curPopulation != null)
                {
                    this.curPopulation = param1.curPopulation;
                }// end if
                if (param1.food != null)
                {
                    this.food = new ResourceInfoBean(param1.food);
                }// end if
                if (param1.gold != null)
                {
                    this.gold = param1.gold;
                }// end if
                if (param1.herosSalary != null)
                {
                    this.herosSalary = param1.herosSalary;
                }// end if
                if (param1.iron != null)
                {
                    this.iron = new ResourceInfoBean(param1.iron);
                }// end if
                if (param1.maxPopulation != null)
                {
                    this.maxPopulation = param1.maxPopulation;
                }// end if
                if (param1.populationDirection != null)
                {
                    this.populationDirection = param1.populationDirection;
                }// end if
                if (param1.stone != null)
                {
                    this.stone = new ResourceInfoBean(param1.stone);
                }// end if
                if (param1.support != null)
                {
                    this.support = param1.support;
                }// end if
                if (param1.taxIncome != null)
                {
                    this.taxIncome = param1.taxIncome;
                }// end if
                if (param1.texRate != null)
                {
                    this.texRate = param1.texRate;
                }// end if
                if (param1.troopCostFood != null)
                {
                    this.troopCostFood = param1.troopCostFood;
                }// end if
                if (param1.wood != null)
                {
                    this.wood = new ResourceInfoBean(param1.wood);
                }// end if
                if (param1.workPeople != null)
                {
                    this.workPeople = param1.workPeople;
                }// end if
            }// end if
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function set iron(param1:ResourceInfoBean) : void
        {
            var _loc_2:* = this._3241160iron;
            if (_loc_2 !== param1)
            {
                this._3241160iron = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iron", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get buildPeople() : int
        {
            return this._2140939619buildPeople;
        }// end function

        public function set support(param1:int) : void
        {
            var _loc_2:* = this._1854767153support;
            if (_loc_2 !== param1)
            {
                this._1854767153support = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "support", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set maxPopulation(param1:int) : void
        {
            var _loc_2:* = this._1099040721maxPopulation;
            if (_loc_2 !== param1)
            {
                this._1099040721maxPopulation = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxPopulation", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.buildPeople = this.buildPeople;
            _loc_1.complaint = this.complaint;
            _loc_1.curPopulation = this.curPopulation;
            _loc_1.food = this.food.toObject();
            _loc_1.gold = this.gold;
            _loc_1.herosSalary = this.herosSalary;
            _loc_1.iron = this.iron.toObject();
            _loc_1.maxPopulation = this.maxPopulation;
            _loc_1.populationDirection = this.populationDirection;
            _loc_1.stone = this.stone.toObject();
            _loc_1.support = this.support;
            _loc_1.taxIncome = this.taxIncome;
            _loc_1.texRate = this.texRate;
            _loc_1.troopCostFood = this.troopCostFood;
            _loc_1.wood = this.wood.toObject();
            _loc_1.workPeople = this.workPeople;
            return _loc_1;
        }// end function

        public function get complaint() : int
        {
            return this._1403061077complaint;
        }// end function

        public function get curPopulation() : int
        {
            return this._216564141curPopulation;
        }// end function

        public function get texRate() : int
        {
            return this._1418848857texRate;
        }// end function

        public function get populationDirection() : int
        {
            return this._359111346populationDirection;
        }// end function

        public function get workPeople() : int
        {
            return this._996698880workPeople;
        }// end function

        public function set buildPeople(param1:int) : void
        {
            var _loc_2:* = this._2140939619buildPeople;
            if (_loc_2 !== param1)
            {
                this._2140939619buildPeople = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildPeople", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set food(param1:ResourceInfoBean) : void
        {
            var _loc_2:* = this._3148894food;
            if (_loc_2 !== param1)
            {
                this._3148894food = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "food", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get troopCostFood() : int
        {
            return this._1007641795troopCostFood;
        }// end function

        public function set gold(param1:Number) : void
        {
            var _loc_2:* = this._3178592gold;
            if (_loc_2 !== param1)
            {
                this._3178592gold = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gold", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get wood() : ResourceInfoBean
        {
            return this._3655341wood;
        }// end function

        public function set herosSalary(param1:int) : void
        {
            var _loc_2:* = this._1167488739herosSalary;
            if (_loc_2 !== param1)
            {
                this._1167488739herosSalary = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "herosSalary", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get iron() : ResourceInfoBean
        {
            return this._3241160iron;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "buildPeople = " + this.buildPeople + "\n");
            _loc_2 = _loc_2 + (param1 + "complaint = " + this.complaint + "\n");
            _loc_2 = _loc_2 + (param1 + "curPopulation = " + this.curPopulation + "\n");
            if (food != null)
            {
                _loc_2 = _loc_2 + this.food.toDebugString(param1 + "food.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "food = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "gold = " + this.gold + "\n");
            _loc_2 = _loc_2 + (param1 + "herosSalary = " + this.herosSalary + "\n");
            if (iron != null)
            {
                _loc_2 = _loc_2 + this.iron.toDebugString(param1 + "iron.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "iron = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "maxPopulation = " + this.maxPopulation + "\n");
            _loc_2 = _loc_2 + (param1 + "populationDirection = " + this.populationDirection + "\n");
            if (stone != null)
            {
                _loc_2 = _loc_2 + this.stone.toDebugString(param1 + "stone.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "stone = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "support = " + this.support + "\n");
            _loc_2 = _loc_2 + (param1 + "taxIncome = " + this.taxIncome + "\n");
            _loc_2 = _loc_2 + (param1 + "texRate = " + this.texRate + "\n");
            _loc_2 = _loc_2 + (param1 + "troopCostFood = " + this.troopCostFood + "\n");
            if (wood != null)
            {
                _loc_2 = _loc_2 + this.wood.toDebugString(param1 + "wood.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "wood = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "workPeople = " + this.workPeople + "\n");
            return _loc_2;
        }// end function

        public function set stone(param1:ResourceInfoBean) : void
        {
            var _loc_2:* = this._109770853stone;
            if (_loc_2 !== param1)
            {
                this._109770853stone = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stone", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get taxIncome() : int
        {
            return this._636575436taxIncome;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function set texRate(param1:int) : void
        {
            var _loc_2:* = this._1418848857texRate;
            if (_loc_2 !== param1)
            {
                this._1418848857texRate = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "texRate", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get support() : int
        {
            return this._1854767153support;
        }// end function

        public function get maxPopulation() : int
        {
            return this._1099040721maxPopulation;
        }// end function

        public function set workPeople(param1:int) : void
        {
            var _loc_2:* = this._996698880workPeople;
            if (_loc_2 !== param1)
            {
                this._996698880workPeople = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "workPeople", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set complaint(param1:int) : void
        {
            var _loc_2:* = this._1403061077complaint;
            if (_loc_2 !== param1)
            {
                this._1403061077complaint = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "complaint", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function copyTo(param1:CastleResourceBean) : void
        {
            param1.buildPeople = this.buildPeople;
            param1.complaint = this.complaint;
            param1.curPopulation = this.curPopulation;
            if (food != null)
            {
                this.food.copyTo(param1.food);
            }
            else
            {
                param1.food = null;
            }// end else if
            param1.gold = this.gold;
            param1.herosSalary = this.herosSalary;
            if (iron != null)
            {
                this.iron.copyTo(param1.iron);
            }
            else
            {
                param1.iron = null;
            }// end else if
            param1.maxPopulation = this.maxPopulation;
            param1.populationDirection = this.populationDirection;
            if (stone != null)
            {
                this.stone.copyTo(param1.stone);
            }
            else
            {
                param1.stone = null;
            }// end else if
            param1.support = this.support;
            param1.taxIncome = this.taxIncome;
            param1.texRate = this.texRate;
            param1.troopCostFood = this.troopCostFood;
            if (wood != null)
            {
                this.wood.copyTo(param1.wood);
            }
            else
            {
                param1.wood = null;
            }// end else if
            param1.workPeople = this.workPeople;
            return;
        }// end function

        public function set curPopulation(param1:int) : void
        {
            var _loc_2:* = this._216564141curPopulation;
            if (_loc_2 !== param1)
            {
                this._216564141curPopulation = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curPopulation", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get food() : ResourceInfoBean
        {
            return this._3148894food;
        }// end function

        public function get gold() : Number
        {
            return this._3178592gold;
        }// end function

        public function get herosSalary() : int
        {
            return this._1167488739herosSalary;
        }// end function

        public function set populationDirection(param1:int) : void
        {
            var _loc_2:* = this._359111346populationDirection;
            if (_loc_2 !== param1)
            {
                this._359111346populationDirection = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "populationDirection", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get stone() : ResourceInfoBean
        {
            return this._109770853stone;
        }// end function

        public function set taxIncome(param1:int) : void
        {
            var _loc_2:* = this._636575436taxIncome;
            if (_loc_2 !== param1)
            {
                this._636575436taxIncome = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "taxIncome", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set wood(param1:ResourceInfoBean) : void
        {
            var _loc_2:* = this._3655341wood;
            if (_loc_2 !== param1)
            {
                this._3655341wood = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wood", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function set troopCostFood(param1:int) : void
        {
            var _loc_2:* = this._1007641795troopCostFood;
            if (_loc_2 !== param1)
            {
                this._1007641795troopCostFood = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopCostFood", _loc_2, param1));
            }// end if
            return;
        }// end function

    }
}
