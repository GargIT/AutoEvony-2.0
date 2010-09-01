package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class QuestTypeBean extends Object implements IEventDispatcher
    {
        private var _600408483isFinish:Boolean;
        private var _3373707name:String;
        private var _1724546052description:String;
        private var _1081572172mainId:int;
        private var _858803723typeId:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function QuestTypeBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.description != null)
                {
                    this.description = param1.description;
                }// end if
                if (param1.mainId != null)
                {
                    this.mainId = param1.mainId;
                }// end if
                if (param1.name != null)
                {
                    this.name = param1.name;
                }// end if
                if (param1.typeId != null)
                {
                    this.typeId = param1.typeId;
                }// end if
                if (param1.isFinish != null)
                {
                    this.isFinish = param1.isFinish;
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
            _loc_2 = _loc_2 + (param1 + "description = " + this.description + "\n");
            _loc_2 = _loc_2 + (param1 + "mainId = " + this.mainId + "\n");
            _loc_2 = _loc_2 + (param1 + "name = " + this.name + "\n");
            _loc_2 = _loc_2 + (param1 + "typeId = " + this.typeId + "\n");
            _loc_2 = _loc_2 + (param1 + "isFinish = " + this.isFinish + "\n");
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

        public function copyTo(param1:QuestTypeBean) : void
        {
            param1.description = this.description;
            param1.mainId = this.mainId;
            param1.name = this.name;
            param1.typeId = this.typeId;
            param1.isFinish = this.isFinish;
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

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.description = this.description;
            _loc_1.mainId = this.mainId;
            _loc_1.name = this.name;
            _loc_1.typeId = this.typeId;
            _loc_1.isFinish = this.isFinish;
            return _loc_1;
        }// end function

        public function get isFinish() : Boolean
        {
            return this._600408483isFinish;
        }// end function

        public function set mainId(param1:int) : void
        {
            var _loc_2:* = this._1081572172mainId;
            if (_loc_2 !== param1)
            {
                this._1081572172mainId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mainId", _loc_2, param1));
            }// end if
            return;
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

        public function get mainId() : int
        {
            return this._1081572172mainId;
        }// end function

        public function get typeId() : int
        {
            return this._858803723typeId;
        }// end function

        public function set description(param1:String) : void
        {
            var _loc_2:* = this._1724546052description;
            if (_loc_2 !== param1)
            {
                this._1724546052description = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "description", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set isFinish(param1:Boolean) : void
        {
            var _loc_2:* = this._600408483isFinish;
            if (_loc_2 !== param1)
            {
                this._600408483isFinish = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isFinish", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get description() : String
        {
            return this._1724546052description;
        }// end function

    }
}
