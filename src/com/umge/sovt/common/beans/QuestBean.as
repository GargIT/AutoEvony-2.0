package com.umge.sovt.common.beans
{
    import com.umge.sovt.common.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.events.*;

    public class QuestBean extends Object implements IEventDispatcher
    {
        private var _1081415738manual:String;
        private var _600408483isFinish:Boolean;
        private var _3373707name:String;
        private var _1724546052description:String;
        private var _655126941questId:int;
        private var _1180608678isCard:Boolean;
        private var _328471159targetsArray:ArrayCollection;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _93223517award:String;

        public function QuestBean(param1:Object = null)
        {
            var _loc_2:int;
            var _loc_3:QuestTargetBean;
            _328471159targetsArray = new ArrayCollection();
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.award != null)
                {
                    this.award = param1.award;
                }// end if
                if (param1.description != null)
                {
                    this.description = param1.description;
                }// end if
                if (param1.manual != null)
                {
                    this.manual = param1.manual;
                }// end if
                if (param1.name != null)
                {
                    this.name = param1.name;
                }// end if
                if (param1.questId != null)
                {
                    this.questId = param1.questId;
                }// end if
                if (param1.isCard != null)
                {
                    this.isCard = param1.isCard;
                }// end if
                if (param1.isFinish != null)
                {
                    this.isFinish = param1.isFinish;
                }// end if
                if (param1.targets)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.targets.length)
                    {
                        // label
                        _loc_3 = new QuestTargetBean(param1.targets[_loc_2]);
                        this.targetsArray.addItem(_loc_3);
                        _loc_2++;
                    }// end while
                }// end if
            }// end if
            return;
        }// end function

        public function setTargets(param1:QuestTargetBean, param2:int) : void
        {
            this.targetsArray[param2] = param1;
            return;
        }// end function

        public function get description() : String
        {
            return this._1724546052description;
        }// end function

        public function get manual() : String
        {
            return this._1081415738manual;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "award = " + this.award + "\n");
            _loc_2 = _loc_2 + (param1 + "description = " + this.description + "\n");
            _loc_2 = _loc_2 + (param1 + "manual = " + this.manual + "\n");
            _loc_2 = _loc_2 + (param1 + "name = " + this.name + "\n");
            _loc_2 = _loc_2 + (param1 + "questId = " + this.questId + "\n");
            _loc_2 = _loc_2 + (param1 + "isCard = " + this.isCard + "\n");
            _loc_2 = _loc_2 + (param1 + "isFinish = " + this.isFinish + "\n");
            _loc_3 = 0;
            while (_loc_3 < this.targetsArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getTargets(_loc_3).toDebugString(param1 + "targets[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function get name() : String
        {
            return this._3373707name;
        }// end function

        public function getTargets(param1:int) : QuestTargetBean
        {
            var _loc_2:* = this.targetsArray[param1] as QuestTargetBean;
            return _loc_2;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function copyTo(param1:QuestBean) : void
        {
            param1.award = this.award;
            param1.description = this.description;
            param1.manual = this.manual;
            param1.name = this.name;
            param1.questId = this.questId;
            param1.isCard = this.isCard;
            param1.isFinish = this.isFinish;
            CommonUtil.arrayCopy(this.targetsArray, param1.targetsArray);
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function set questId(param1:int) : void
        {
            var _loc_2:* = this._655126941questId;
            if (_loc_2 !== param1)
            {
                this._655126941questId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set manual(param1:String) : void
        {
            var _loc_2:* = this._1081415738manual;
            if (_loc_2 !== param1)
            {
                this._1081415738manual = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "manual", _loc_2, param1));
            }// end if
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
            _loc_1.award = this.award;
            _loc_1.description = this.description;
            _loc_1.manual = this.manual;
            _loc_1.name = this.name;
            _loc_1.questId = this.questId;
            _loc_1.isCard = this.isCard;
            _loc_1.isFinish = this.isFinish;
            return _loc_1;
        }// end function

        public function get award() : String
        {
            return this._93223517award;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function get isCard() : Boolean
        {
            return this._1180608678isCard;
        }// end function

        public function get questId() : int
        {
            return this._655126941questId;
        }// end function

        public function set isFinish(param1:Boolean) : void
        {
            var _loc_2:* = this._600408483isFinish;
            if (_loc_2 !== param1)
            {
                this._600408483isFinish = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isFinish", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get isFinish() : Boolean
        {
            return this._600408483isFinish;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function set targetsArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._328471159targetsArray;
            if (_loc_2 !== param1)
            {
                this._328471159targetsArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetsArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set description(param1:String) : void
        {
            var _loc_2:* = this._1724546052description;
            if (_loc_2 !== param1)
            {
                this._1724546052description = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "description", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set isCard(param1:Boolean) : void
        {
            var _loc_2:* = this._1180608678isCard;
            if (_loc_2 !== param1)
            {
                this._1180608678isCard = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCard", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get targetsArray() : ArrayCollection
        {
            return this._328471159targetsArray;
        }// end function

        public function set award(param1:String) : void
        {
            var _loc_2:* = this._93223517award;
            if (_loc_2 !== param1)
            {
                this._93223517award = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "award", _loc_2, param1));
            }// end if
            return;
        }// end function

    }
}
