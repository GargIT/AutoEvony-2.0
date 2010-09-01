package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class AllianceEvent extends Object implements IEventDispatcher
    {
        private var _3560141time:Number;
        private var _31228997eventName:String;
        private var _bindingEventDispatcher:EventDispatcher;

        public function AllianceEvent(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.eventName != null)
                {
                    this.eventName = param1.eventName;
                }// end if
                if (param1.time != null)
                {
                    this.time = param1.time;
                }// end if
            }// end if
            return;
        }// end function

        public function set time(param1:Number) : void
        {
            var _loc_2:* = this._3560141time;
            if (_loc_2 !== param1)
            {
                this._3560141time = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "time", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function get eventName() : String
        {
            return this._31228997eventName;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "eventName = " + this.eventName + "\n");
            _loc_2 = _loc_2 + (param1 + "time = " + this.time + "\n");
            return _loc_2;
        }// end function

        public function set eventName(param1:String) : void
        {
            var _loc_2:* = this._31228997eventName;
            if (_loc_2 !== param1)
            {
                this._31228997eventName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "eventName", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get time() : Number
        {
            return this._3560141time;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function copyTo(param1:AllianceEvent) : void
        {
            param1.eventName = this.eventName;
            param1.time = this.time;
            return;
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

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.eventName = this.eventName;
            _loc_1.time = this.time;
            return _loc_1;
        }// end function

    }
}
