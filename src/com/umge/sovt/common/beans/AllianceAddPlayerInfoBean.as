package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class AllianceAddPlayerInfoBean extends Object implements IEventDispatcher
    {
        private var _bindingEventDispatcher:EventDispatcher;
        private var _109757585state:String;
        private var _1198082422inviteTime:Number;
        private var _1276224445prestige:int;
        private var _266666762userName:String;
        private var _187927486invitePerson:String;
        private var _3492908rank:int;

        public function AllianceAddPlayerInfoBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.invitePerson != null)
                {
                    this.invitePerson = param1.invitePerson;
                }// end if
                if (param1.inviteTime != null)
                {
                    this.inviteTime = param1.inviteTime;
                }// end if
                if (param1.prestige != null)
                {
                    this.prestige = param1.prestige;
                }// end if
                if (param1.rank != null)
                {
                    this.rank = param1.rank;
                }// end if
                if (param1.state != null)
                {
                    this.state = param1.state;
                }// end if
                if (param1.userName != null)
                {
                    this.userName = param1.userName;
                }// end if
            }// end if
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get prestige() : int
        {
            return this._1276224445prestige;
        }// end function

        public function set userName(param1:String) : void
        {
            var _loc_2:* = this._266666762userName;
            if (_loc_2 !== param1)
            {
                this._266666762userName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "userName", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "invitePerson = " + this.invitePerson + "\n");
            _loc_2 = _loc_2 + (param1 + "inviteTime = " + this.inviteTime + "\n");
            _loc_2 = _loc_2 + (param1 + "prestige = " + this.prestige + "\n");
            _loc_2 = _loc_2 + (param1 + "rank = " + this.rank + "\n");
            _loc_2 = _loc_2 + (param1 + "state = " + this.state + "\n");
            _loc_2 = _loc_2 + (param1 + "userName = " + this.userName + "\n");
            return _loc_2;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function copyTo(param1:AllianceAddPlayerInfoBean) : void
        {
            param1.invitePerson = this.invitePerson;
            param1.inviteTime = this.inviteTime;
            param1.prestige = this.prestige;
            param1.rank = this.rank;
            param1.state = this.state;
            param1.userName = this.userName;
            return;
        }// end function

        public function get state() : String
        {
            return this._109757585state;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function set prestige(param1:int) : void
        {
            var _loc_2:* = this._1276224445prestige;
            if (_loc_2 !== param1)
            {
                this._1276224445prestige = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "prestige", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function set rank(param1:int) : void
        {
            var _loc_2:* = this._3492908rank;
            if (_loc_2 !== param1)
            {
                this._3492908rank = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rank", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.invitePerson = this.invitePerson;
            _loc_1.inviteTime = this.inviteTime;
            _loc_1.prestige = this.prestige;
            _loc_1.rank = this.rank;
            _loc_1.state = this.state;
            _loc_1.userName = this.userName;
            return _loc_1;
        }// end function

        public function set state(param1:String) : void
        {
            var _loc_2:* = this._109757585state;
            if (_loc_2 !== param1)
            {
                this._109757585state = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "state", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get rank() : int
        {
            return this._3492908rank;
        }// end function

        public function get inviteTime() : Number
        {
            return this._1198082422inviteTime;
        }// end function

        public function set inviteTime(param1:Number) : void
        {
            var _loc_2:* = this._1198082422inviteTime;
            if (_loc_2 !== param1)
            {
                this._1198082422inviteTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inviteTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set invitePerson(param1:String) : void
        {
            var _loc_2:* = this._187927486invitePerson;
            if (_loc_2 !== param1)
            {
                this._187927486invitePerson = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "invitePerson", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get userName() : String
        {
            return this._266666762userName;
        }// end function

        public function get invitePerson() : String
        {
            return this._187927486invitePerson;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

    }
}
