package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class StoreBean extends Object implements IEventDispatcher
    {
        private var _358052900storePercent:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _2016783856magnitude:int;
        private var _292680141warehourseCapacity:int;
        private var _1096322212resLimt:int;
        private var _172472894unstorage:int;
        private var _1795184074storeTypeId:int;
        private var _1884274053storage:int;

        public function StoreBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.magnitude != null)
                {
                    this.magnitude = param1.magnitude;
                }// end if
                if (param1.resLimt != null)
                {
                    this.resLimt = param1.resLimt;
                }// end if
                if (param1.storage != null)
                {
                    this.storage = param1.storage;
                }// end if
                if (param1.storePercent != null)
                {
                    this.storePercent = param1.storePercent;
                }// end if
                if (param1.storeTypeId != null)
                {
                    this.storeTypeId = param1.storeTypeId;
                }// end if
                if (param1.unstorage != null)
                {
                    this.unstorage = param1.unstorage;
                }// end if
                if (param1.warehourseCapacity != null)
                {
                    this.warehourseCapacity = param1.warehourseCapacity;
                }// end if
            }// end if
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get unstorage() : int
        {
            return this._172472894unstorage;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function set unstorage(param1:int) : void
        {
            var _loc_2:* = this._172472894unstorage;
            if (_loc_2 !== param1)
            {
                this._172472894unstorage = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "unstorage", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function set resLimt(param1:int) : void
        {
            var _loc_2:* = this._1096322212resLimt;
            if (_loc_2 !== param1)
            {
                this._1096322212resLimt = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resLimt", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "magnitude = " + this.magnitude + "\n");
            _loc_2 = _loc_2 + (param1 + "resLimt = " + this.resLimt + "\n");
            _loc_2 = _loc_2 + (param1 + "storage = " + this.storage + "\n");
            _loc_2 = _loc_2 + (param1 + "storePercent = " + this.storePercent + "\n");
            _loc_2 = _loc_2 + (param1 + "storeTypeId = " + this.storeTypeId + "\n");
            _loc_2 = _loc_2 + (param1 + "unstorage = " + this.unstorage + "\n");
            _loc_2 = _loc_2 + (param1 + "warehourseCapacity = " + this.warehourseCapacity + "\n");
            return _loc_2;
        }// end function

        public function get warehourseCapacity() : int
        {
            return this._292680141warehourseCapacity;
        }// end function

        public function set storePercent(param1:int) : void
        {
            var _loc_2:* = this._358052900storePercent;
            if (_loc_2 !== param1)
            {
                this._358052900storePercent = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "storePercent", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function copyTo(param1:StoreBean) : void
        {
            param1.magnitude = this.magnitude;
            param1.resLimt = this.resLimt;
            param1.storage = this.storage;
            param1.storePercent = this.storePercent;
            param1.storeTypeId = this.storeTypeId;
            param1.unstorage = this.unstorage;
            param1.warehourseCapacity = this.warehourseCapacity;
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

        public function get magnitude() : int
        {
            return this._2016783856magnitude;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.magnitude = this.magnitude;
            _loc_1.resLimt = this.resLimt;
            _loc_1.storage = this.storage;
            _loc_1.storePercent = this.storePercent;
            _loc_1.storeTypeId = this.storeTypeId;
            _loc_1.unstorage = this.unstorage;
            _loc_1.warehourseCapacity = this.warehourseCapacity;
            return _loc_1;
        }// end function

        public function set magnitude(param1:int) : void
        {
            var _loc_2:* = this._2016783856magnitude;
            if (_loc_2 !== param1)
            {
                this._2016783856magnitude = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "magnitude", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set warehourseCapacity(param1:int) : void
        {
            var _loc_2:* = this._292680141warehourseCapacity;
            if (_loc_2 !== param1)
            {
                this._292680141warehourseCapacity = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "warehourseCapacity", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get resLimt() : int
        {
            return this._1096322212resLimt;
        }// end function

        public function get storePercent() : int
        {
            return this._358052900storePercent;
        }// end function

        public function set storeTypeId(param1:int) : void
        {
            var _loc_2:* = this._1795184074storeTypeId;
            if (_loc_2 !== param1)
            {
                this._1795184074storeTypeId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "storeTypeId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set storage(param1:int) : void
        {
            var _loc_2:* = this._1884274053storage;
            if (_loc_2 !== param1)
            {
                this._1884274053storage = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "storage", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get storage() : int
        {
            return this._1884274053storage;
        }// end function

        public function get storeTypeId() : int
        {
            return this._1795184074storeTypeId;
        }// end function

    }
}
