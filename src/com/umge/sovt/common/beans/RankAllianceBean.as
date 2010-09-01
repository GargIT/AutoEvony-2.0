package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class RankAllianceBean extends Object implements IEventDispatcher
    {
        private var _3492908rank:int;
        private var _3373707name:String;
        private var _1077769574member:int;
        private var _99462250honor:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1724546052description:String;
        private var _1276224445prestige:int;
        private var _477166943createrName:String;
        private var _3053931city:int;
        private var _2095657228playerName:String;

        public function RankAllianceBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.city != null)
                {
                    this.city = param1.city;
                }// end if
                if (param1.createrName != null)
                {
                    this.createrName = param1.createrName;
                }// end if
                if (param1.description != null)
                {
                    this.description = param1.description;
                }// end if
                if (param1.honor != null)
                {
                    this.honor = param1.honor;
                }// end if
                if (param1.member != null)
                {
                    this.member = param1.member;
                }// end if
                if (param1.name != null)
                {
                    this.name = param1.name;
                }// end if
                if (param1.playerName != null)
                {
                    this.playerName = param1.playerName;
                }// end if
                if (param1.prestige != null)
                {
                    this.prestige = param1.prestige;
                }// end if
                if (param1.rank != null)
                {
                    this.rank = param1.rank;
                }// end if
            }// end if
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

        public function get name() : String
        {
            return this._3373707name;
        }// end function

        public function get playerName() : String
        {
            return this._2095657228playerName;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
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

        public function set playerName(param1:String) : void
        {
            var _loc_2:* = this._2095657228playerName;
            if (_loc_2 !== param1)
            {
                this._2095657228playerName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerName", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.city = this.city;
            _loc_1.createrName = this.createrName;
            _loc_1.description = this.description;
            _loc_1.honor = this.honor;
            _loc_1.member = this.member;
            _loc_1.name = this.name;
            _loc_1.playerName = this.playerName;
            _loc_1.prestige = this.prestige;
            _loc_1.rank = this.rank;
            return _loc_1;
        }// end function

        public function get createrName() : String
        {
            return this._477166943createrName;
        }// end function

        public function get member() : int
        {
            return this._1077769574member;
        }// end function

        public function get rank() : int
        {
            return this._3492908rank;
        }// end function

        public function set member(param1:int) : void
        {
            var _loc_2:* = this._1077769574member;
            if (_loc_2 !== param1)
            {
                this._1077769574member = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "member", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function set createrName(param1:String) : void
        {
            var _loc_2:* = this._477166943createrName;
            if (_loc_2 !== param1)
            {
                this._477166943createrName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "createrName", _loc_2, param1));
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
            _loc_2 = _loc_2 + (param1 + "city = " + this.city + "\n");
            _loc_2 = _loc_2 + (param1 + "createrName = " + this.createrName + "\n");
            _loc_2 = _loc_2 + (param1 + "description = " + this.description + "\n");
            _loc_2 = _loc_2 + (param1 + "honor = " + this.honor + "\n");
            _loc_2 = _loc_2 + (param1 + "member = " + this.member + "\n");
            _loc_2 = _loc_2 + (param1 + "name = " + this.name + "\n");
            _loc_2 = _loc_2 + (param1 + "playerName = " + this.playerName + "\n");
            _loc_2 = _loc_2 + (param1 + "prestige = " + this.prestige + "\n");
            _loc_2 = _loc_2 + (param1 + "rank = " + this.rank + "\n");
            return _loc_2;
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

        public function set city(param1:int) : void
        {
            var _loc_2:* = this._3053931city;
            if (_loc_2 !== param1)
            {
                this._3053931city = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "city", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function copyTo(param1:RankAllianceBean) : void
        {
            param1.city = this.city;
            param1.createrName = this.createrName;
            param1.description = this.description;
            param1.honor = this.honor;
            param1.member = this.member;
            param1.name = this.name;
            param1.playerName = this.playerName;
            param1.prestige = this.prestige;
            param1.rank = this.rank;
            return;
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

        public function get honor() : int
        {
            return this._99462250honor;
        }// end function

        public function get city() : int
        {
            return this._3053931city;
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

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function get description() : String
        {
            return this._1724546052description;
        }// end function

    }
}
