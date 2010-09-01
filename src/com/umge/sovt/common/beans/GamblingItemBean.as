package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class GamblingItemBean extends Object implements IEventDispatcher
    {
        private var _bindingEventDispatcher:EventDispatcher;
        private var _3292052kind:int;
        private var _94851343count:int;
        private var _3355id:String;

        public function GamblingItemBean(param1:Object = null)
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
                if (param1.kind != null)
                {
                    this.kind = param1.kind;
                }// end if
            }// end if
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
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
            _loc_2 = _loc_2 + (param1 + "kind = " + this.kind + "\n");
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

        public function get count() : int
        {
            return this._94851343count;
        }// end function

        public function copyTo(param1:GamblingItemBean) : void
        {
            param1.count = this.count;
            param1.id = this.id;
            param1.kind = this.kind;
            return;
        }// end function

        public function get kind() : int
        {
            return this._3292052kind;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.count = this.count;
            _loc_1.id = this.id;
            _loc_1.kind = this.kind;
            return _loc_1;
        }// end function

        public function get id() : String
        {
            return this._3355id;
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

        public function set kind(param1:int) : void
        {
            var _loc_2:* = this._3292052kind;
            if (_loc_2 !== param1)
            {
                this._3292052kind = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "kind", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
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

    }
}
