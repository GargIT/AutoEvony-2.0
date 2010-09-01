package com.umge.sovt.common.beans
{
    import com.umge.sovt.common.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.events.*;

    public class FieldBean extends Object implements IEventDispatcher
    {
        private var _109757601statu:int;
        private var _3373707name:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _3575610type:int;
        private var _102865796level:int;
        private var _1710868093armysArray:ArrayCollection;
        private var _3355id:int;

        public function FieldBean(param1:Object = null)
        {
            var _loc_2:int;
            var _loc_3:ArmyBean;
            _1710868093armysArray = new ArrayCollection();
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.id != null)
                {
                    this.id = param1.id;
                }// end if
                if (param1.level != null)
                {
                    this.level = param1.level;
                }// end if
                if (param1.name != null)
                {
                    this.name = param1.name;
                }// end if
                if (param1.statu != null)
                {
                    this.statu = param1.statu;
                }// end if
                if (param1.type != null)
                {
                    this.type = param1.type;
                }// end if
                if (param1.armys)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.armys.length)
                    {
                        // label
                        _loc_3 = new ArmyBean(param1.armys[_loc_2]);
                        this.armysArray.addItem(_loc_3);
                        _loc_2++;
                    }// end while
                }// end if
            }// end if
            return;
        }// end function

        public function getArmys(param1:int) : ArmyBean
        {
            var _loc_2:* = this.armysArray[param1] as ArmyBean;
            return _loc_2;
        }// end function

        public function get type() : int
        {
            return this._3575610type;
        }// end function

        public function set type(param1:int) : void
        {
            var _loc_2:* = this._3575610type;
            if (_loc_2 !== param1)
            {
                this._3575610type = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get level() : int
        {
            return this._102865796level;
        }// end function

        public function set armysArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._1710868093armysArray;
            if (_loc_2 !== param1)
            {
                this._1710868093armysArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armysArray", _loc_2, param1));
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
            _loc_2 = _loc_2 + (param1 + "id = " + this.id + "\n");
            _loc_2 = _loc_2 + (param1 + "level = " + this.level + "\n");
            _loc_2 = _loc_2 + (param1 + "name = " + this.name + "\n");
            _loc_2 = _loc_2 + (param1 + "statu = " + this.statu + "\n");
            _loc_2 = _loc_2 + (param1 + "type = " + this.type + "\n");
            _loc_3 = 0;
            while (_loc_3 < this.armysArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getArmys(_loc_3).toDebugString(param1 + "armys[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function get armysArray() : ArrayCollection
        {
            return this._1710868093armysArray;
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

        public function set statu(param1:int) : void
        {
            var _loc_2:* = this._109757601statu;
            if (_loc_2 !== param1)
            {
                this._109757601statu = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statu", _loc_2, param1));
            }// end if
            return;
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

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.id = this.id;
            _loc_1.level = this.level;
            _loc_1.name = this.name;
            _loc_1.statu = this.statu;
            _loc_1.type = this.type;
            return _loc_1;
        }// end function

        public function get id() : int
        {
            return this._3355id;
        }// end function

        public function copyTo(param1:FieldBean) : void
        {
            param1.id = this.id;
            param1.level = this.level;
            param1.name = this.name;
            param1.statu = this.statu;
            param1.type = this.type;
            CommonUtil.arrayCopy(this.armysArray, param1.armysArray);
            return;
        }// end function

        public function get statu() : int
        {
            return this._109757601statu;
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

        public function setArmys(param1:ArmyBean, param2:int) : void
        {
            this.armysArray[param2] = param1;
            return;
        }// end function

    }
}
