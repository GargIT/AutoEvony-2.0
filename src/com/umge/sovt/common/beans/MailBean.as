package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class MailBean extends Object implements IEventDispatcher
    {
        private var _441951604targetId:int;
        private var _853090240type_id:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _905962955sender:String;
        private var _2103439280receiveTime:Number;
        private var _1081573102mailid:int;
        private var _1879273436playerId:int;
        private var _1191572123selected:Boolean;
        private var _1180158496isRead:int;
        private var _808719889receiver:String;
        private var _110371416title:String;

        public function MailBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.isRead != null)
                {
                    this.isRead = param1.isRead;
                }// end if
                if (param1.mailid != null)
                {
                    this.mailid = param1.mailid;
                }// end if
                if (param1.playerId != null)
                {
                    this.playerId = param1.playerId;
                }// end if
                if (param1.receiveTime != null)
                {
                    this.receiveTime = param1.receiveTime;
                }// end if
                if (param1.receiver != null)
                {
                    this.receiver = param1.receiver;
                }// end if
                if (param1.sender != null)
                {
                    this.sender = param1.sender;
                }// end if
                if (param1.targetId != null)
                {
                    this.targetId = param1.targetId;
                }// end if
                if (param1.title != null)
                {
                    this.title = param1.title;
                }// end if
                if (param1.type_id != null)
                {
                    this.type_id = param1.type_id;
                }// end if
                if (param1.selected != null)
                {
                    this.selected = param1.selected;
                }// end if
            }// end if
            return;
        }// end function

        public function set type_id(param1:int) : void
        {
            var _loc_2:* = this._853090240type_id;
            if (_loc_2 !== param1)
            {
                this._853090240type_id = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type_id", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get targetId() : int
        {
            return this._441951604targetId;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function get mailid() : int
        {
            return this._1081573102mailid;
        }// end function

        public function set targetId(param1:int) : void
        {
            var _loc_2:* = this._441951604targetId;
            if (_loc_2 !== param1)
            {
                this._441951604targetId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.isRead = this.isRead;
            _loc_1.mailid = this.mailid;
            _loc_1.playerId = this.playerId;
            _loc_1.receiveTime = this.receiveTime;
            _loc_1.receiver = this.receiver;
            _loc_1.sender = this.sender;
            _loc_1.targetId = this.targetId;
            _loc_1.title = this.title;
            _loc_1.type_id = this.type_id;
            _loc_1.selected = this.selected;
            return _loc_1;
        }// end function

        public function get selected() : Boolean
        {
            return this._1191572123selected;
        }// end function

        public function set receiveTime(param1:Number) : void
        {
            var _loc_2:* = this._2103439280receiveTime;
            if (_loc_2 !== param1)
            {
                this._2103439280receiveTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "receiveTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set mailid(param1:int) : void
        {
            var _loc_2:* = this._1081573102mailid;
            if (_loc_2 !== param1)
            {
                this._1081573102mailid = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mailid", _loc_2, param1));
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

        public function get sender() : String
        {
            return this._905962955sender;
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

        public function set playerId(param1:int) : void
        {
            var _loc_2:* = this._1879273436playerId;
            if (_loc_2 !== param1)
            {
                this._1879273436playerId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerId", _loc_2, param1));
            }// end if
            return;
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

        public function get type_id() : int
        {
            return this._853090240type_id;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "isRead = " + this.isRead + "\n");
            _loc_2 = _loc_2 + (param1 + "mailid = " + this.mailid + "\n");
            _loc_2 = _loc_2 + (param1 + "playerId = " + this.playerId + "\n");
            _loc_2 = _loc_2 + (param1 + "receiveTime = " + this.receiveTime + "\n");
            _loc_2 = _loc_2 + (param1 + "receiver = " + this.receiver + "\n");
            _loc_2 = _loc_2 + (param1 + "sender = " + this.sender + "\n");
            _loc_2 = _loc_2 + (param1 + "targetId = " + this.targetId + "\n");
            _loc_2 = _loc_2 + (param1 + "title = " + this.title + "\n");
            _loc_2 = _loc_2 + (param1 + "type_id = " + this.type_id + "\n");
            _loc_2 = _loc_2 + (param1 + "selected = " + this.selected + "\n");
            return _loc_2;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function copyTo(param1:MailBean) : void
        {
            param1.isRead = this.isRead;
            param1.mailid = this.mailid;
            param1.playerId = this.playerId;
            param1.receiveTime = this.receiveTime;
            param1.receiver = this.receiver;
            param1.sender = this.sender;
            param1.targetId = this.targetId;
            param1.title = this.title;
            param1.type_id = this.type_id;
            param1.selected = this.selected;
            return;
        }// end function

        public function get receiveTime() : Number
        {
            return this._2103439280receiveTime;
        }// end function

        public function get title() : String
        {
            return this._110371416title;
        }// end function

        public function get playerId() : int
        {
            return this._1879273436playerId;
        }// end function

        public function set receiver(param1:String) : void
        {
            var _loc_2:* = this._808719889receiver;
            if (_loc_2 !== param1)
            {
                this._808719889receiver = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "receiver", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get isRead() : int
        {
            return this._1180158496isRead;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function get receiver() : String
        {
            return this._808719889receiver;
        }// end function

        public function set sender(param1:String) : void
        {
            var _loc_2:* = this._905962955sender;
            if (_loc_2 !== param1)
            {
                this._905962955sender = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sender", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

    }
}
