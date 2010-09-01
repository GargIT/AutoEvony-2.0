package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class ResourceProduceDataBean extends Object implements IEventDispatcher
    {
        private var _1308753897armyPercentage:int;
        private var _313448791commenceRate:int;
        private var _2043715731productionCapacity:int;
        private var _858802731typeid:int;
        private var _849060507totalOutput:int;
        private var _2028158848cimeliaPercentage:int;
        private var _859635508fieldPercentage:int;
        private var _1261923249commenceDemands:int;
        private var _401632820heroPercentage:int;
        private var _795443933maxLabour:int;
        private var _1141868451naturalPercentage:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _940015921basicOutput:int;
        private var _488102284technologicalPercentage:int;

        public function ResourceProduceDataBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.armyPercentage != null)
                {
                    this.armyPercentage = param1.armyPercentage;
                }// end if
                if (param1.basicOutput != null)
                {
                    this.basicOutput = param1.basicOutput;
                }// end if
                if (param1.cimeliaPercentage != null)
                {
                    this.cimeliaPercentage = param1.cimeliaPercentage;
                }// end if
                if (param1.commenceDemands != null)
                {
                    this.commenceDemands = param1.commenceDemands;
                }// end if
                if (param1.commenceRate != null)
                {
                    this.commenceRate = param1.commenceRate;
                }// end if
                if (param1.fieldPercentage != null)
                {
                    this.fieldPercentage = param1.fieldPercentage;
                }// end if
                if (param1.heroPercentage != null)
                {
                    this.heroPercentage = param1.heroPercentage;
                }// end if
                if (param1.maxLabour != null)
                {
                    this.maxLabour = param1.maxLabour;
                }// end if
                if (param1.naturalPercentage != null)
                {
                    this.naturalPercentage = param1.naturalPercentage;
                }// end if
                if (param1.productionCapacity != null)
                {
                    this.productionCapacity = param1.productionCapacity;
                }// end if
                if (param1.technologicalPercentage != null)
                {
                    this.technologicalPercentage = param1.technologicalPercentage;
                }// end if
                if (param1.totalOutput != null)
                {
                    this.totalOutput = param1.totalOutput;
                }// end if
                if (param1.typeid != null)
                {
                    this.typeid = param1.typeid;
                }// end if
            }// end if
            return;
        }// end function

        public function get cimeliaPercentage() : int
        {
            return this._2028158848cimeliaPercentage;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function set cimeliaPercentage(param1:int) : void
        {
            var _loc_2:* = this._2028158848cimeliaPercentage;
            if (_loc_2 !== param1)
            {
                this._2028158848cimeliaPercentage = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cimeliaPercentage", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get technologicalPercentage() : int
        {
            return this._488102284technologicalPercentage;
        }// end function

        public function get armyPercentage() : int
        {
            return this._1308753897armyPercentage;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.armyPercentage = this.armyPercentage;
            _loc_1.basicOutput = this.basicOutput;
            _loc_1.cimeliaPercentage = this.cimeliaPercentage;
            _loc_1.commenceDemands = this.commenceDemands;
            _loc_1.commenceRate = this.commenceRate;
            _loc_1.fieldPercentage = this.fieldPercentage;
            _loc_1.heroPercentage = this.heroPercentage;
            _loc_1.maxLabour = this.maxLabour;
            _loc_1.naturalPercentage = this.naturalPercentage;
            _loc_1.productionCapacity = this.productionCapacity;
            _loc_1.technologicalPercentage = this.technologicalPercentage;
            _loc_1.totalOutput = this.totalOutput;
            _loc_1.typeid = this.typeid;
            return _loc_1;
        }// end function

        public function set basicOutput(param1:int) : void
        {
            var _loc_2:* = this._940015921basicOutput;
            if (_loc_2 !== param1)
            {
                this._940015921basicOutput = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "basicOutput", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set technologicalPercentage(param1:int) : void
        {
            var _loc_2:* = this._488102284technologicalPercentage;
            if (_loc_2 !== param1)
            {
                this._488102284technologicalPercentage = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "technologicalPercentage", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get naturalPercentage() : int
        {
            return this._1141868451naturalPercentage;
        }// end function

        public function set productionCapacity(param1:int) : void
        {
            var _loc_2:* = this._2043715731productionCapacity;
            if (_loc_2 !== param1)
            {
                this._2043715731productionCapacity = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "productionCapacity", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get maxLabour() : int
        {
            return this._795443933maxLabour;
        }// end function

        public function get productionCapacity() : int
        {
            return this._2043715731productionCapacity;
        }// end function

        public function set armyPercentage(param1:int) : void
        {
            var _loc_2:* = this._1308753897armyPercentage;
            if (_loc_2 !== param1)
            {
                this._1308753897armyPercentage = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyPercentage", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get commenceDemands() : int
        {
            return this._1261923249commenceDemands;
        }// end function

        public function get fieldPercentage() : int
        {
            return this._859635508fieldPercentage;
        }// end function

        public function set commenceRate(param1:int) : void
        {
            var _loc_2:* = this._313448791commenceRate;
            if (_loc_2 !== param1)
            {
                this._313448791commenceRate = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "commenceRate", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get heroPercentage() : int
        {
            return this._401632820heroPercentage;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function set maxLabour(param1:int) : void
        {
            var _loc_2:* = this._795443933maxLabour;
            if (_loc_2 !== param1)
            {
                this._795443933maxLabour = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxLabour", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set totalOutput(param1:int) : void
        {
            var _loc_2:* = this._849060507totalOutput;
            if (_loc_2 !== param1)
            {
                this._849060507totalOutput = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalOutput", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set naturalPercentage(param1:int) : void
        {
            var _loc_2:* = this._1141868451naturalPercentage;
            if (_loc_2 !== param1)
            {
                this._1141868451naturalPercentage = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "naturalPercentage", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get basicOutput() : int
        {
            return this._940015921basicOutput;
        }// end function

        public function copyTo(param1:ResourceProduceDataBean) : void
        {
            param1.armyPercentage = this.armyPercentage;
            param1.basicOutput = this.basicOutput;
            param1.cimeliaPercentage = this.cimeliaPercentage;
            param1.commenceDemands = this.commenceDemands;
            param1.commenceRate = this.commenceRate;
            param1.fieldPercentage = this.fieldPercentage;
            param1.heroPercentage = this.heroPercentage;
            param1.maxLabour = this.maxLabour;
            param1.naturalPercentage = this.naturalPercentage;
            param1.productionCapacity = this.productionCapacity;
            param1.technologicalPercentage = this.technologicalPercentage;
            param1.totalOutput = this.totalOutput;
            param1.typeid = this.typeid;
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function get typeid() : int
        {
            return this._858802731typeid;
        }// end function

        public function get commenceRate() : int
        {
            return this._313448791commenceRate;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "armyPercentage = " + this.armyPercentage + "\n");
            _loc_2 = _loc_2 + (param1 + "basicOutput = " + this.basicOutput + "\n");
            _loc_2 = _loc_2 + (param1 + "cimeliaPercentage = " + this.cimeliaPercentage + "\n");
            _loc_2 = _loc_2 + (param1 + "commenceDemands = " + this.commenceDemands + "\n");
            _loc_2 = _loc_2 + (param1 + "commenceRate = " + this.commenceRate + "\n");
            _loc_2 = _loc_2 + (param1 + "fieldPercentage = " + this.fieldPercentage + "\n");
            _loc_2 = _loc_2 + (param1 + "heroPercentage = " + this.heroPercentage + "\n");
            _loc_2 = _loc_2 + (param1 + "maxLabour = " + this.maxLabour + "\n");
            _loc_2 = _loc_2 + (param1 + "naturalPercentage = " + this.naturalPercentage + "\n");
            _loc_2 = _loc_2 + (param1 + "productionCapacity = " + this.productionCapacity + "\n");
            _loc_2 = _loc_2 + (param1 + "technologicalPercentage = " + this.technologicalPercentage + "\n");
            _loc_2 = _loc_2 + (param1 + "totalOutput = " + this.totalOutput + "\n");
            _loc_2 = _loc_2 + (param1 + "typeid = " + this.typeid + "\n");
            return _loc_2;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function set commenceDemands(param1:int) : void
        {
            var _loc_2:* = this._1261923249commenceDemands;
            if (_loc_2 !== param1)
            {
                this._1261923249commenceDemands = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "commenceDemands", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set typeid(param1:int) : void
        {
            var _loc_2:* = this._858802731typeid;
            if (_loc_2 !== param1)
            {
                this._858802731typeid = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeid", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get totalOutput() : int
        {
            return this._849060507totalOutput;
        }// end function

        public function set fieldPercentage(param1:int) : void
        {
            var _loc_2:* = this._859635508fieldPercentage;
            if (_loc_2 !== param1)
            {
                this._859635508fieldPercentage = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldPercentage", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set heroPercentage(param1:int) : void
        {
            var _loc_2:* = this._401632820heroPercentage;
            if (_loc_2 !== param1)
            {
                this._401632820heroPercentage = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroPercentage", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

    }
}
