package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class RankHeroBean extends Object implements IEventDispatcher
    {
        private var _3373707name:String;
        private var _1799980989management:int;
        private var _98615255grade:int;
        private var _3292052kind:String;
        private var _3492908rank:int;
        private var _106858757power:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _412944526stratagem:int;

        public function RankHeroBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.grade != null)
                {
                    this.grade = param1.grade;
                }// end if
                if (param1.kind != null)
                {
                    this.kind = param1.kind;
                }// end if
                if (param1.management != null)
                {
                    this.management = param1.management;
                }// end if
                if (param1.name != null)
                {
                    this.name = param1.name;
                }// end if
                if (param1.power != null)
                {
                    this.power = param1.power;
                }// end if
                if (param1.rank != null)
                {
                    this.rank = param1.rank;
                }// end if
                if (param1.stratagem != null)
                {
                    this.stratagem = param1.stratagem;
                }// end if
            }// end if
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get management() : int
        {
            return this._1799980989management;
        }// end function

        public function get power() : int
        {
            return this._106858757power;
        }// end function

        public function set management(param1:int) : void
        {
            var _loc_2:* = this._1799980989management;
            if (_loc_2 !== param1)
            {
                this._1799980989management = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "management", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "grade = " + this.grade + "\n");
            _loc_2 = _loc_2 + (param1 + "kind = " + this.kind + "\n");
            _loc_2 = _loc_2 + (param1 + "management = " + this.management + "\n");
            _loc_2 = _loc_2 + (param1 + "name = " + this.name + "\n");
            _loc_2 = _loc_2 + (param1 + "power = " + this.power + "\n");
            _loc_2 = _loc_2 + (param1 + "rank = " + this.rank + "\n");
            _loc_2 = _loc_2 + (param1 + "stratagem = " + this.stratagem + "\n");
            return _loc_2;
        }// end function

        public function set power(param1:int) : void
        {
            var _loc_2:* = this._106858757power;
            if (_loc_2 !== param1)
            {
                this._106858757power = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "power", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get name() : String
        {
            return this._3373707name;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function copyTo(param1:RankHeroBean) : void
        {
            param1.grade = this.grade;
            param1.kind = this.kind;
            param1.management = this.management;
            param1.name = this.name;
            param1.power = this.power;
            param1.rank = this.rank;
            param1.stratagem = this.stratagem;
            return;
        }// end function

        public function get kind() : String
        {
            return this._3292052kind;
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

        public function get grade() : int
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

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.grade = this.grade;
            _loc_1.kind = this.kind;
            _loc_1.management = this.management;
            _loc_1.name = this.name;
            _loc_1.power = this.power;
            _loc_1.rank = this.rank;
            _loc_1.stratagem = this.stratagem;
            return _loc_1;
        }// end function

        public function set stratagem(param1:int) : void
        {
            var _loc_2:* = this._412944526stratagem;
            if (_loc_2 !== param1)
            {
                this._412944526stratagem = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stratagem", _loc_2, param1));
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

        public function get rank() : int
        {
            return this._3492908rank;
        }// end function

        public function set grade(param1:int) : void
        {
            var _loc_2:* = this._98615255grade;
            if (_loc_2 !== param1)
            {
                this._98615255grade = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "grade", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get stratagem() : int
        {
            return this._412944526stratagem;
        }// end function

    }
}
