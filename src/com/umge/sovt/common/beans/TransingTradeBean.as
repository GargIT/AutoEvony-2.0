package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class TransingTradeBean extends Object implements IEventDispatcher
    {
        private var _1413853096amount:int;
        private var _1607243192endTime:Number;
        private var _384566343resourceName:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _106934601price:Number;
        private var _110549828total:int;
        private var _3355id:int;
        private var _1096575994resType:int;

        public function TransingTradeBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.amount != null)
                {
                    this.amount = param1.amount;
                }// end if
                if (param1.endTime != null)
                {
                    this.endTime = param1.endTime;
                }// end if
                if (param1.id != null)
                {
                    this.id = param1.id;
                }// end if
                if (param1.price != null)
                {
                    this.price = param1.price;
                }// end if
                if (param1.resType != null)
                {
                    this.resType = param1.resType;
                }// end if
                if (param1.resourceName != null)
                {
                    this.resourceName = param1.resourceName;
                }// end if
                if (param1.total != null)
                {
                    this.total = param1.total;
                }// end if
            }// end if
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get resType() : int
        {
            return this._1096575994resType;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function get endTime() : Number
        {
            return this._1607243192endTime;
        }// end function

        public function get price() : Number
        {
            return this._106934601price;
        }// end function

        public function get total() : int
        {
            return this._110549828total;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function copyTo(param1:TransingTradeBean) : void
        {
            param1.amount = this.amount;
            param1.endTime = this.endTime;
            param1.id = this.id;
            param1.price = this.price;
            param1.resType = this.resType;
            param1.resourceName = this.resourceName;
            param1.total = this.total;
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
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

        public function set endTime(param1:Number) : void
        {
            var _loc_2:* = this._1607243192endTime;
            if (_loc_2 !== param1)
            {
                this._1607243192endTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "endTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "amount = " + this.amount + "\n");
            _loc_2 = _loc_2 + (param1 + "endTime = " + this.endTime + "\n");
            _loc_2 = _loc_2 + (param1 + "id = " + this.id + "\n");
            _loc_2 = _loc_2 + (param1 + "price = " + this.price + "\n");
            _loc_2 = _loc_2 + (param1 + "resType = " + this.resType + "\n");
            _loc_2 = _loc_2 + (param1 + "resourceName = " + this.resourceName + "\n");
            _loc_2 = _loc_2 + (param1 + "total = " + this.total + "\n");
            return _loc_2;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.amount = this.amount;
            _loc_1.endTime = this.endTime;
            _loc_1.id = this.id;
            _loc_1.price = this.price;
            _loc_1.resType = this.resType;
            _loc_1.resourceName = this.resourceName;
            _loc_1.total = this.total;
            return _loc_1;
        }// end function

        public function get id() : int
        {
            return this._3355id;
        }// end function

        public function get amount() : int
        {
            return this._1413853096amount;
        }// end function

        public function set total(param1:int) : void
        {
            var _loc_2:* = this._110549828total;
            if (_loc_2 !== param1)
            {
                this._110549828total = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "total", _loc_2, param1));
            }// end if
            return;
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

        public function set resourceName(param1:String) : void
        {
            var _loc_2:* = this._384566343resourceName;
            if (_loc_2 !== param1)
            {
                this._384566343resourceName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resourceName", _loc_2, param1));
            }// end if
            return;
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

        public function get resourceName() : String
        {
            return this._384566343resourceName;
        }// end function

        public function set resType(param1:int) : void
        {
            var _loc_2:* = this._1096575994resType;
            if (_loc_2 !== param1)
            {
                this._1096575994resType = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resType", _loc_2, param1));
            }// end if
            return;
        }// end function

    }
}
