package com.umge.sovt.eum
{
    import flash.events.*;
    import mx.events.*;

    public class FortificationEum extends Object implements IEventDispatcher
    {
        private var _109770853stone:int;
        private var _3373707name:String;
        private var _1544916048defence:int;
        private var _3241160iron:int;
        private var _109637894space:int;
        private var _108280125range:int;
        private var _3655341wood:int;
        private var _100893exp:int;
        private var _2131644941repairRate:int;
        private var _3148894food:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _3321596life:int;
        private var _3560141time:int;
        private var _1407259064attack:int;
        private var _858803723typeId:int;
        private var _1197946271wikiDesc:String;
        private var _3079825desc:String;

        public function FortificationEum()
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            return;
        }// end function

        public function set range(param1:int) : void
        {
            var _loc_2:* = this._108280125range;
            if (_loc_2 !== param1)
            {
                this._108280125range = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "range", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get life() : int
        {
            return this._3321596life;
        }// end function

        public function get space() : int
        {
            return this._109637894space;
        }// end function

        public function get name() : String
        {
            return this._3373707name;
        }// end function

        public function set space(param1:int) : void
        {
            var _loc_2:* = this._109637894space;
            if (_loc_2 !== param1)
            {
                this._109637894space = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "space", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get repairRate() : int
        {
            return this._2131644941repairRate;
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

        public function get desc() : String
        {
            return this._3079825desc;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
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

        public function set time(param1:int) : void
        {
            var _loc_2:* = this._3560141time;
            if (_loc_2 !== param1)
            {
                this._3560141time = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "time", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get exp() : int
        {
            return this._100893exp;
        }// end function

        public function set attack(param1:int) : void
        {
            var _loc_2:* = this._1407259064attack;
            if (_loc_2 !== param1)
            {
                this._1407259064attack = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "attack", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set repairRate(param1:int) : void
        {
            var _loc_2:* = this._2131644941repairRate;
            if (_loc_2 !== param1)
            {
                this._2131644941repairRate = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "repairRate", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set desc(param1:String) : void
        {
            var _loc_2:* = this._3079825desc;
            if (_loc_2 !== param1)
            {
                this._3079825desc = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desc", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get wood() : int
        {
            return this._3655341wood;
        }// end function

        public function set defence(param1:int) : void
        {
            var _loc_2:* = this._1544916048defence;
            if (_loc_2 !== param1)
            {
                this._1544916048defence = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "defence", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set exp(param1:int) : void
        {
            var _loc_2:* = this._100893exp;
            if (_loc_2 !== param1)
            {
                this._100893exp = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "exp", _loc_2, param1));
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

        public function set wikiDesc(param1:String) : void
        {
            var _loc_2:* = this._1197946271wikiDesc;
            if (_loc_2 !== param1)
            {
                this._1197946271wikiDesc = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wikiDesc", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get range() : int
        {
            return this._108280125range;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get iron() : int
        {
            return this._3241160iron;
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

        public function get time() : int
        {
            return this._3560141time;
        }// end function

        public function get attack() : int
        {
            return this._1407259064attack;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
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

        public function get defence() : int
        {
            return this._1544916048defence;
        }// end function

        public function get wikiDesc() : String
        {
            return this._1197946271wikiDesc;
        }// end function

        public function get food() : int
        {
            return this._3148894food;
        }// end function

        public function set typeId(param1:int) : void
        {
            var _loc_2:* = this._858803723typeId;
            if (_loc_2 !== param1)
            {
                this._858803723typeId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get stone() : int
        {
            return this._109770853stone;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function set life(param1:int) : void
        {
            var _loc_2:* = this._3321596life;
            if (_loc_2 !== param1)
            {
                this._3321596life = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "life", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get typeId() : int
        {
            return this._858803723typeId;
        }// end function

    }
}
