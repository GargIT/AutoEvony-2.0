package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class ResourceBean extends Object implements IEventDispatcher
    {
        private var _3655341wood:Number;
        private var _109770853stone:Number;
        private var _3148894food:Number;
        private var _3178592gold:int;
        private var _3241160iron:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function ResourceBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
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
                if (param1.stone != null)
                {
                    this.stone = param1.stone;
                }// end if
                if (param1.wood != null)
                {
                    this.wood = param1.wood;
                }// end if
            }// end if
            return;
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

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "food = " + this.food + "\n");
            _loc_2 = _loc_2 + (param1 + "gold = " + this.gold + "\n");
            _loc_2 = _loc_2 + (param1 + "iron = " + this.iron + "\n");
            _loc_2 = _loc_2 + (param1 + "stone = " + this.stone + "\n");
            _loc_2 = _loc_2 + (param1 + "wood = " + this.wood + "\n");
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

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function get iron() : int
        {
            return this._3241160iron;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
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

        public function get food() : int
        {
            return this._3148894food;
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

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.food = this.food;
            _loc_1.gold = this.gold;
            _loc_1.iron = this.iron;
            _loc_1.stone = this.stone;
            _loc_1.wood = this.wood;
            return _loc_1;
        }// end function

        public function get stone() : int
        {
            return this._109770853stone;
        }// end function

        public function copyTo(param1:ResourceBean) : void
        {
            param1.food = this.food;
            param1.gold = this.gold;
            param1.iron = this.iron;
            param1.stone = this.stone;
            param1.wood = this.wood;
            return;
        }// end function

        public function get wood() : int
        {
            return this._3655341wood;
        }// end function

        public function get gold() : int
        {
            return this._3178592gold;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
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

    }
}
