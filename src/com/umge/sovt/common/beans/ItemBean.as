package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class ItemBean extends Object implements IEventDispatcher
    {
        private var _3355id:String;
        private var _3373707name:String;
        private var _382106123maxCount:int;
        private var _1394090531minCount:int;
        private var _94851343count:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function ItemBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.count != null)
                {
                    this.count = param1.count;
                }// end if
                if (param1.id != null)
                {
                    this.id = param1.id;
                }// end if
                if (param1.maxCount != null)
                {
                    this.maxCount = param1.maxCount;
                }// end if
                if (param1.minCount != null)
                {
                    this.minCount = param1.minCount;
                }// end if
                if (param1.name != null)
                {
                    this.name = param1.name;
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

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "count = " + this.count + "\n");
            _loc_2 = _loc_2 + (param1 + "id = " + this.id + "\n");
            _loc_2 = _loc_2 + (param1 + "maxCount = " + this.maxCount + "\n");
            _loc_2 = _loc_2 + (param1 + "minCount = " + this.minCount + "\n");
            _loc_2 = _loc_2 + (param1 + "name = " + this.name + "\n");
            return _loc_2;
        }// end function

        public function get name() : String
        {
            return this._3373707name;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function get count() : int
        {
            return this._94851343count;
        }// end function

        public function copyTo(param1:ItemBean) : void
        {
            param1.count = this.count;
            param1.id = this.id;
            param1.maxCount = this.maxCount;
            param1.minCount = this.minCount;
            param1.name = this.name;
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function get maxCount() : int
        {
            return this._382106123maxCount;
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

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.count = this.count;
            _loc_1.id = this.id;
            _loc_1.maxCount = this.maxCount;
            _loc_1.minCount = this.minCount;
            _loc_1.name = this.name;
            return _loc_1;
        }// end function

        public function get id() : String
        {
            return this._3355id;
        }// end function

        public function get minCount() : int
        {
            return this._1394090531minCount;
        }// end function

        public function set count(param1:int) : void
        {
            var _loc_2:* = this._94851343count;
            if (_loc_2 !== param1)
            {
                this._94851343count = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "count", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set id(param1:String) : void
        {
            var _loc_2:* = this._3355id;
            if (_loc_2 !== param1)
            {
                this._3355id = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "id", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set maxCount(param1:int) : void
        {
            var _loc_2:* = this._382106123maxCount;
            if (_loc_2 !== param1)
            {
                this._382106123maxCount = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxCount", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set minCount(param1:int) : void
        {
            var _loc_2:* = this._1394090531minCount;
            if (_loc_2 !== param1)
            {
                this._1394090531minCount = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "minCount", _loc_2, param1));
            }// end if
            return;
        }// end function

    }
}
