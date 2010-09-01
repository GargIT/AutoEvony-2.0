package com.umge.sovt.eum
{
    import flash.events.*;
    import mx.events.*;

    public class ItemEum extends Object implements IEventDispatcher
    {
        private var _321656496userLimit:int;
        private var _3373707name:String;
        private var _106934601price:int;
        private var _1177037892itemDesc:String;
        private var _1177533677itemType:String;
        private var _619236819heroItem:Boolean = false;
        private var _3355id:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _2095526292playerItem:Boolean = false;
        private var _1638765110iconUrl:String;
        private var _1913436543dayLimit:int;
        private var _3079825desc:String;

        public function ItemEum()
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            return;
        }// end function

        public function set itemDesc(param1:String) : void
        {
            var _loc_2:* = this._1177037892itemDesc;
            if (_loc_2 !== param1)
            {
                this._1177037892itemDesc = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemDesc", _loc_2, param1));
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

        public function get desc() : String
        {
            return this._3079825desc;
        }// end function

        public function set price(param1:int) : void
        {
            var _loc_2:* = this._106934601price;
            if (_loc_2 !== param1)
            {
                this._106934601price = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "price", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get playerItem() : Boolean
        {
            return this._2095526292playerItem;
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

        public function get id() : String
        {
            return this._3355id;
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

        public function get heroItem() : Boolean
        {
            return this._619236819heroItem;
        }// end function

        public function set playerItem(param1:Boolean) : void
        {
            var _loc_2:* = this._2095526292playerItem;
            if (_loc_2 !== param1)
            {
                this._2095526292playerItem = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerItem", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get userLimit() : int
        {
            return this._321656496userLimit;
        }// end function

        public function set id(param1:String) : void
        {
            var _loc_2:* = this._3355id;
            if (_loc_2 !== param1)
            {
                this._3355id = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "id", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get iconUrl() : String
        {
            return this._1638765110iconUrl;
        }// end function

        public function get itemDesc() : String
        {
            return this._1177037892itemDesc;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get price() : int
        {
            return this._106934601price;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function set userLimit(param1:int) : void
        {
            var _loc_2:* = this._321656496userLimit;
            if (_loc_2 !== param1)
            {
                this._321656496userLimit = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "userLimit", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set itemType(param1:String) : void
        {
            var _loc_2:* = this._1177533677itemType;
            if (_loc_2 !== param1)
            {
                this._1177533677itemType = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemType", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set heroItem(param1:Boolean) : void
        {
            var _loc_2:* = this._619236819heroItem;
            if (_loc_2 !== param1)
            {
                this._619236819heroItem = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroItem", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set iconUrl(param1:String) : void
        {
            var _loc_2:* = this._1638765110iconUrl;
            if (_loc_2 !== param1)
            {
                this._1638765110iconUrl = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iconUrl", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get itemType() : String
        {
            return this._1177533677itemType;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function set dayLimit(param1:int) : void
        {
            var _loc_2:* = this._1913436543dayLimit;
            if (_loc_2 !== param1)
            {
                this._1913436543dayLimit = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dayLimit", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get dayLimit() : int
        {
            return this._1913436543dayLimit;
        }// end function

    }
}
