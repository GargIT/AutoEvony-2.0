package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class ConditionDependBuildingBean extends Object implements IEventDispatcher
    {
        private var _540315940curLevel:int;
        private var _1268712945successFlag:Boolean;
        private var _858803723typeId:int;
        private var _102865796level:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function ConditionDependBuildingBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.curLevel != null)
                {
                    this.curLevel = param1.curLevel;
                }// end if
                if (param1.level != null)
                {
                    this.level = param1.level;
                }// end if
                if (param1.typeId != null)
                {
                    this.typeId = param1.typeId;
                }// end if
                if (param1.successFlag != null)
                {
                    this.successFlag = param1.successFlag;
                }// end if
            }// end if
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get level() : int
        {
            return this._102865796level;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function set curLevel(param1:int) : void
        {
            var _loc_2:* = this._540315940curLevel;
            if (_loc_2 !== param1)
            {
                this._540315940curLevel = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curLevel", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "curLevel = " + this.curLevel + "\n");
            _loc_2 = _loc_2 + (param1 + "level = " + this.level + "\n");
            _loc_2 = _loc_2 + (param1 + "typeId = " + this.typeId + "\n");
            _loc_2 = _loc_2 + (param1 + "successFlag = " + this.successFlag + "\n");
            return _loc_2;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function set level(param1:int) : void
        {
            var _loc_2:* = this._102865796level;
            if (_loc_2 !== param1)
            {
                this._102865796level = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "level", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function copyTo(param1:ConditionDependBuildingBean) : void
        {
            param1.curLevel = this.curLevel;
            param1.level = this.level;
            param1.typeId = this.typeId;
            param1.successFlag = this.successFlag;
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
            _loc_1.curLevel = this.curLevel;
            _loc_1.level = this.level;
            _loc_1.typeId = this.typeId;
            _loc_1.successFlag = this.successFlag;
            return _loc_1;
        }// end function

        public function set successFlag(param1:Boolean) : void
        {
            var _loc_2:* = this._1268712945successFlag;
            if (_loc_2 !== param1)
            {
                this._1268712945successFlag = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "successFlag", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get curLevel() : int
        {
            return this._540315940curLevel;
        }// end function

        public function get successFlag() : Boolean
        {
            return this._1268712945successFlag;
        }// end function

        public function set typeId(param1:int) : void
        {
            var _loc_2:* = this._858803723typeId;
            if (_loc_2 !== param1)
            {
                this._858803723typeId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function get typeId() : int
        {
            return this._858803723typeId;
        }// end function

    }
}
