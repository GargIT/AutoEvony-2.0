package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class ArmyBean extends Object implements IEventDispatcher
    {
        private var _1409292392armyId:int;
        private var _1383259878missionType:int;
        private var _3292055king:String;
        private var _341064690resource:ResourceBean;
        private var _995699469startFieldId:int;
        private var _1911605294targetPosName:String;
        private var _962590849direction:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _2129294769startTime:Number;
        private var _526788547startPosName:String;
        private var _2014132310heroLevel:int;
        private var _1134711072reachTime:Number;
        private var _3198970hero:String;
        private var _1442694372targetFieldId:int;
        private var _1806944311alliance:String;
        private var _110634834troop:TroopStrBean;

        public function ArmyBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.alliance != null)                
                {
                    this.alliance = param1.alliance;
                }// end if
                if (param1.armyId != null)
                {
                    this.armyId = param1.armyId;
                }// end if
                if (param1.direction != null)
                {
                    this.direction = param1.direction;
                }// end if
                if (param1.hero != null)
                {
                    this.hero = param1.hero;
                }// end if
                if (param1.heroLevel != null)
                {
                    this.heroLevel = param1.heroLevel;
                }// end if
                if (param1.king != null)
                {
                    this.king = param1.king;
                }// end if
                if (param1.missionType != null)
                {
                    this.missionType = param1.missionType;
                }// end if
                if (param1.reachTime != null)
                {
                    this.reachTime = param1.reachTime;
                }// end if
                if (param1.resource != null)
                {
                    this.resource = new ResourceBean(param1.resource);
                }// end if
                if (param1.startFieldId != null)
                {
                    this.startFieldId = param1.startFieldId;
                }// end if
                if (param1.startPosName != null)
                {
                    this.startPosName = param1.startPosName;
                }// end if
                if (param1.startTime != null)
                {
                    this.startTime = param1.startTime;
                }// end if
                if (param1.targetFieldId != null)
                {
                    this.targetFieldId = param1.targetFieldId;
                }// end if
                if (param1.targetPosName != null)
                {
                    this.targetPosName = param1.targetPosName;
                }// end if
                if (param1.troop != null)
                {
                    this.troop = new TroopStrBean(param1.troop);
                }// end if
            }// end if
            return;
        }// end function

        public function get hero() : String
        {
            return this._3198970hero;
        }// end function

        public function get direction() : int
        {
            return this._962590849direction;
        }// end function

        public function set startPosName(param1:String) : void
        {
            var _loc_2:* = this._526788547startPosName;
            if (_loc_2 !== param1)
            {
                this._526788547startPosName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startPosName", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function get resource() : ResourceBean
        {
            return this._341064690resource;
        }// end function

        public function get king() : String
        {
            return this._3292055king;
        }// end function

        public function get armyId() : int
        {
            return this._1409292392armyId;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.alliance = this.alliance;
            _loc_1.armyId = this.armyId;
            _loc_1.direction = this.direction;
            _loc_1.hero = this.hero;
            _loc_1.heroLevel = this.heroLevel;
            _loc_1.king = this.king;
            _loc_1.missionType = this.missionType;
            _loc_1.reachTime = this.reachTime;
            _loc_1.resource = this.resource.toObject();
            _loc_1.startFieldId = this.startFieldId;
            _loc_1.startPosName = this.startPosName;
            _loc_1.startTime = this.startTime;
            _loc_1.targetFieldId = this.targetFieldId;
            _loc_1.targetPosName = this.targetPosName;
            _loc_1.troop = this.troop.toObject();
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

        public function set troop(param1:TroopStrBean) : void
        {
            var _loc_2:* = this._110634834troop;
            if (_loc_2 !== param1)
            {
                this._110634834troop = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troop", _loc_2, param1));
            }// end if
            return;
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

        public function set king(param1:String) : void
        {
            var _loc_2:* = this._3292055king;
            if (_loc_2 !== param1)
            {
                this._3292055king = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "king", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set armyId(param1:int) : void
        {
            var _loc_2:* = this._1409292392armyId;
            if (_loc_2 !== param1)
            {
                this._1409292392armyId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get heroLevel() : int
        {
            return this._2014132310heroLevel;
        }// end function

        public function get alliance() : String
        {
            return this._1806944311alliance;
        }// end function

        public function get startPosName() : String
        {
            return this._526788547startPosName;
        }// end function

        public function set reachTime(param1:Number) : void
        {
            var _loc_2:* = this._1134711072reachTime;
            if (_loc_2 !== param1)
            {
                this._1134711072reachTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reachTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get targetPosName() : String
        {
            return this._1911605294targetPosName;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function set targetFieldId(param1:int) : void
        {
            var _loc_2:* = this._1442694372targetFieldId;
            if (_loc_2 !== param1)
            {
                this._1442694372targetFieldId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetFieldId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "alliance = " + this.alliance + "\n");
            _loc_2 = _loc_2 + (param1 + "armyId = " + this.armyId + "\n");
            _loc_2 = _loc_2 + (param1 + "direction = " + this.direction + "\n");
            _loc_2 = _loc_2 + (param1 + "hero = " + this.hero + "\n");
            _loc_2 = _loc_2 + (param1 + "heroLevel = " + this.heroLevel + "\n");
            _loc_2 = _loc_2 + (param1 + "king = " + this.king + "\n");
            _loc_2 = _loc_2 + (param1 + "missionType = " + this.missionType + "\n");
            _loc_2 = _loc_2 + (param1 + "reachTime = " + this.reachTime + "\n");
            if (resource != null)
            {
                _loc_2 = _loc_2 + this.resource.toDebugString(param1 + "resource.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "resource = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "startFieldId = " + this.startFieldId + "\n");
            _loc_2 = _loc_2 + (param1 + "startPosName = " + this.startPosName + "\n");
            _loc_2 = _loc_2 + (param1 + "startTime = " + this.startTime + "\n");
            _loc_2 = _loc_2 + (param1 + "targetFieldId = " + this.targetFieldId + "\n");
            _loc_2 = _loc_2 + (param1 + "targetPosName = " + this.targetPosName + "\n");
            if (troop != null)
            {
                _loc_2 = _loc_2 + this.troop.toDebugString(param1 + "troop.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "troop = null\n");
            }// end else if
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

        public function get startTime() : Number
        {
            return this._2129294769startTime;
        }// end function

        public function get troop() : TroopStrBean
        {
            return this._110634834troop;
        }// end function

        public function copyTo(param1:ArmyBean) : void
        {
            param1.alliance = this.alliance;
            param1.armyId = this.armyId;
            param1.direction = this.direction;
            param1.hero = this.hero;
            param1.heroLevel = this.heroLevel;
            param1.king = this.king;
            param1.missionType = this.missionType;
            param1.reachTime = this.reachTime;
            if (resource != null)
            {
                this.resource.copyTo(param1.resource);
            }
            else
            {
                param1.resource = null;
            }// end else if
            param1.startFieldId = this.startFieldId;
            param1.startPosName = this.startPosName;
            param1.startTime = this.startTime;
            param1.targetFieldId = this.targetFieldId;
            param1.targetPosName = this.targetPosName;
            if (troop != null)
            {
                this.troop.copyTo(param1.troop);
            }
            else
            {
                param1.troop = null;
            }// end else if
            return;
        }// end function

        public function set heroLevel(param1:int) : void
        {
            var _loc_2:* = this._2014132310heroLevel;
            if (_loc_2 !== param1)
            {
                this._2014132310heroLevel = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroLevel", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set targetPosName(param1:String) : void
        {
            var _loc_2:* = this._1911605294targetPosName;
            if (_loc_2 !== param1)
            {
                this._1911605294targetPosName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetPosName", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get targetFieldId() : int
        {
            return this._1442694372targetFieldId;
        }// end function

        public function get missionType() : int
        {
            return this._1383259878missionType;
        }// end function

        public function set startFieldId(param1:int) : void
        {
            var _loc_2:* = this._995699469startFieldId;
            if (_loc_2 !== param1)
            {
                this._995699469startFieldId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startFieldId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set alliance(param1:String) : void
        {
            var _loc_2:* = this._1806944311alliance;
            if (_loc_2 !== param1)
            {
                this._1806944311alliance = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alliance", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get reachTime() : Number
        {
            return this._1134711072reachTime;
        }// end function

        public function get startFieldId() : int
        {
            return this._995699469startFieldId;
        }// end function

        public function set hero(param1:String) : void
        {
            var _loc_2:* = this._3198970hero;
            if (_loc_2 !== param1)
            {
                this._3198970hero = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hero", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function set direction(param1:int) : void
        {
            var _loc_2:* = this._962590849direction;
            if (_loc_2 !== param1)
            {
                this._962590849direction = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "direction", _loc_2, param1));
            }// end if
            return;
        }// end function

    }
}
