package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class AvailableBuildingListBean extends Object implements IEventDispatcher
    {
        private var _1371991915conditionBean:ConditionBean;
        private var _858803723typeId:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function AvailableBuildingListBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.conditionBean != null)
                {
                    this.conditionBean = new ConditionBean(param1.conditionBean);
                }// end if
                if (param1.typeId != null)
                {
                    this.typeId = param1.typeId;
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
            if (conditionBean != null)
            {
                _loc_2 = _loc_2 + this.conditionBean.toDebugString(param1 + "conditionBean.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "conditionBean = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "typeId = " + this.typeId + "\n");
            return _loc_2;
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

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function copyTo(param1:AvailableBuildingListBean) : void
        {
            if (conditionBean != null)
            {
                this.conditionBean.copyTo(param1.conditionBean);
            }
            else
            {
                param1.conditionBean = null;
            }// end else if
            param1.typeId = this.typeId;
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function get typeId() : int
        {
            return this._858803723typeId;
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

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.conditionBean = this.conditionBean.toObject();
            _loc_1.typeId = this.typeId;
            return _loc_1;
        }// end function

    }
}
