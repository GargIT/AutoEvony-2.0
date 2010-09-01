package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class QuestTargetBean extends Object implements IEventDispatcher
    {
        private var _3373707name:String;
        private var _673660814finished:Boolean;
        private var _bindingEventDispatcher:EventDispatcher;

        public function QuestTargetBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.name != null)
                {
                    this.name = param1.name;
                }// end if
                if (param1.finished != null)
                {
                    this.finished = param1.finished;
                }// end if
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function set finished(param1:Boolean) : void
        {
            var _loc_2:* = this._673660814finished;
            if (_loc_2 !== param1)
            {
                this._673660814finished = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "finished", _loc_2, param1));
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
            _loc_2 = _loc_2 + (param1 + "name = " + this.name + "\n");
            _loc_2 = _loc_2 + (param1 + "finished = " + this.finished + "\n");
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

        public function get finished() : Boolean
        {
            return this._673660814finished;
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

        public function copyTo(param1:QuestTargetBean) : void
        {
            param1.name = this.name;
            param1.finished = this.finished;
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.name = this.name;
            _loc_1.finished = this.finished;
            return _loc_1;
        }// end function

    }
}
