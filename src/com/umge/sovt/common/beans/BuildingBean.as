package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class BuildingBean extends Object implements IEventDispatcher
    {
        private var _1607243192endTime:Number;
        private var _892481550status:int;
        private var _3373707name:String;
        private var _2129294769startTime:Number;
        private var _858803723typeId:int;
        private var _1381039140positionId:int;
        private var _102865796level:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function BuildingBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.endTime != null)
                {
                    this.endTime = param1.endTime;
                }// end if
                if (param1.level != null)
                {
                    this.level = param1.level;
                }// end if
                if (param1.name != null)
                {
                    this.name = param1.name;
                }// end if
                if (param1.positionId != null)
                {
                    this.positionId = param1.positionId;
                }// end if
                if (param1.startTime != null)
                {
                    this.startTime = param1.startTime;
                }// end if
                if (param1.status != null)
                {
                    this.status = param1.status;
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

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "endTime = " + this.endTime + "\n");
            _loc_2 = _loc_2 + (param1 + "level = " + this.level + "\n");
            _loc_2 = _loc_2 + (param1 + "name = " + this.name + "\n");
            _loc_2 = _loc_2 + (param1 + "positionId = " + this.positionId + "\n");
            _loc_2 = _loc_2 + (param1 + "startTime = " + this.startTime + "\n");
            _loc_2 = _loc_2 + (param1 + "status = " + this.status + "\n");
            _loc_2 = _loc_2 + (param1 + "typeId = " + this.typeId + "\n");
            return _loc_2;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function get level() : int
        {
            return this._102865796level;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function copyTo(param1:BuildingBean) : void
        {
            param1.endTime = this.endTime;
            param1.level = this.level;
            param1.name = this.name;
            param1.positionId = this.positionId;
            param1.startTime = this.startTime;
            param1.status = this.status;
            param1.typeId = this.typeId;
            return;
        }// end function

        public function get name() : String
        {
            return this._3373707name;
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

        public function get endTime() : Number
        {
            return this._1607243192endTime;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.endTime = this.endTime;
            _loc_1.level = this.level;
            _loc_1.name = this.name;
            _loc_1.positionId = this.positionId;
            _loc_1.startTime = this.startTime;
            _loc_1.status = this.status;
            _loc_1.typeId = this.typeId;
            return _loc_1;
        }// end function

        public function get startTime() : Number
        {
            return this._2129294769startTime;
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

        public function set positionId(param1:int) : void
        {
            var _loc_2:* = this._1381039140positionId;
            if (_loc_2 !== param1)
            {
                this._1381039140positionId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "positionId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get positionId() : int
        {
            return this._1381039140positionId;
        }// end function

        public function set startTime(param1:Number) : void
        {
            var _loc_2:* = this._2129294769startTime;
            if (_loc_2 !== param1)
            {
                this._2129294769startTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set status(param1:int) : void
        {
            var _loc_2:* = this._892481550status;
            if (_loc_2 !== param1)
            {
                this._892481550status = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "status", _loc_2, param1));
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

        public function get status() : int
        {
            return this._892481550status;
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
