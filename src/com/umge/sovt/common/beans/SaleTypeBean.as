package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class SaleTypeBean extends Object implements IEventDispatcher
    {
        private var _bindingEventDispatcher:EventDispatcher;
        private var _100526016items:String;
        private var _676507419typeName:String;

        public function SaleTypeBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.items != null)
                {
                    this.items = param1.items;
                }// end if
                if (param1.typeName != null)
                {
                    this.typeName = param1.typeName;
                }// end if
            }// end if
            return;
        }// end function

        public function get items() : String
        {
            return this._100526016items;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function get typeName() : String
        {
            return this._676507419typeName;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function set items(param1:String) : void
        {
            var _loc_2:* = this._100526016items;
            if (_loc_2 !== param1)
            {
                this._100526016items = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "items", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "items = " + this.items + "\n");
            _loc_2 = _loc_2 + (param1 + "typeName = " + this.typeName + "\n");
            return _loc_2;
        }// end function

        public function set typeName(param1:String) : void
        {
            var _loc_2:* = this._676507419typeName;
            if (_loc_2 !== param1)
            {
                this._676507419typeName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeName", _loc_2, param1));
            }// end if
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

        public function copyTo(param1:SaleTypeBean) : void
        {
            param1.items = this.items;
            param1.typeName = this.typeName;
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.items = this.items;
            _loc_1.typeName = this.typeName;
            return _loc_1;
        }// end function

    }
}
