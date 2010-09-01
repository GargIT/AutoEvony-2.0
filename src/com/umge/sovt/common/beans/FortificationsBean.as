package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class FortificationsBean extends Object implements IEventDispatcher
    {
        private var _3568429trap:int;
        private var _1739874176arrowTower:int;
        private var _518185888rockfall:int;
        private var _226523540rollingLogs:int;
        private var _1424430018abatis:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function FortificationsBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.abatis != null)
                {
                    this.abatis = param1.abatis;
                }// end if
                if (param1.arrowTower != null)
                {
                    this.arrowTower = param1.arrowTower;
                }// end if
                if (param1.rockfall != null)
                {
                    this.rockfall = param1.rockfall;
                }// end if
                if (param1.rollingLogs != null)
                {
                    this.rollingLogs = param1.rollingLogs;
                }// end if
                if (param1.trap != null)
                {
                    this.trap = param1.trap;
                }// end if
            }// end if
            return;
        }// end function

        public function get arrowTower() : int
        {
            return this._1739874176arrowTower;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "abatis = " + this.abatis + "\n");
            _loc_2 = _loc_2 + (param1 + "arrowTower = " + this.arrowTower + "\n");
            _loc_2 = _loc_2 + (param1 + "rockfall = " + this.rockfall + "\n");
            _loc_2 = _loc_2 + (param1 + "rollingLogs = " + this.rollingLogs + "\n");
            _loc_2 = _loc_2 + (param1 + "trap = " + this.trap + "\n");
            return _loc_2;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function set rockfall(param1:int) : void
        {
            var _loc_2:* = this._518185888rockfall;
            if (_loc_2 !== param1)
            {
                this._518185888rockfall = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rockfall", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function get rollingLogs() : int
        {
            return this._226523540rollingLogs;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function copyTo(param1:FortificationsBean) : void
        {
            param1.abatis = this.abatis;
            param1.arrowTower = this.arrowTower;
            param1.rockfall = this.rockfall;
            param1.rollingLogs = this.rollingLogs;
            param1.trap = this.trap;
            return;
        }// end function

        public function set arrowTower(param1:int) : void
        {
            var _loc_2:* = this._1739874176arrowTower;
            if (_loc_2 !== param1)
            {
                this._1739874176arrowTower = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "arrowTower", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set trap(param1:int) : void
        {
            var _loc_2:* = this._3568429trap;
            if (_loc_2 !== param1)
            {
                this._3568429trap = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "trap", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get rockfall() : int
        {
            return this._518185888rockfall;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.abatis = this.abatis;
            _loc_1.arrowTower = this.arrowTower;
            _loc_1.rockfall = this.rockfall;
            _loc_1.rollingLogs = this.rollingLogs;
            _loc_1.trap = this.trap;
            return _loc_1;
        }// end function

        public function get trap() : int
        {
            return this._3568429trap;
        }// end function

        public function set rollingLogs(param1:int) : void
        {
            var _loc_2:* = this._226523540rollingLogs;
            if (_loc_2 !== param1)
            {
                this._226523540rollingLogs = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rollingLogs", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function set abatis(param1:int) : void
        {
            var _loc_2:* = this._1424430018abatis;
            if (_loc_2 !== param1)
            {
                this._1424430018abatis = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "abatis", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get abatis() : int
        {
            return this._1424430018abatis;
        }// end function

    }
}
