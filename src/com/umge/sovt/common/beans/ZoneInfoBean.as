package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class ZoneInfoBean extends Object implements IEventDispatcher
    {
        private var _531131054playerCount:int;
        private var _764803337castleCount:int;
        private var _3373707name:String;
        private var _3493088rate:int;
        private var _3355id:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function ZoneInfoBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.castleCount != null)
                {
                    this.castleCount = param1.castleCount;
                }// end if
                if (param1.id != null)
                {
                    this.id = param1.id;
                }// end if
                if (param1.name != null)
                {
                    this.name = param1.name;
                }// end if
                if (param1.playerCount != null)
                {
                    this.playerCount = param1.playerCount;
                }// end if
                if (param1.rate != null)
                {
                    this.rate = param1.rate;
                }// end if
            }// end if
            return;
        }// end function

        public function set rate(param1:int) : void
        {
            var _loc_2:* = this._3493088rate;
            if (_loc_2 !== param1)
            {
                this._3493088rate = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rate", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "castleCount = " + this.castleCount + "\n");
            _loc_2 = _loc_2 + (param1 + "id = " + this.id + "\n");
            _loc_2 = _loc_2 + (param1 + "name = " + this.name + "\n");
            _loc_2 = _loc_2 + (param1 + "playerCount = " + this.playerCount + "\n");
            _loc_2 = _loc_2 + (param1 + "rate = " + this.rate + "\n");
            return _loc_2;
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

        public function copyTo(param1:ZoneInfoBean) : void
        {
            param1.castleCount = this.castleCount;
            param1.id = this.id;
            param1.name = this.name;
            param1.playerCount = this.playerCount;
            param1.rate = this.rate;
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
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
            _loc_1.castleCount = this.castleCount;
            _loc_1.id = this.id;
            _loc_1.name = this.name;
            _loc_1.playerCount = this.playerCount;
            _loc_1.rate = this.rate;
            return _loc_1;
        }// end function

        public function get id() : int
        {
            return this._3355id;
        }// end function

        public function get rate() : int
        {
            return this._3493088rate;
        }// end function

        public function set playerCount(param1:int) : void
        {
            var _loc_2:* = this._531131054playerCount;
            if (_loc_2 !== param1)
            {
                this._531131054playerCount = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerCount", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get playerCount() : int
        {
            return this._531131054playerCount;
        }// end function

        public function set castleCount(param1:int) : void
        {
            var _loc_2:* = this._764803337castleCount;
            if (_loc_2 !== param1)
            {
                this._764803337castleCount = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleCount", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get castleCount() : int
        {
            return this._764803337castleCount;
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

    }
}
