package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class AllianceQueryBean extends Object implements IEventDispatcher
    {
        private var _1344718425bulletin:String;
        private var _102976443limit:int;
        private var _3373707name:String;
        private var _1349154522curNum:int;
        private var _190875433creatorName:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1191282484leaderName:String;
        private var _1276224445prestige:int;
        private var _3079825desc:String;
        private var _978111542ranking:int;

        public function AllianceQueryBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.bulletin != null)
                {
                    this.bulletin = param1.bulletin;
                }// end if
                if (param1.creatorName != null)
                {
                    this.creatorName = param1.creatorName;
                }// end if
                if (param1.curNum != null)
                {
                    this.curNum = param1.curNum;
                }// end if
                if (param1.desc != null)
                {
                    this.desc = param1.desc;
                }// end if
                if (param1.leaderName != null)
                {
                    this.leaderName = param1.leaderName;
                }// end if
                if (param1.limit != null)
                {
                    this.limit = param1.limit;
                }// end if
                if (param1.name != null)
                {
                    this.name = param1.name;
                }// end if
                if (param1.prestige != null)
                {
                    this.prestige = param1.prestige;
                }// end if
                if (param1.ranking != null)
                {
                    this.ranking = param1.ranking;
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

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.bulletin = this.bulletin;
            _loc_1.creatorName = this.creatorName;
            _loc_1.curNum = this.curNum;
            _loc_1.desc = this.desc;
            _loc_1.leaderName = this.leaderName;
            _loc_1.limit = this.limit;
            _loc_1.name = this.name;
            _loc_1.prestige = this.prestige;
            _loc_1.ranking = this.ranking;
            return _loc_1;
        }// end function

        public function get desc() : String
        {
            return this._3079825desc;
        }// end function

        public function get curNum() : int
        {
            return this._1349154522curNum;
        }// end function

        public function get bulletin() : String
        {
            return this._1344718425bulletin;
        }// end function

        public function set desc(param1:String) : void
        {
            var _loc_2:* = this._3079825desc;
            if (_loc_2 !== param1)
            {
                this._3079825desc = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desc", _loc_2, param1));
            }// end if
            return;
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

        public function get ranking() : int
        {
            return this._978111542ranking;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get limit() : int
        {
            return this._102976443limit;
        }// end function

        public function get prestige() : int
        {
            return this._1276224445prestige;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "bulletin = " + this.bulletin + "\n");
            _loc_2 = _loc_2 + (param1 + "creatorName = " + this.creatorName + "\n");
            _loc_2 = _loc_2 + (param1 + "curNum = " + this.curNum + "\n");
            _loc_2 = _loc_2 + (param1 + "desc = " + this.desc + "\n");
            _loc_2 = _loc_2 + (param1 + "leaderName = " + this.leaderName + "\n");
            _loc_2 = _loc_2 + (param1 + "limit = " + this.limit + "\n");
            _loc_2 = _loc_2 + (param1 + "name = " + this.name + "\n");
            _loc_2 = _loc_2 + (param1 + "prestige = " + this.prestige + "\n");
            _loc_2 = _loc_2 + (param1 + "ranking = " + this.ranking + "\n");
            return _loc_2;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function set curNum(param1:int) : void
        {
            var _loc_2:* = this._1349154522curNum;
            if (_loc_2 !== param1)
            {
                this._1349154522curNum = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curNum", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function set bulletin(param1:String) : void
        {
            var _loc_2:* = this._1344718425bulletin;
            if (_loc_2 !== param1)
            {
                this._1344718425bulletin = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bulletin", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function copyTo(param1:AllianceQueryBean) : void
        {
            param1.bulletin = this.bulletin;
            param1.creatorName = this.creatorName;
            param1.curNum = this.curNum;
            param1.desc = this.desc;
            param1.leaderName = this.leaderName;
            param1.limit = this.limit;
            param1.name = this.name;
            param1.prestige = this.prestige;
            param1.ranking = this.ranking;
            return;
        }// end function

        public function get creatorName() : String
        {
            return this._190875433creatorName;
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

        public function set ranking(param1:int) : void
        {
            var _loc_2:* = this._978111542ranking;
            if (_loc_2 !== param1)
            {
                this._978111542ranking = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ranking", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function set limit(param1:int) : void
        {
            var _loc_2:* = this._102976443limit;
            if (_loc_2 !== param1)
            {
                this._102976443limit = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "limit", _loc_2, param1));
            }// end if
            return;
        }// end function

    }
}
