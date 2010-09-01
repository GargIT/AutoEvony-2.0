package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class ReportBean extends Object implements IEventDispatcher
    {
        private var _110371416title:String;
        private var _1316782738startPos:String;
        private var _3575610type:int;
        private var _3355id:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1414939017armyType:int;
        private var _1191572123selected:Boolean;
        private var _951530617content:String;
        private var _1180158496isRead:int;
        private var _1407259064attack:Boolean;
        private var _3015911back:Boolean;
        private var _31415431eventTime:Number;
        private var _815590653targetPos:String;

        public function ReportBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.armyType != null)
                {
                    this.armyType = param1.armyType;
                }// end if
                if (param1.content != null)
                {
                    this.content = param1.content;
                }// end if
                if (param1.eventTime != null)
                {
                    this.eventTime = param1.eventTime;
                }// end if
                if (param1.id != null)
                {
                    this.id = param1.id;
                }// end if
                if (param1.isRead != null)
                {
                    this.isRead = param1.isRead;
                }// end if
                if (param1.startPos != null)
                {
                    this.startPos = param1.startPos;
                }// end if
                if (param1.targetPos != null)
                {
                    this.targetPos = param1.targetPos;
                }// end if
                if (param1.title != null)
                {
                    this.title = param1.title;
                }// end if
                if (param1.type != null)
                {
                    this.type = param1.type;
                }// end if
                if (param1.attack != null)
                {
                    this.attack = param1.attack;
                }// end if
                if (param1.back != null)
                {
                    this.back = param1.back;
                }// end if
                if (param1.selected != null)
                {
                    this.selected = param1.selected;
                }// end if
            }// end if
            return;
        }// end function

        public function get eventTime() : Number
        {
            return this._31415431eventTime;
        }// end function

        public function get targetPos() : String
        {
            return this._815590653targetPos;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
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

        public function set eventTime(param1:Number) : void
        {
            var _loc_2:* = this._31415431eventTime;
            if (_loc_2 !== param1)
            {
                this._31415431eventTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "eventTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get startPos() : String
        {
            return this._1316782738startPos;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
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

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.armyType = this.armyType;
            _loc_1.content = this.content;
            _loc_1.eventTime = this.eventTime;
            _loc_1.id = this.id;
            _loc_1.isRead = this.isRead;
            _loc_1.startPos = this.startPos;
            _loc_1.targetPos = this.targetPos;
            _loc_1.title = this.title;
            _loc_1.type = this.type;
            _loc_1.attack = this.attack;
            _loc_1.back = this.back;
            _loc_1.selected = this.selected;
            return _loc_1;
        }// end function

        public function get id() : int
        {
            return this._3355id;
        }// end function

        public function get selected() : Boolean
        {
            return this._1191572123selected;
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

        public function set title(param1:String) : void
        {
            var _loc_2:* = this._110371416title;
            if (_loc_2 !== param1)
            {
                this._110371416title = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "title", _loc_2, param1));
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

        public function set selected(param1:Boolean) : void
        {
            var _loc_2:* = this._1191572123selected;
            if (_loc_2 !== param1)
            {
                this._1191572123selected = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selected", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get type() : int
        {
            return this._3575610type;
        }// end function

        public function set isRead(param1:int) : void
        {
            var _loc_2:* = this._1180158496isRead;
            if (_loc_2 !== param1)
            {
                this._1180158496isRead = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isRead", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get attack() : Boolean
        {
            return this._1407259064attack;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "armyType = " + this.armyType + "\n");
            _loc_2 = _loc_2 + (param1 + "content = " + this.content + "\n");
            _loc_2 = _loc_2 + (param1 + "eventTime = " + this.eventTime + "\n");
            _loc_2 = _loc_2 + (param1 + "id = " + this.id + "\n");
            _loc_2 = _loc_2 + (param1 + "isRead = " + this.isRead + "\n");
            _loc_2 = _loc_2 + (param1 + "startPos = " + this.startPos + "\n");
            _loc_2 = _loc_2 + (param1 + "targetPos = " + this.targetPos + "\n");
            _loc_2 = _loc_2 + (param1 + "title = " + this.title + "\n");
            _loc_2 = _loc_2 + (param1 + "type = " + this.type + "\n");
            _loc_2 = _loc_2 + (param1 + "attack = " + this.attack + "\n");
            _loc_2 = _loc_2 + (param1 + "back = " + this.back + "\n");
            _loc_2 = _loc_2 + (param1 + "selected = " + this.selected + "\n");
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

        public function set back(param1:Boolean) : void
        {
            var _loc_2:* = this._3015911back;
            if (_loc_2 !== param1)
            {
                this._3015911back = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "back", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function copyTo(param1:ReportBean) : void
        {
            param1.armyType = this.armyType;
            param1.content = this.content;
            param1.eventTime = this.eventTime;
            param1.id = this.id;
            param1.isRead = this.isRead;
            param1.startPos = this.startPos;
            param1.targetPos = this.targetPos;
            param1.title = this.title;
            param1.type = this.type;
            param1.attack = this.attack;
            param1.back = this.back;
            param1.selected = this.selected;
            return;
        }// end function

        public function get title() : String
        {
            return this._110371416title;
        }// end function

        public function get back() : Boolean
        {
            return this._3015911back;
        }// end function

        public function set armyType(param1:int) : void
        {
            var _loc_2:* = this._1414939017armyType;
            if (_loc_2 !== param1)
            {
                this._1414939017armyType = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyType", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set content(param1:String) : void
        {
            var _loc_2:* = this._951530617content;
            if (_loc_2 !== param1)
            {
                this._951530617content = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "content", _loc_2, param1));
            }// end if
            return;
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

        public function get armyType() : int
        {
            return this._1414939017armyType;
        }// end function

        public function get isRead() : int
        {
            return this._1180158496isRead;
        }// end function

        public function get content() : String
        {
            return this._951530617content;
        }// end function

    }
}
