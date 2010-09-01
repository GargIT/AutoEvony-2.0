package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class TVmsgBean extends Object implements IEventDispatcher
    {
        private var _3560141time:Number;
        private var _108417msg:String;
        private var _bindingEventDispatcher:EventDispatcher;

        public function TVmsgBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.msg != null)
                {
                    this.msg = param1.msg;
                }// end if
                if (param1.time != null)
                {
                    this.time = param1.time;
                }// end if
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function get msg() : String
        {
            return this._108417msg;
        }// end function

        public function set msg(param1:String) : void
        {
            var _loc_2:* = this._108417msg;
            if (_loc_2 !== param1)
            {
                this._108417msg = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "msg", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
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

        public function copyTo(param1:TVmsgBean) : void
        {
            param1.msg = this.msg;
            param1.time = this.time;
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

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "time = " + this.time + "\n");
            return _loc_2;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.msg = this.msg;
            _loc_1.time = this.time;
            return _loc_1;
        }// end function

    }
}
