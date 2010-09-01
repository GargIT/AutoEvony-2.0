package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class UnitAlliance extends Object implements IEventDispatcher
    {
        private var _913519701aPrestigeCount:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1358063253memberCount:int;
        private var _1191282484leaderName:String;
        private var _99462250honor:int;
        private var _1606140770allianceName:String;
        private var _3492908rank:int;

        public function UnitAlliance(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.aPrestigeCount != null)
                {
                    this.aPrestigeCount = param1.aPrestigeCount;
                }// end if
                if (param1.allianceName != null)
                {
                    this.allianceName = param1.allianceName;
                }// end if
                if (param1.honor != null)
                {
                    this.honor = param1.honor;
                }// end if
                if (param1.leaderName != null)
                {
                    this.leaderName = param1.leaderName;
                }// end if
                if (param1.memberCount != null)
                {
                    this.memberCount = param1.memberCount;
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
            _loc_2 = _loc_2 + (param1 + "aPrestigeCount = " + this.aPrestigeCount + "\n");
            _loc_2 = _loc_2 + (param1 + "allianceName = " + this.allianceName + "\n");
            _loc_2 = _loc_2 + (param1 + "honor = " + this.honor + "\n");
            _loc_2 = _loc_2 + (param1 + "leaderName = " + this.leaderName + "\n");
            _loc_2 = _loc_2 + (param1 + "memberCount = " + this.memberCount + "\n");
            _loc_2 = _loc_2 + (param1 + "rank = " + this.rank + "\n");
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

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function copyTo(param1:UnitAlliance) : void
        {
            param1.aPrestigeCount = this.aPrestigeCount;
            param1.allianceName = this.allianceName;
            param1.honor = this.honor;
            param1.leaderName = this.leaderName;
            param1.memberCount = this.memberCount;
            param1.rank = this.rank;
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
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

        public function get memberCount() : int
        {
            return this._1358063253memberCount;
        }// end function

        public function set aPrestigeCount(param1:int) : void
        {
            var _loc_2:* = this._913519701aPrestigeCount;
            if (_loc_2 !== param1)
            {
                this._913519701aPrestigeCount = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "aPrestigeCount", _loc_2, param1));
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
            _loc_1.aPrestigeCount = this.aPrestigeCount;
            _loc_1.allianceName = this.allianceName;
            _loc_1.honor = this.honor;
            _loc_1.leaderName = this.leaderName;
            _loc_1.memberCount = this.memberCount;
            _loc_1.rank = this.rank;
            return _loc_1;
        }// end function

        public function get allianceName() : String
        {
            return this._1606140770allianceName;
        }// end function

        public function get honor() : int
        {
            return this._99462250honor;
        }// end function

        public function get aPrestigeCount() : int
        {
            return this._913519701aPrestigeCount;
        }// end function

        public function get rank() : int
        {
            return this._3492908rank;
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

        public function get leaderName() : String
        {
            return this._1191282484leaderName;
        }// end function

        public function set leaderName(param1:String) : void
        {
            var _loc_2:* = this._1191282484leaderName;
            if (_loc_2 !== param1)
            {
                this._1191282484leaderName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "leaderName", _loc_2, param1));
            }// end if
            return;
        }// end function

    }
}
