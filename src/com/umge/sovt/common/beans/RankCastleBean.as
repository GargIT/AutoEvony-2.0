package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class RankCastleBean extends Object implements IEventDispatcher
    {
        private var _2023558323population:int;
        private var _3373707name:String;
        private var _98615255grade:String;
        private var _3292052kind:String;
        private var _102865796level:int;
        private var _3492908rank:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1806944311alliance:String;

        public function RankCastleBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.alliance != null)
                {
                    this.alliance = param1.alliance;
                }// end if
                if (param1.grade != null)
                {
                    this.grade = param1.grade;
                }// end if
                if (param1.kind != null)
                {
                    this.kind = param1.kind;
                }// end if
                if (param1.level != null)
                {
                    this.level = param1.level;
                }// end if
                if (param1.name != null)
                {
                    this.name = param1.name;
                }// end if
                if (param1.population != null)
                {
                    this.population = param1.population;
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

        public function get level() : int
        {
            return this._102865796level;
        }// end function

        public function set level(param1:int) : void
        {
            var _loc_2:* = this._102865796level;
            if (_loc_2 !== param1)
            {
                this._102865796level = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "level", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "alliance = " + this.alliance + "\n");
            _loc_2 = _loc_2 + (param1 + "grade = " + this.grade + "\n");
            _loc_2 = _loc_2 + (param1 + "kind = " + this.kind + "\n");
            _loc_2 = _loc_2 + (param1 + "level = " + this.level + "\n");
            _loc_2 = _loc_2 + (param1 + "name = " + this.name + "\n");
            _loc_2 = _loc_2 + (param1 + "population = " + this.population + "\n");
            _loc_2 = _loc_2 + (param1 + "rank = " + this.rank + "\n");
            return _loc_2;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function get name() : String
        {
            return this._3373707name;
        }// end function

        public function get population() : int
        {
            return this._2023558323population;
        }// end function

        public function copyTo(param1:RankCastleBean) : void
        {
            param1.alliance = this.alliance;
            param1.grade = this.grade;
            param1.kind = this.kind;
            param1.level = this.level;
            param1.name = this.name;
            param1.population = this.population;
            param1.rank = this.rank;
            return;
        }// end function

        public function get kind() : String
        {
            return this._3292052kind;
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

        public function get grade() : String
        {
            return this._98615255grade;
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
            _loc_1.alliance = this.alliance;
            _loc_1.grade = this.grade;
            _loc_1.kind = this.kind;
            _loc_1.level = this.level;
            _loc_1.name = this.name;
            _loc_1.population = this.population;
            _loc_1.rank = this.rank;
            return _loc_1;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function set population(param1:int) : void
        {
            var _loc_2:* = this._2023558323population;
            if (_loc_2 !== param1)
            {
                this._2023558323population = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "population", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get rank() : int
        {
            return this._3492908rank;
        }// end function

        public function set alliance(param1:String) : void
        {
            var _loc_2:* = this._1806944311alliance;
            if (_loc_2 !== param1)
            {
                this._1806944311alliance = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alliance", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set kind(param1:String) : void
        {
            var _loc_2:* = this._3292052kind;
            if (_loc_2 !== param1)
            {
                this._3292052kind = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "kind", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set grade(param1:String) : void
        {
            var _loc_2:* = this._98615255grade;
            if (_loc_2 !== param1)
            {
                this._98615255grade = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "grade", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get alliance() : String
        {
            return this._1806944311alliance;
        }// end function

    }
}
