package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class MilitarySituation extends Object implements IEventDispatcher
    {
        private var _1316782738startPos:String;
        private var _1833139858otherAllianceName:String;
        private var _3575610type:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _3355id:int;
        private var _3560141time:Number;
        private var _31228997eventName:String;
        private var _1407259064attack:Boolean;
        private var _179745070xml_data:String;
        private var _815590653targetPos:String;

        public function MilitarySituation(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.eventName != null)
                {
                    this.eventName = param1.eventName;
                }// end if
                if (param1.id != null)
                {
                    this.id = param1.id;
                }// end if
                if (param1.otherAllianceName != null)
                {
                    this.otherAllianceName = param1.otherAllianceName;
                }// end if
                if (param1.startPos != null)
                {
                    this.startPos = param1.startPos;
                }// end if
                if (param1.targetPos != null)
                {
                    this.targetPos = param1.targetPos;
                }// end if
                if (param1.time != null)
                {
                    this.time = param1.time;
                }// end if
                if (param1.type != null)
                {
                    this.type = param1.type;
                }// end if
                if (param1.xml_data != null)
                {
                    this.xml_data = param1.xml_data;
                }// end if
                if (param1.attack != null)
                {
                    this.attack = param1.attack;
                }// end if
            }// end if
            return;
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

        public function set targetPos(param1:String) : void
        {
            var _loc_2:* = this._815590653targetPos;
            if (_loc_2 !== param1)
            {
                this._815590653targetPos = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetPos", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get otherAllianceName() : String
        {
            return this._1833139858otherAllianceName;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function set type(param1:int) : void
        {
            var _loc_2:* = this._3575610type;
            if (_loc_2 !== param1)
            {
                this._3575610type = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get startPos() : String
        {
            return this._1316782738startPos;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.eventName = this.eventName;
            _loc_1.id = this.id;
            _loc_1.otherAllianceName = this.otherAllianceName;
            _loc_1.startPos = this.startPos;
            _loc_1.targetPos = this.targetPos;
            _loc_1.time = this.time;
            _loc_1.type = this.type;
            _loc_1.xml_data = this.xml_data;
            _loc_1.attack = this.attack;
            return _loc_1;
        }// end function

        public function get id() : int
        {
            return this._3355id;
        }// end function

        public function set attack(param1:Boolean) : void
        {
            var _loc_2:* = this._1407259064attack;
            if (_loc_2 !== param1)
            {
                this._1407259064attack = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "attack", _loc_2, param1));
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

        public function set xml_data(param1:String) : void
        {
            var _loc_2:* = this._179745070xml_data;
            if (_loc_2 !== param1)
            {
                this._179745070xml_data = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "xml_data", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get targetPos() : String
        {
            return this._815590653targetPos;
        }// end function

        public function set otherAllianceName(param1:String) : void
        {
            var _loc_2:* = this._1833139858otherAllianceName;
            if (_loc_2 !== param1)
            {
                this._1833139858otherAllianceName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "otherAllianceName", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set startPos(param1:String) : void
        {
            var _loc_2:* = this._1316782738startPos;
            if (_loc_2 !== param1)
            {
                this._1316782738startPos = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startPos", _loc_2, param1));
            }// end if
            return;
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

        public function get type() : int
        {
            return this._3575610type;
        }// end function

        public function get eventName() : String
        {
            return this._31228997eventName;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get attack() : Boolean
        {
            return this._1407259064attack;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "eventName = " + this.eventName + "\n");
            _loc_2 = _loc_2 + (param1 + "id = " + this.id + "\n");
            _loc_2 = _loc_2 + (param1 + "otherAllianceName = " + this.otherAllianceName + "\n");
            _loc_2 = _loc_2 + (param1 + "startPos = " + this.startPos + "\n");
            _loc_2 = _loc_2 + (param1 + "targetPos = " + this.targetPos + "\n");
            _loc_2 = _loc_2 + (param1 + "time = " + this.time + "\n");
            _loc_2 = _loc_2 + (param1 + "type = " + this.type + "\n");
            _loc_2 = _loc_2 + (param1 + "xml_data = " + this.xml_data + "\n");
            _loc_2 = _loc_2 + (param1 + "attack = " + this.attack + "\n");
            return _loc_2;
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

        public function copyTo(param1:MilitarySituation) : void
        {
            param1.eventName = this.eventName;
            param1.id = this.id;
            param1.otherAllianceName = this.otherAllianceName;
            param1.startPos = this.startPos;
            param1.targetPos = this.targetPos;
            param1.time = this.time;
            param1.type = this.type;
            param1.xml_data = this.xml_data;
            param1.attack = this.attack;
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function get xml_data() : String
        {
            return this._179745070xml_data;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

    }
}
