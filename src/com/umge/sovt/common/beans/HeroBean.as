package com.umge.sovt.common.beans
{
    import com.umge.sovt.common.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.events.*;

    public class HeroBean extends Object implements IEventDispatcher
    {
        private var _85567126experience:int;
        private var _892481550status:int;
        private var _3373707name:String;
        private var _1799980989management:int;
        private var _1691501851stratagemBuffAdded:int;
        private var _761536362managementBuffAdded:int;
        private var _814364440powerBuffAdded:int;
        private var _106858757power:int;
        private var _102865796level:int;
        private var _682371709managementAdded:int;
        private var _3355id:int;
        private var _2032248903buffsArray:ArrayCollection;
        private var _1999179167upgradeExp:int;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _412762875powerAdded:int;
        private var _1627044220remainPoint:int;
        private var _342500292logoUrl:String;
        private var _1456811858stratagemAdded:int;
        private var _1178662002itemId:String;
        private var _1478417739itemAmount:int;
        private var _412944526stratagem:int;
        private var _358728774loyalty:int;

        public function HeroBean(param1:Object = null)
        {
            var _loc_2:int;
            var _loc_3:BuffBean;
            _2032248903buffsArray = new ArrayCollection();
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.experience != null)
                {
                    this.experience = param1.experience;
                }// end if
                if (param1.id != null)
                {
                    this.id = param1.id;
                }// end if
                if (param1.itemAmount != null)
                {
                    this.itemAmount = param1.itemAmount;
                }// end if
                if (param1.itemId != null)
                {
                    this.itemId = param1.itemId;
                }// end if
                if (param1.level != null)
                {
                    this.level = param1.level;
                }// end if
                if (param1.logoUrl != null)
                {
                    this.logoUrl = param1.logoUrl;
                }// end if
                if (param1.loyalty != null)
                {
                    this.loyalty = param1.loyalty;
                }// end if
                if (param1.management != null)
                {
                    this.management = param1.management;
                }// end if
                if (param1.managementAdded != null)
                {
                    this.managementAdded = param1.managementAdded;
                }// end if
                if (param1.managementBuffAdded != null)
                {
                    this.managementBuffAdded = param1.managementBuffAdded;
                }// end if
                if (param1.name != null)
                {
                    this.name = param1.name;
                }// end if
                if (param1.power != null)
                {
                    this.power = param1.power;
                }// end if
                if (param1.powerAdded != null)
                {
                    this.powerAdded = param1.powerAdded;
                }// end if
                if (param1.powerBuffAdded != null)
                {
                    this.powerBuffAdded = param1.powerBuffAdded;
                }// end if
                if (param1.remainPoint != null)
                {
                    this.remainPoint = param1.remainPoint;
                }// end if
                if (param1.status != null)
                {
                    this.status = param1.status;
                }// end if
                if (param1.stratagem != null)
                {
                    this.stratagem = param1.stratagem;
                }// end if
                if (param1.stratagemAdded != null)
                {
                    this.stratagemAdded = param1.stratagemAdded;
                }// end if
                if (param1.stratagemBuffAdded != null)
                {
                    this.stratagemBuffAdded = param1.stratagemBuffAdded;
                }// end if
                if (param1.upgradeExp != null)
                {
                    this.upgradeExp = param1.upgradeExp;
                }// end if
                if (param1.buffs)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.buffs.length)
                    {
                        // label
                        _loc_3 = new BuffBean(param1.buffs[_loc_2]);
                        this.buffsArray.addItem(_loc_3);
                        _loc_2++;
                    }// end while
                }// end if
            }// end if
            return;
        }// end function

        public function set managementBuffAdded(param1:int) : void
        {
            var _loc_2:* = this._761536362managementBuffAdded;
            if (_loc_2 !== param1)
            {
                this._761536362managementBuffAdded = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "managementBuffAdded", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function get level() : int
        {
            return this._102865796level;
        }// end function

        public function set management(param1:int) : void
        {
            var _loc_2:* = this._1799980989management;
            if (_loc_2 !== param1)
            {
                this._1799980989management = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "management", _loc_2, param1));
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

        public function get name() : String
        {
            return this._3373707name;
        }// end function

        public function set loyalty(param1:int) : void
        {
            var _loc_2:* = this._358728774loyalty;
            if (_loc_2 !== param1)
            {
                this._358728774loyalty = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loyalty", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get buffsArray() : ArrayCollection
        {
            return this._2032248903buffsArray;
        }// end function

        public function set logoUrl(param1:String) : void
        {
            var _loc_2:* = this._342500292logoUrl;
            if (_loc_2 !== param1)
            {
                this._342500292logoUrl = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "logoUrl", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get remainPoint() : int
        {
            return this._1627044220remainPoint;
        }// end function

        public function get power() : int
        {
            return this._106858757power;
        }// end function

        public function set itemAmount(param1:int) : void
        {
            var _loc_2:* = this._1478417739itemAmount;
            if (_loc_2 !== param1)
            {
                this._1478417739itemAmount = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemAmount", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set remainPoint(param1:int) : void
        {
            var _loc_2:* = this._1627044220remainPoint;
            if (_loc_2 !== param1)
            {
                this._1627044220remainPoint = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "remainPoint", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set powerAdded(param1:int) : void
        {
            var _loc_2:* = this._412762875powerAdded;
            if (_loc_2 !== param1)
            {
                this._412762875powerAdded = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "powerAdded", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set power(param1:int) : void
        {
            var _loc_2:* = this._106858757power;
            if (_loc_2 !== param1)
            {
                this._106858757power = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "power", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.experience = this.experience;
            _loc_1.id = this.id;
            _loc_1.itemAmount = this.itemAmount;
            _loc_1.itemId = this.itemId;
            _loc_1.level = this.level;
            _loc_1.logoUrl = this.logoUrl;
            _loc_1.loyalty = this.loyalty;
            _loc_1.management = this.management;
            _loc_1.managementAdded = this.managementAdded;
            _loc_1.managementBuffAdded = this.managementBuffAdded;
            _loc_1.name = this.name;
            _loc_1.power = this.power;
            _loc_1.powerAdded = this.powerAdded;
            _loc_1.powerBuffAdded = this.powerBuffAdded;
            _loc_1.remainPoint = this.remainPoint;
            _loc_1.status = this.status;
            _loc_1.stratagem = this.stratagem;
            _loc_1.stratagemAdded = this.stratagemAdded;
            _loc_1.stratagemBuffAdded = this.stratagemBuffAdded;
            _loc_1.upgradeExp = this.upgradeExp;
            return _loc_1;
        }// end function

        public function get id() : int
        {
            return this._3355id;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function get status() : int
        {
            return this._892481550status;
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

        public function get itemId() : String
        {
            return this._1178662002itemId;
        }// end function

        public function get stratagemAdded() : int
        {
            return this._1456811858stratagemAdded;
        }// end function

        public function set itemId(param1:String) : void
        {
            var _loc_2:* = this._1178662002itemId;
            if (_loc_2 !== param1)
            {
                this._1178662002itemId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemId", _loc_2, param1));
            }// end if
            return;
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

        public function setBuffs(param1:BuffBean, param2:int) : void
        {
            this.buffsArray[param2] = param1;
            return;
        }// end function

        public function get management() : int
        {
            return this._1799980989management;
        }// end function

        public function get logoUrl() : String
        {
            return this._342500292logoUrl;
        }// end function

        public function set stratagemBuffAdded(param1:int) : void
        {
            var _loc_2:* = this._1691501851stratagemBuffAdded;
            if (_loc_2 !== param1)
            {
                this._1691501851stratagemBuffAdded = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stratagemBuffAdded", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get stratagemBuffAdded() : int
        {
            return this._1691501851stratagemBuffAdded;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "experience = " + this.experience + "\n");
            _loc_2 = _loc_2 + (param1 + "id = " + this.id + "\n");
            _loc_2 = _loc_2 + (param1 + "itemAmount = " + this.itemAmount + "\n");
            _loc_2 = _loc_2 + (param1 + "itemId = " + this.itemId + "\n");
            _loc_2 = _loc_2 + (param1 + "level = " + this.level + "\n");
            _loc_2 = _loc_2 + (param1 + "logoUrl = " + this.logoUrl + "\n");
            _loc_2 = _loc_2 + (param1 + "loyalty = " + this.loyalty + "\n");
            _loc_2 = _loc_2 + (param1 + "management = " + this.management + "\n");
            _loc_2 = _loc_2 + (param1 + "managementAdded = " + this.managementAdded + "\n");
            _loc_2 = _loc_2 + (param1 + "managementBuffAdded = " + this.managementBuffAdded + "\n");
            _loc_2 = _loc_2 + (param1 + "name = " + this.name + "\n");
            _loc_2 = _loc_2 + (param1 + "power = " + this.power + "\n");
            _loc_2 = _loc_2 + (param1 + "powerAdded = " + this.powerAdded + "\n");
            _loc_2 = _loc_2 + (param1 + "powerBuffAdded = " + this.powerBuffAdded + "\n");
            _loc_2 = _loc_2 + (param1 + "remainPoint = " + this.remainPoint + "\n");
            _loc_2 = _loc_2 + (param1 + "status = " + this.status + "\n");
            _loc_2 = _loc_2 + (param1 + "stratagem = " + this.stratagem + "\n");
            _loc_2 = _loc_2 + (param1 + "stratagemAdded = " + this.stratagemAdded + "\n");
            _loc_2 = _loc_2 + (param1 + "stratagemBuffAdded = " + this.stratagemBuffAdded + "\n");
            _loc_2 = _loc_2 + (param1 + "upgradeExp = " + this.upgradeExp + "\n");
            _loc_3 = 0;
            while (_loc_3 < this.buffsArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getBuffs(_loc_3).toDebugString(param1 + "buffs[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function getBuffs(param1:int) : BuffBean
        {
            var _loc_2:* = this.buffsArray[param1] as BuffBean;
            return _loc_2;
        }// end function

        public function get itemAmount() : int
        {
            return this._1478417739itemAmount;
        }// end function

        public function get loyalty() : int
        {
            return this._358728774loyalty;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function copyTo(param1:HeroBean) : void
        {
            param1.experience = this.experience;
            param1.id = this.id;
            param1.itemAmount = this.itemAmount;
            param1.itemId = this.itemId;
            param1.level = this.level;
            param1.logoUrl = this.logoUrl;
            param1.loyalty = this.loyalty;
            param1.management = this.management;
            param1.managementAdded = this.managementAdded;
            param1.managementBuffAdded = this.managementBuffAdded;
            param1.name = this.name;
            param1.power = this.power;
            param1.powerAdded = this.powerAdded;
            param1.powerBuffAdded = this.powerBuffAdded;
            param1.remainPoint = this.remainPoint;
            param1.status = this.status;
            param1.stratagem = this.stratagem;
            param1.stratagemAdded = this.stratagemAdded;
            param1.stratagemBuffAdded = this.stratagemBuffAdded;
            param1.upgradeExp = this.upgradeExp;
            CommonUtil.arrayCopy(this.buffsArray, param1.buffsArray);
            return;
        }// end function

        public function set upgradeExp(param1:int) : void
        {
            var _loc_2:* = this._1999179167upgradeExp;
            if (_loc_2 !== param1)
            {
                this._1999179167upgradeExp = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "upgradeExp", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set experience(param1:int) : void
        {
            var _loc_2:* = this._85567126experience;
            if (_loc_2 !== param1)
            {
                this._85567126experience = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "experience", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get stratagem() : int
        {
            return this._412944526stratagem;
        }// end function

        public function set powerBuffAdded(param1:int) : void
        {
            var _loc_2:* = this._814364440powerBuffAdded;
            if (_loc_2 !== param1)
            {
                this._814364440powerBuffAdded = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "powerBuffAdded", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function get upgradeExp() : int
        {
            return this._1999179167upgradeExp;
        }// end function

        public function set status(param1:int) : void
        {
            var _loc_2:* = this._892481550status;
            if (_loc_2 !== param1)
            {
                this._892481550status = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "status", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set buffsArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._2032248903buffsArray;
            if (_loc_2 !== param1)
            {
                this._2032248903buffsArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buffsArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get powerBuffAdded() : int
        {
            return this._814364440powerBuffAdded;
        }// end function

        public function get experience() : int
        {
            return this._85567126experience;
        }// end function

        public function set stratagem(param1:int) : void
        {
            var _loc_2:* = this._412944526stratagem;
            if (_loc_2 !== param1)
            {
                this._412944526stratagem = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stratagem", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function get managementBuffAdded() : int
        {
            return this._761536362managementBuffAdded;
        }// end function

        public function set managementAdded(param1:int) : void
        {
            var _loc_2:* = this._682371709managementAdded;
            if (_loc_2 !== param1)
            {
                this._682371709managementAdded = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "managementAdded", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get powerAdded() : int
        {
            return this._412762875powerAdded;
        }// end function

        public function get managementAdded() : int
        {
            return this._682371709managementAdded;
        }// end function

        public function set stratagemAdded(param1:int) : void
        {
            var _loc_2:* = this._1456811858stratagemAdded;
            if (_loc_2 !== param1)
            {
                this._1456811858stratagemAdded = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stratagemAdded", _loc_2, param1));
            }// end if
            return;
        }// end function

    }
}
