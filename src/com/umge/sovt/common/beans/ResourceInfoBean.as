package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class ResourceInfoBean extends Object implements IEventDispatcher
    {
        private var _996698880workPeople:int;
        private var _1913146946increaseRate:Number;
        private var _107876max:int;
        private var _2133060262storeRercent:int;
        private var _1413853096amount:Number;
        private var _bindingEventDispatcher:EventDispatcher;

        public function ResourceInfoBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.amount != null)
                {
                    this.amount = param1.amount;
                }// end if
                if (param1.increaseRate != null)
                {
                    this.increaseRate = param1.increaseRate;
                }// end if
                if (param1.max != null)
                {
                    this.max = param1.max;
                }// end if
                if (param1.storeRercent != null)
                {
                    this.storeRercent = param1.storeRercent;
                }// end if
                if (param1.workPeople != null)
                {
                    this.workPeople = param1.workPeople;
                }// end if
            }// end if
            return;
        }// end function

        public function get workPeople() : int
        {
            return this._996698880workPeople;
        }// end function

        public function get increaseRate() : Number
        {
            return this._1913146946increaseRate;
        }// end function

        public function set increaseRate(param1:Number) : void
        {
            var _loc_2:* = this._1913146946increaseRate;
            if (_loc_2 !== param1)
            {
                this._1913146946increaseRate = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "increaseRate", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
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

        public function set max(param1:int) : void
        {
            var _loc_2:* = this._107876max;
            if (_loc_2 !== param1)
            {
                this._107876max = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "max", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "amount = " + this.amount + "\n");
            _loc_2 = _loc_2 + (param1 + "increaseRate = " + this.increaseRate + "\n");
            _loc_2 = _loc_2 + (param1 + "max = " + this.max + "\n");
            _loc_2 = _loc_2 + (param1 + "storeRercent = " + this.storeRercent + "\n");
            _loc_2 = _loc_2 + (param1 + "workPeople = " + this.workPeople + "\n");
            return _loc_2;
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

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function copyTo(param1:ResourceInfoBean) : void
        {
            param1.amount = this.amount;
            param1.increaseRate = this.increaseRate;
            param1.max = this.max;
            param1.storeRercent = this.storeRercent;
            param1.workPeople = this.workPeople;
            return;
        }// end function

        public function get amount() : Number
        {
            return this._1413853096amount;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.amount = this.amount;
            _loc_1.increaseRate = this.increaseRate;
            _loc_1.max = this.max;
            _loc_1.storeRercent = this.storeRercent;
            _loc_1.workPeople = this.workPeople;
            return _loc_1;
        }// end function

        public function set storeRercent(param1:int) : void
        {
            var _loc_2:* = this._2133060262storeRercent;
            if (_loc_2 !== param1)
            {
                this._2133060262storeRercent = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "storeRercent", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get max() : int
        {
            return this._107876max;
        }// end function

        public function set amount(param1:Number) : void
        {
            var _loc_2:* = this._1413853096amount;
            if (_loc_2 !== param1)
            {
                this._1413853096amount = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "amount", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function get storeRercent() : int
        {
            return this._2133060262storeRercent;
        }// end function

    }
}
