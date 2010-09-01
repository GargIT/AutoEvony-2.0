package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class AvailableResearchListBean extends Object implements IEventDispatcher
    {
        private var _1780023352avalevel:int;
        private var _1607243192endTime:Number;
        private var _1999144890upgradeing:Boolean;
        private var _102865796level:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1371991915conditionBean:ConditionBean;
        private var _2129294769startTime:Number;
        private var _35872819castleId:Number;
        private var _858803723typeId:int;
        private var _676059661permition:Boolean;

        public function AvailableResearchListBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.avalevel != null)
                {
                    this.avalevel = param1.avalevel;
                }// end if
                if (param1.castleId != null)
                {
                    this.castleId = param1.castleId;
                }// end if
                if (param1.conditionBean != null)
                {
                    this.conditionBean = new ConditionBean(param1.conditionBean);
                }// end if
                if (param1.endTime != null)
                {
                    this.endTime = param1.endTime;
                }// end if
                if (param1.level != null)
                {
                    this.level = param1.level;
                }// end if
                if (param1.startTime != null)
                {
                    this.startTime = param1.startTime;
                }// end if
                if (param1.typeId != null)
                {
                    this.typeId = param1.typeId;
                }// end if
                if (param1.permition != null)
                {
                    this.permition = param1.permition;
                }// end if
                if (param1.upgradeing != null)
                {
                    this.upgradeing = param1.upgradeing;
                }// end if
            }// end if
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function get level() : int
        {
            return this._102865796level;
        }// end function

        public function set upgradeing(param1:Boolean) : void
        {
            var _loc_2:* = this._1999144890upgradeing;
            if (_loc_2 !== param1)
            {
                this._1999144890upgradeing = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "upgradeing", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get permition() : Boolean
        {
            return this._676059661permition;
        }// end function

        public function set endTime(param1:Number) : void
        {
            var _loc_2:* = this._1607243192endTime;
            if (_loc_2 !== param1)
            {
                this._1607243192endTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "endTime", _loc_2, param1));
            }// end if
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

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.avalevel = this.avalevel;
            _loc_1.castleId = this.castleId;
            _loc_1.conditionBean = this.conditionBean.toObject();
            _loc_1.endTime = this.endTime;
            _loc_1.level = this.level;
            _loc_1.startTime = this.startTime;
            _loc_1.typeId = this.typeId;
            _loc_1.permition = this.permition;
            _loc_1.upgradeing = this.upgradeing;
            return _loc_1;
        }// end function

        public function set startTime(param1:Number) : void
        {
            var _loc_2:* = this._2129294769startTime;
            if (_loc_2 !== param1)
            {
                this._2129294769startTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set permition(param1:Boolean) : void
        {
            var _loc_2:* = this._676059661permition;
            if (_loc_2 !== param1)
            {
                this._676059661permition = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "permition", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get castleId() : Number
        {
            return this._35872819castleId;
        }// end function

        public function get avalevel() : int
        {
            return this._1780023352avalevel;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get upgradeing() : Boolean
        {
            return this._1999144890upgradeing;
        }// end function

        public function get endTime() : Number
        {
            return this._1607243192endTime;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "avalevel = " + this.avalevel + "\n");
            _loc_2 = _loc_2 + (param1 + "castleId = " + this.castleId + "\n");
            if (conditionBean != null)
            {
                _loc_2 = _loc_2 + this.conditionBean.toDebugString(param1 + "conditionBean.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "conditionBean = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "endTime = " + this.endTime + "\n");
            _loc_2 = _loc_2 + (param1 + "level = " + this.level + "\n");
            _loc_2 = _loc_2 + (param1 + "startTime = " + this.startTime + "\n");
            _loc_2 = _loc_2 + (param1 + "typeId = " + this.typeId + "\n");
            _loc_2 = _loc_2 + (param1 + "permition = " + this.permition + "\n");
            _loc_2 = _loc_2 + (param1 + "upgradeing = " + this.upgradeing + "\n");
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

        public function get startTime() : Number
        {
            return this._2129294769startTime;
        }// end function

        public function copyTo(param1:AvailableResearchListBean) : void
        {
            param1.avalevel = this.avalevel;
            param1.castleId = this.castleId;
            if (conditionBean != null)
            {
                this.conditionBean.copyTo(param1.conditionBean);
            }
            else
            {
                param1.conditionBean = null;
            }// end else if
            param1.endTime = this.endTime;
            param1.level = this.level;
            param1.startTime = this.startTime;
            param1.typeId = this.typeId;
            param1.permition = this.permition;
            param1.upgradeing = this.upgradeing;
            return;
        }// end function

        public function set conditionBean(param1:ConditionBean) : void
        {
            var _loc_2:* = this._1371991915conditionBean;
            if (_loc_2 !== param1)
            {
                this._1371991915conditionBean = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "conditionBean", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set typeId(param1:int) : void
        {
            var _loc_2:* = this._858803723typeId;
            if (_loc_2 !== param1)
            {
                this._858803723typeId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get conditionBean() : ConditionBean
        {
            return this._1371991915conditionBean;
        }// end function

        public function set castleId(param1:Number) : void
        {
            var _loc_2:* = this._35872819castleId;
            if (_loc_2 !== param1)
            {
                this._35872819castleId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set avalevel(param1:int) : void
        {
            var _loc_2:* = this._1780023352avalevel;
            if (_loc_2 !== param1)
            {
                this._1780023352avalevel = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "avalevel", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function get typeId() : int
        {
            return this._858803723typeId;
        }// end function

    }
}
