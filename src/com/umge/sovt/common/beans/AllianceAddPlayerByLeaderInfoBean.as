package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class AllianceAddPlayerByLeaderInfoBean extends Object implements IEventDispatcher
    {
        private var _1358063253memberCount:int;
        private var _1276224445prestige:int;
        private var _1606140770allianceName:String;
        private var _3492908rank:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function AllianceAddPlayerByLeaderInfoBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.allianceName != null)
                {
                    this.allianceName = param1.allianceName;
                }// end if
                if (param1.memberCount != null)
                {
                    this.memberCount = param1.memberCount;
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

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get prestige() : int
        {
            return this._1276224445prestige;
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

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "allianceName = " + this.allianceName + "\n");
            _loc_2 = _loc_2 + (param1 + "memberCount = " + this.memberCount + "\n");
            _loc_2 = _loc_2 + (param1 + "prestige = " + this.prestige + "\n");
            _loc_2 = _loc_2 + (param1 + "rank = " + this.rank + "\n");
            return _loc_2;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function copyTo(param1:AllianceAddPlayerByLeaderInfoBean) : void
        {
            param1.allianceName = this.allianceName;
            param1.memberCount = this.memberCount;
            param1.prestige = this.prestige;
            param1.rank = this.rank;
            return;
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
            _loc_1.allianceName = this.allianceName;
            _loc_1.memberCount = this.memberCount;
            _loc_1.prestige = this.prestige;
            _loc_1.rank = this.rank;
            return _loc_1;
        }// end function

        public function get memberCount() : int
        {
            return this._1358063253memberCount;
        }// end function

        public function get allianceName() : String
        {
            return this._1606140770allianceName;
        }// end function

        public function set memberCount(param1:int) : void
        {
            var _loc_2:* = this._1358063253memberCount;
            if (_loc_2 !== param1)
            {
                this._1358063253memberCount = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "memberCount", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get rank() : int
        {
            return this._3492908rank;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

    }
}
