package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class ConditionDependItemBean extends Object implements IEventDispatcher
    {
        private var _109446num:int;
        private var _1349154522curNum:int;
        private var _1268712945successFlag:Boolean;
        private var _3355id:String;
        private var _bindingEventDispatcher:EventDispatcher;

        public function ConditionDependItemBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.curNum != null)
                {
                    this.curNum = param1.curNum;
                }// end if
                if (param1.id != null)
                {
                    this.id = param1.id;
                }// end if
                if (param1.num != null)
                {
                    this.num = param1.num;
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

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function get num() : int
        {
            return this._109446num;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "curNum = " + this.curNum + "\n");
            _loc_2 = _loc_2 + (param1 + "id = " + this.id + "\n");
            _loc_2 = _loc_2 + (param1 + "num = " + this.num + "\n");
            _loc_2 = _loc_2 + (param1 + "successFlag = " + this.successFlag + "\n");
            return _loc_2;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function set num(param1:int) : void
        {
            var _loc_2:* = this._109446num;
            if (_loc_2 !== param1)
            {
                this._109446num = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "num", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get successFlag() : Boolean
        {
            return this._1268712945successFlag;
        }// end function

        public function copyTo(param1:ConditionDependItemBean) : void
        {
            param1.curNum = this.curNum;
            param1.id = this.id;
            param1.num = this.num;
            param1.successFlag = this.successFlag;
            return;
        }// end function

        public function set curNum(param1:int) : void
        {
            var _loc_2:* = this._1349154522curNum;
            if (_loc_2 !== param1)
            {
                this._1349154522curNum = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curNum", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.curNum = this.curNum;
            _loc_1.id = this.id;
            _loc_1.num = this.num;
            _loc_1.successFlag = this.successFlag;
            return _loc_1;
        }// end function

        public function get id() : String
        {
            return this._3355id;
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

        public function get curNum() : int
        {
            return this._1349154522curNum;
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
