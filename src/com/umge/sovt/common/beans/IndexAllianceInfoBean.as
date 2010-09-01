package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class IndexAllianceInfoBean extends Object implements IEventDispatcher
    {
        private var _3492908rank:int;
        private var _1606004101allianceInfo:String;
        private var _1366188353memberLimit:int;
        private var _190875433creatorName:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1606154441allianceNote:String;
        private var _1358063253memberCount:int;
        private var _1191282484leaderName:String;
        private var _1276224445prestige:int;
        private var _1606140770allianceName:String;

        public function IndexAllianceInfoBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.allianceInfo != null)
                {
                    this.allianceInfo = param1.allianceInfo;
                }// end if
                if (param1.allianceName != null)
                {
                    this.allianceName = param1.allianceName;
                }// end if
                if (param1.allianceNote != null)
                {
                    this.allianceNote = param1.allianceNote;
                }// end if
                if (param1.creatorName != null)
                {
                    this.creatorName = param1.creatorName;
                }// end if
                if (param1.leaderName != null)
                {
                    this.leaderName = param1.leaderName;
                }// end if
                if (param1.memberCount != null)
                {
                    this.memberCount = param1.memberCount;
                }// end if
                if (param1.memberLimit != null)
                {
                    this.memberLimit = param1.memberLimit;
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

        public function set memberLimit(param1:int) : void
        {
            var _loc_2:* = this._1366188353memberLimit;
            if (_loc_2 !== param1)
            {
                this._1366188353memberLimit = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "memberLimit", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get allianceInfo() : String
        {
            return this._1606004101allianceInfo;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function set allianceInfo(param1:String) : void
        {
            var _loc_2:* = this._1606004101allianceInfo;
            if (_loc_2 !== param1)
            {
                this._1606004101allianceInfo = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceInfo", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set allianceNote(param1:String) : void
        {
            var _loc_2:* = this._1606154441allianceNote;
            if (_loc_2 !== param1)
            {
                this._1606154441allianceNote = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceNote", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get memberCount() : int
        {
            return this._1358063253memberCount;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.allianceInfo = this.allianceInfo;
            _loc_1.allianceName = this.allianceName;
            _loc_1.allianceNote = this.allianceNote;
            _loc_1.creatorName = this.creatorName;
            _loc_1.leaderName = this.leaderName;
            _loc_1.memberCount = this.memberCount;
            _loc_1.memberLimit = this.memberLimit;
            _loc_1.prestige = this.prestige;
            _loc_1.rank = this.rank;
            return _loc_1;
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

        public function set creatorName(param1:String) : void
        {
            var _loc_2:* = this._190875433creatorName;
            if (_loc_2 !== param1)
            {
                this._190875433creatorName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "creatorName", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get leaderName() : String
        {
            return this._1191282484leaderName;
        }// end function

        public function get memberLimit() : int
        {
            return this._1366188353memberLimit;
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

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "allianceInfo = " + this.allianceInfo + "\n");
            _loc_2 = _loc_2 + (param1 + "allianceName = " + this.allianceName + "\n");
            _loc_2 = _loc_2 + (param1 + "allianceNote = " + this.allianceNote + "\n");
            _loc_2 = _loc_2 + (param1 + "creatorName = " + this.creatorName + "\n");
            _loc_2 = _loc_2 + (param1 + "leaderName = " + this.leaderName + "\n");
            _loc_2 = _loc_2 + (param1 + "memberCount = " + this.memberCount + "\n");
            _loc_2 = _loc_2 + (param1 + "memberLimit = " + this.memberLimit + "\n");
            _loc_2 = _loc_2 + (param1 + "prestige = " + this.prestige + "\n");
            _loc_2 = _loc_2 + (param1 + "rank = " + this.rank + "\n");
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

        public function copyTo(param1:IndexAllianceInfoBean) : void
        {
            param1.allianceInfo = this.allianceInfo;
            param1.allianceName = this.allianceName;
            param1.allianceNote = this.allianceNote;
            param1.creatorName = this.creatorName;
            param1.leaderName = this.leaderName;
            param1.memberCount = this.memberCount;
            param1.memberLimit = this.memberLimit;
            param1.prestige = this.prestige;
            param1.rank = this.rank;
            return;
        }// end function

        public function get creatorName() : String
        {
            return this._190875433creatorName;
        }// end function

        public function get allianceNote() : String
        {
            return this._1606154441allianceNote;
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

        public function get allianceName() : String
        {
            return this._1606140770allianceName;
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

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

    }
}
