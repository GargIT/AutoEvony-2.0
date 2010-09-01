package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class CastleSignInfoBean extends Object implements IEventDispatcher
    {
        private var _120x:int;
        private var _3373707name:String;
        private var _121y:int;
        private var _3355id:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function CastleSignInfoBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.id != null)
                {
                    this.id = param1.id;
                }// end if
                if (param1.name != null)
                {
                    this.name = param1.name;
                }// end if
                if (param1.x != null)
                {
                    this.x = param1.x;
                }// end if
                if (param1.y != null)
                {
                    this.y = param1.y;
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
            _loc_2 = _loc_2 + (param1 + "id = " + this.id + "\n");
            _loc_2 = _loc_2 + (param1 + "name = " + this.name + "\n");
            _loc_2 = _loc_2 + (param1 + "x = " + this.x + "\n");
            _loc_2 = _loc_2 + (param1 + "y = " + this.y + "\n");
            return _loc_2;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
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

        public function copyTo(param1:CastleSignInfoBean) : void
        {
            param1.id = this.id;
            param1.name = this.name;
            param1.x = this.x;
            param1.y = this.y;
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.id = this.id;
            _loc_1.name = this.name;
            _loc_1.x = this.x;
            _loc_1.y = this.y;
            return _loc_1;
        }// end function

        public function get id() : int
        {
            return this._3355id;
        }// end function

        public function set x(param1:int) : void
        {
            var _loc_2:* = this._120x;
            if (_loc_2 !== param1)
            {
                this._120x = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "x", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set y(param1:int) : void
        {
            var _loc_2:* = this._121y;
            if (_loc_2 !== param1)
            {
                this._121y = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "y", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get x() : int
        {
            return this._120x;
        }// end function

        public function get y() : int
        {
            return this._121y;
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

    }
}
