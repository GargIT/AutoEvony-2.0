package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class MarketTradeBean extends Object implements IEventDispatcher
    {
        private var _1413853096amount:int;
        private var _106934601price:Number;
        private var _bindingEventDispatcher:EventDispatcher;

        public function MarketTradeBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.amount != null)
                {
                    this.amount = param1.amount;
                }// end if
                if (param1.price != null)
                {
                    this.price = param1.price;
                }// end if
            }// end if
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "amount = " + this.amount + "\n");
            _loc_2 = _loc_2 + (param1 + "price = " + this.price + "\n");
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

        public function copyTo(param1:MarketTradeBean) : void
        {
            param1.amount = this.amount;
            param1.price = this.price;
            return;
        }// end function

        public function set price(param1:Number) : void
        {
            var _loc_2:* = this._106934601price;
            if (_loc_2 !== param1)
            {
                this._106934601price = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "price", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function set amount(param1:int) : void
        {
            var _loc_2:* = this._1413853096amount;
            if (_loc_2 !== param1)
            {
                this._1413853096amount = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "amount", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get price() : Number
        {
            return this._106934601price;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.amount = this.amount;
            _loc_1.price = this.price;
            return _loc_1;
        }// end function

        public function get amount() : int
        {
            return this._1413853096amount;
        }// end function

    }
}
