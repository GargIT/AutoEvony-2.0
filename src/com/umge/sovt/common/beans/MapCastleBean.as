package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class MapCastleBean extends Object implements IEventDispatcher
    {
        private var _554436100relation:int;
        private var _3373707name:String;
        private var _99462250honor:int;
        private var _98100801canOccupy:Boolean;
        private var _3355id:int;
        private var _138006258canScout:Boolean;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _109281npc:Boolean;
        private var _549540504canLoot:Boolean;
        private var _848059479zoneName:String;
        private var _3145580flag:String;
        private var _109757585state:int;
        private var _1276224445prestige:int;
        private var _266666762userName:String;
        private var _136649544canTrans:Boolean;
        private var _549739384canSend:Boolean;
        private var _1606140770allianceName:String;
        private var _1299492445playerLogoUrl:String;

        public function MapCastleBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.allianceName != null)
                {
                    this.allianceName = param1.allianceName;
                }// end if
                if (param1.flag != null)
                {
                    this.flag = param1.flag;
                }// end if
                if (param1.honor != null)
                {
                    this.honor = param1.honor;
                }// end if
                if (param1.id != null)
                {
                    this.id = param1.id;
                }// end if
                if (param1.name != null)
                {
                    this.name = param1.name;
                }// end if
                if (param1.playerLogoUrl != null)
                {
                    this.playerLogoUrl = param1.playerLogoUrl;
                }// end if
                if (param1.prestige != null)
                {
                    this.prestige = param1.prestige;
                }// end if
                if (param1.relation != null)
                {
                    this.relation = param1.relation;
                }// end if
                if (param1.state != null)
                {
                    this.state = param1.state;
                }// end if
                if (param1.userName != null)
                {
                    this.userName = param1.userName;
                }// end if
                if (param1.zoneName != null)
                {
                    this.zoneName = param1.zoneName;
                }// end if
                if (param1.canLoot != null)
                {
                    this.canLoot = param1.canLoot;
                }// end if
                if (param1.canOccupy != null)
                {
                    this.canOccupy = param1.canOccupy;
                }// end if
                if (param1.canScout != null)
                {
                    this.canScout = param1.canScout;
                }// end if
                if (param1.canSend != null)
                {
                    this.canSend = param1.canSend;
                }// end if
                if (param1.canTrans != null)
                {
                    this.canTrans = param1.canTrans;
                }// end if
                if (param1.npc != null)
                {
                    this.npc = param1.npc;
                }// end if
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
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

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function get state() : int
        {
            return this._109757585state;
        }// end function

        public function get name() : String
        {
            return this._3373707name;
        }// end function

        public function get canLoot() : Boolean
        {
            return this._549540504canLoot;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.allianceName = this.allianceName;
            _loc_1.flag = this.flag;
            _loc_1.honor = this.honor;
            _loc_1.id = this.id;
            _loc_1.name = this.name;
            _loc_1.playerLogoUrl = this.playerLogoUrl;
            _loc_1.prestige = this.prestige;
            _loc_1.relation = this.relation;
            _loc_1.state = this.state;
            _loc_1.userName = this.userName;
            _loc_1.zoneName = this.zoneName;
            _loc_1.canLoot = this.canLoot;
            _loc_1.canOccupy = this.canOccupy;
            _loc_1.canScout = this.canScout;
            _loc_1.canSend = this.canSend;
            _loc_1.canTrans = this.canTrans;
            _loc_1.npc = this.npc;
            return _loc_1;
        }// end function

        public function get id() : int
        {
            return this._3355id;
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

        public function get canScout() : Boolean
        {
            return this._138006258canScout;
        }// end function

        public function set state(param1:int) : void
        {
            var _loc_2:* = this._109757585state;
            if (_loc_2 !== param1)
            {
                this._109757585state = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "state", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set canScout(param1:Boolean) : void
        {
            var _loc_2:* = this._138006258canScout;
            if (_loc_2 !== param1)
            {
                this._138006258canScout = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canScout", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set zoneName(param1:String) : void
        {
            var _loc_2:* = this._848059479zoneName;
            if (_loc_2 !== param1)
            {
                this._848059479zoneName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "zoneName", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set canLoot(param1:Boolean) : void
        {
            var _loc_2:* = this._549540504canLoot;
            if (_loc_2 !== param1)
            {
                this._549540504canLoot = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canLoot", _loc_2, param1));
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

        public function get canTrans() : Boolean
        {
            return this._136649544canTrans;
        }// end function

        public function get playerLogoUrl() : String
        {
            return this._1299492445playerLogoUrl;
        }// end function

        public function get canOccupy() : Boolean
        {
            return this._98100801canOccupy;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function set npc(param1:Boolean) : void
        {
            var _loc_2:* = this._109281npc;
            if (_loc_2 !== param1)
            {
                this._109281npc = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "npc", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get prestige() : int
        {
            return this._1276224445prestige;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "allianceName = " + this.allianceName + "\n");
            _loc_2 = _loc_2 + (param1 + "flag = " + this.flag + "\n");
            _loc_2 = _loc_2 + (param1 + "honor = " + this.honor + "\n");
            _loc_2 = _loc_2 + (param1 + "id = " + this.id + "\n");
            _loc_2 = _loc_2 + (param1 + "name = " + this.name + "\n");
            _loc_2 = _loc_2 + (param1 + "playerLogoUrl = " + this.playerLogoUrl + "\n");
            _loc_2 = _loc_2 + (param1 + "prestige = " + this.prestige + "\n");
            _loc_2 = _loc_2 + (param1 + "relation = " + this.relation + "\n");
            _loc_2 = _loc_2 + (param1 + "state = " + this.state + "\n");
            _loc_2 = _loc_2 + (param1 + "userName = " + this.userName + "\n");
            _loc_2 = _loc_2 + (param1 + "zoneName = " + this.zoneName + "\n");
            _loc_2 = _loc_2 + (param1 + "canLoot = " + this.canLoot + "\n");
            _loc_2 = _loc_2 + (param1 + "canOccupy = " + this.canOccupy + "\n");
            _loc_2 = _loc_2 + (param1 + "canScout = " + this.canScout + "\n");
            _loc_2 = _loc_2 + (param1 + "canSend = " + this.canSend + "\n");
            _loc_2 = _loc_2 + (param1 + "canTrans = " + this.canTrans + "\n");
            _loc_2 = _loc_2 + (param1 + "npc = " + this.npc + "\n");
            return _loc_2;
        }// end function

        public function set allianceName(param1:String) : void
        {
            var _loc_2:* = this._1606140770allianceName;
            if (_loc_2 !== param1)
            {
                this._1606140770allianceName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceName", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set playerLogoUrl(param1:String) : void
        {
            var _loc_2:* = this._1299492445playerLogoUrl;
            if (_loc_2 !== param1)
            {
                this._1299492445playerLogoUrl = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerLogoUrl", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function copyTo(param1:MapCastleBean) : void
        {
            param1.allianceName = this.allianceName;
            param1.flag = this.flag;
            param1.honor = this.honor;
            param1.id = this.id;
            param1.name = this.name;
            param1.playerLogoUrl = this.playerLogoUrl;
            param1.prestige = this.prestige;
            param1.relation = this.relation;
            param1.state = this.state;
            param1.userName = this.userName;
            param1.zoneName = this.zoneName;
            param1.canLoot = this.canLoot;
            param1.canOccupy = this.canOccupy;
            param1.canScout = this.canScout;
            param1.canSend = this.canSend;
            param1.canTrans = this.canTrans;
            param1.npc = this.npc;
            return;
        }// end function

        public function set honor(param1:int) : void
        {
            var _loc_2:* = this._99462250honor;
            if (_loc_2 !== param1)
            {
                this._99462250honor = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "honor", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get zoneName() : String
        {
            return this._848059479zoneName;
        }// end function

        public function set flag(param1:String) : void
        {
            var _loc_2:* = this._3145580flag;
            if (_loc_2 !== param1)
            {
                this._3145580flag = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "flag", _loc_2, param1));
            }// end if
            return;
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

        public function get npc() : Boolean
        {
            return this._109281npc;
        }// end function

        public function get allianceName() : String
        {
            return this._1606140770allianceName;
        }// end function

        public function get honor() : int
        {
            return this._99462250honor;
        }// end function

        public function get flag() : String
        {
            return this._3145580flag;
        }// end function

        public function set canSend(param1:Boolean) : void
        {
            var _loc_2:* = this._549739384canSend;
            if (_loc_2 !== param1)
            {
                this._549739384canSend = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canSend", _loc_2, param1));
            }// end if
            return;
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

        public function set canTrans(param1:Boolean) : void
        {
            var _loc_2:* = this._136649544canTrans;
            if (_loc_2 !== param1)
            {
                this._136649544canTrans = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canTrans", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set relation(param1:int) : void
        {
            var _loc_2:* = this._554436100relation;
            if (_loc_2 !== param1)
            {
                this._554436100relation = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "relation", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get relation() : int
        {
            return this._554436100relation;
        }// end function

        public function get userName() : String
        {
            return this._266666762userName;
        }// end function

        public function set canOccupy(param1:Boolean) : void
        {
            var _loc_2:* = this._98100801canOccupy;
            if (_loc_2 !== param1)
            {
                this._98100801canOccupy = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canOccupy", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get canSend() : Boolean
        {
            return this._549739384canSend;
        }// end function

    }
}
