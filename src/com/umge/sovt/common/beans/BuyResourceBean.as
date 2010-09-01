package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class BuyResourceBean extends Object implements IEventDispatcher
    {
        private var _678592313forFood:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _449807254foodRemain:int;
        private var _504430457woodRemain:int;
        private var _450629916forStone:int;
        private var _1881641644ironRemain:int;
        private var _252311759stoneRemain:int;
        private var _678085866forWood:int;
        private var _678500047forIron:int;

        public function BuyResourceBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.foodRemain != null)
                {
                    this.foodRemain = param1.foodRemain;
                }// end if
                if (param1.forFood != null)
                {
                    this.forFood = param1.forFood;
                }// end if
                if (param1.forIron != null)
                {
                    this.forIron = param1.forIron;
                }// end if
                if (param1.forStone != null)
                {
                    this.forStone = param1.forStone;
                }// end if
                if (param1.forWood != null)
                {
                    this.forWood = param1.forWood;
                }// end if
                if (param1.ironRemain != null)
                {
                    this.ironRemain = param1.ironRemain;
                }// end if
                if (param1.stoneRemain != null)
                {
                    this.stoneRemain = param1.stoneRemain;
                }// end if
                if (param1.woodRemain != null)
                {
                    this.woodRemain = param1.woodRemain;
                }// end if
            }// end if
            return;
        }// end function

        public function get stoneRemain() : int
        {
            return this._252311759stoneRemain;
        }// end function

        public function set woodRemain(param1:int) : void
        {
            var _loc_2:* = this._504430457woodRemain;
            if (_loc_2 !== param1)
            {
                this._504430457woodRemain = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "woodRemain", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set forWood(param1:int) : void
        {
            var _loc_2:* = this._678085866forWood;
            if (_loc_2 !== param1)
            {
                this._678085866forWood = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "forWood", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get forFood() : int
        {
            return this._678592313forFood;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "foodRemain = " + this.foodRemain + "\n");
            _loc_2 = _loc_2 + (param1 + "forFood = " + this.forFood + "\n");
            _loc_2 = _loc_2 + (param1 + "forIron = " + this.forIron + "\n");
            _loc_2 = _loc_2 + (param1 + "forStone = " + this.forStone + "\n");
            _loc_2 = _loc_2 + (param1 + "forWood = " + this.forWood + "\n");
            _loc_2 = _loc_2 + (param1 + "ironRemain = " + this.ironRemain + "\n");
            _loc_2 = _loc_2 + (param1 + "stoneRemain = " + this.stoneRemain + "\n");
            _loc_2 = _loc_2 + (param1 + "woodRemain = " + this.woodRemain + "\n");
            return _loc_2;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function set forFood(param1:int) : void
        {
            var _loc_2:* = this._678592313forFood;
            if (_loc_2 !== param1)
            {
                this._678592313forFood = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "forFood", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get woodRemain() : int
        {
            return this._504430457woodRemain;
        }// end function

        public function set foodRemain(param1:int) : void
        {
            var _loc_2:* = this._449807254foodRemain;
            if (_loc_2 !== param1)
            {
                this._449807254foodRemain = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "foodRemain", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function copyTo(param1:BuyResourceBean) : void
        {
            param1.foodRemain = this.foodRemain;
            param1.forFood = this.forFood;
            param1.forIron = this.forIron;
            param1.forStone = this.forStone;
            param1.forWood = this.forWood;
            param1.ironRemain = this.ironRemain;
            param1.stoneRemain = this.stoneRemain;
            param1.woodRemain = this.woodRemain;
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function get ironRemain() : int
        {
            return this._1881641644ironRemain;
        }// end function

        public function get forStone() : int
        {
            return this._450629916forStone;
        }// end function

        public function get forWood() : int
        {
            return this._678085866forWood;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.foodRemain = this.foodRemain;
            _loc_1.forFood = this.forFood;
            _loc_1.forIron = this.forIron;
            _loc_1.forStone = this.forStone;
            _loc_1.forWood = this.forWood;
            _loc_1.ironRemain = this.ironRemain;
            _loc_1.stoneRemain = this.stoneRemain;
            _loc_1.woodRemain = this.woodRemain;
            return _loc_1;
        }// end function

        public function set forIron(param1:int) : void
        {
            var _loc_2:* = this._678500047forIron;
            if (_loc_2 !== param1)
            {
                this._678500047forIron = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "forIron", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set ironRemain(param1:int) : void
        {
            var _loc_2:* = this._1881641644ironRemain;
            if (_loc_2 !== param1)
            {
                this._1881641644ironRemain = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ironRemain", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set stoneRemain(param1:int) : void
        {
            var _loc_2:* = this._252311759stoneRemain;
            if (_loc_2 !== param1)
            {
                this._252311759stoneRemain = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stoneRemain", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get foodRemain() : int
        {
            return this._449807254foodRemain;
        }// end function

        public function get forIron() : int
        {
            return this._678500047forIron;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function set forStone(param1:int) : void
        {
            var _loc_2:* = this._450629916forStone;
            if (_loc_2 !== param1)
            {
                this._450629916forStone = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "forStone", _loc_2, param1));
            }// end if
            return;
        }// end function

    }
}
