package com.umge.sovt.common.paramBeans
{
    import com.umge.sovt.common.beans.*;
    import flash.events.*;
    import mx.events.*;

    public class NewArmyParam extends Object implements IEventDispatcher
    {
        private var _865287327troops:TroopBean;
        private var _1383259878missionType:int;
        private var _1220754763heroId:int;
        private var _341064690resource:ResourceBean;
        private var _148431469useFlag:Boolean;
        private var _1570047522backAfterConstruct:Boolean;
        private var _337438527restTime:int;
        private var _2098575745targetPoint:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function NewArmyParam(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.heroId != null)
                {
                    this.heroId = param1.heroId;
                }// end if
                if (param1.missionType != null)
                {
                    this.missionType = param1.missionType;
                }// end if
                if (param1.resource != null)
                {
                    this.resource = new ResourceBean(param1.resource);
                }// end if
                if (param1.restTime != null)
                {
                    this.restTime = param1.restTime;
                }// end if
                if (param1.targetPoint != null)
                {
                    this.targetPoint = param1.targetPoint;
                }// end if
                if (param1.troops != null)
                {
                    this.troops = new TroopBean(param1.troops);
                }// end if
                if (param1.backAfterConstruct != null)
                {
                    this.backAfterConstruct = param1.backAfterConstruct;
                }// end if
                if (param1.useFlag != null)
                {
                    this.useFlag = param1.useFlag;
                }// end if
            }// end if
            return;
        }// end function

        public function get restTime() : int
        {
            return this._337438527restTime;
        }// end function

        public function set restTime(param1:int) : void
        {
            var _loc_2:* = this._337438527restTime;
            if (_loc_2 !== param1)
            {
                this._337438527restTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "restTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set backAfterConstruct(param1:Boolean) : void
        {
            var _loc_2:* = this._1570047522backAfterConstruct;
            if (_loc_2 !== param1)
            {
                this._1570047522backAfterConstruct = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "backAfterConstruct", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "heroId = " + this.heroId + "\n");
            _loc_2 = _loc_2 + (param1 + "missionType = " + this.missionType + "\n");
            if (resource != null)
            {
                _loc_2 = _loc_2 + this.resource.toDebugString(param1 + "resource.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "resource = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "restTime = " + this.restTime + "\n");
            _loc_2 = _loc_2 + (param1 + "targetPoint = " + this.targetPoint + "\n");
            if (troops != null)
            {
                _loc_2 = _loc_2 + this.troops.toDebugString(param1 + "troops.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "troops = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "backAfterConstruct = " + this.backAfterConstruct + "\n");
            _loc_2 = _loc_2 + (param1 + "useFlag = " + this.useFlag + "\n");
            return _loc_2;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function set missionType(param1:int) : void
        {
            var _loc_2:* = this._1383259878missionType;
            if (_loc_2 !== param1)
            {
                this._1383259878missionType = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "missionType", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function copyTo(param1:NewArmyParam) : void
        {
            param1.heroId = this.heroId;
            param1.missionType = this.missionType;
            if (resource != null)
            {
                this.resource.copyTo(param1.resource);
            }
            else
            {
                param1.resource = null;
            }// end else if
            param1.restTime = this.restTime;
            param1.targetPoint = this.targetPoint;
            if (troops != null)
            {
                this.troops.copyTo(param1.troops);
            }
            else
            {
                param1.troops = null;
            }// end else if
            param1.backAfterConstruct = this.backAfterConstruct;
            param1.useFlag = this.useFlag;
            return;
        }// end function

        public function get useFlag() : Boolean
        {
            return this._148431469useFlag;
        }// end function

        public function get resource() : ResourceBean
        {
            return this._341064690resource;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.heroId = this.heroId;
            _loc_1.missionType = this.missionType;
            _loc_1.resource = this.resource.toObject();
            _loc_1.restTime = this.restTime;
            _loc_1.targetPoint = this.targetPoint;
            _loc_1.troops = this.troops.toObject();
            _loc_1.backAfterConstruct = this.backAfterConstruct;
            _loc_1.useFlag = this.useFlag;
            return _loc_1;
        }// end function

        public function set resource(param1:ResourceBean) : void
        {
            var _loc_2:* = this._341064690resource;
            if (_loc_2 !== param1)
            {
                this._341064690resource = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resource", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set troops(param1:TroopBean) : void
        {
            var _loc_2:* = this._865287327troops;
            if (_loc_2 !== param1)
            {
                this._865287327troops = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troops", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get missionType() : int
        {
            return this._1383259878missionType;
        }// end function

        public function get troops() : TroopBean
        {
            return this._865287327troops;
        }// end function

        public function get backAfterConstruct() : Boolean
        {
            return this._1570047522backAfterConstruct;
        }// end function

        public function set heroId(param1:int) : void
        {
            var _loc_2:* = this._1220754763heroId;
            if (_loc_2 !== param1)
            {
                this._1220754763heroId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set useFlag(param1:Boolean) : void
        {
            var _loc_2:* = this._148431469useFlag;
            if (_loc_2 !== param1)
            {
                this._148431469useFlag = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "useFlag", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function get heroId() : int
        {
            return this._1220754763heroId;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function set targetPoint(param1:int) : void
        {
            var _loc_2:* = this._2098575745targetPoint;
            if (_loc_2 !== param1)
            {
                this._2098575745targetPoint = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetPoint", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get targetPoint() : int
        {
            return this._2098575745targetPoint;
        }// end function

    }
}
