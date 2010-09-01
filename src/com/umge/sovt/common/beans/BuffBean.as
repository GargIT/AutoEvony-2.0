package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class BuffBean extends Object implements IEventDispatcher
    {
        private var _1017134268descName:String;
        private var _1607243192endTime:Number;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _858803723typeId:String;

        public function BuffBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.descName != null)
                {
                    this.descName = param1.descName;
                }// end if
                if (param1.endTime != null)
                {
                    this.endTime = param1.endTime;
                }// end if
                if (param1.typeId != null)
                {
                    this.typeId = param1.typeId;
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
            _loc_2 = _loc_2 + (param1 + "descName = " + this.descName + "\n");
            _loc_2 = _loc_2 + (param1 + "endTime = " + this.endTime + "\n");
            _loc_2 = _loc_2 + (param1 + "typeId = " + this.typeId + "\n");
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

        public function get endTime() : Number
        {
            return this._1607243192endTime;
        }// end function

        public function copyTo(param1:BuffBean) : void
        {
            param1.descName = this.descName;
            param1.endTime = this.endTime;
            param1.typeId = this.typeId;
            return;
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

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.descName = this.descName;
            _loc_1.endTime = this.endTime;
            _loc_1.typeId = this.typeId;
            return _loc_1;
        }// end function

        public function set typeId(param1:String) : void
        {
            var _loc_2:* = this._858803723typeId;
            if (_loc_2 !== param1)
            {
                this._858803723typeId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get typeId() : String
        {
            return this._858803723typeId;
        }// end function

        public function set descName(param1:String) : void
        {
            var _loc_2:* = this._1017134268descName;
            if (_loc_2 !== param1)
            {
                this._1017134268descName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "descName", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function get descName() : String
        {
            return this._1017134268descName;
        }// end function

    }
}
