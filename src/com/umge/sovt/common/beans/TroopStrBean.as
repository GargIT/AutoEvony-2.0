package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class TroopStrBean extends Object implements IEventDispatcher
    {
        private var _1671895235heavyCavalry:String;
        private var _47090712catapult:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1409605757archer:String;
        private var _1821715860lightCavalry:String;
        private var _1914804330ballista:String;
        private var _1062697427militia:String;
        private var _5304340carriage:String;
        private var _1924105259scouter:String;
        private var _43947821peasants:String;
        private var _2135247928batteringRam:String;
        private var _1669530624swordsmen:String;
        private var _570808349pikemen:String;

        public function TroopStrBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.archer != null)
                {
                    this.archer = param1.archer;
                }// end if
                if (param1.ballista != null)
                {
                    this.ballista = param1.ballista;
                }// end if
                if (param1.batteringRam != null)
                {
                    this.batteringRam = param1.batteringRam;
                }// end if
                if (param1.carriage != null)
                {
                    this.carriage = param1.carriage;
                }// end if
                if (param1.catapult != null)
                {
                    this.catapult = param1.catapult;
                }// end if
                if (param1.heavyCavalry != null)
                {
                    this.heavyCavalry = param1.heavyCavalry;
                }// end if
                if (param1.lightCavalry != null)
                {
                    this.lightCavalry = param1.lightCavalry;
                }// end if
                if (param1.militia != null)
                {
                    this.militia = param1.militia;
                }// end if
                if (param1.peasants != null)
                {
                    this.peasants = param1.peasants;
                }// end if
                if (param1.pikemen != null)
                {
                    this.pikemen = param1.pikemen;
                }// end if
                if (param1.scouter != null)
                {
                    this.scouter = param1.scouter;
                }// end if
                if (param1.swordsmen != null)
                {
                    this.swordsmen = param1.swordsmen;
                }// end if
            }// end if
            return;
        }// end function

        public function get swordsmen() : String
        {
            return this._1669530624swordsmen;
        }// end function

        public function get archer() : String
        {
            return this._1409605757archer;
        }// end function

        public function set archer(param1:String) : void
        {
            var _loc_2:* = this._1409605757archer;
            if (_loc_2 !== param1)
            {
                this._1409605757archer = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "archer", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set swordsmen(param1:String) : void
        {
            var _loc_2:* = this._1669530624swordsmen;
            if (_loc_2 !== param1)
            {
                this._1669530624swordsmen = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "swordsmen", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set heavyCavalry(param1:String) : void
        {
            var _loc_2:* = this._1671895235heavyCavalry;
            if (_loc_2 !== param1)
            {
                this._1671895235heavyCavalry = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heavyCavalry", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set batteringRam(param1:String) : void
        {
            var _loc_2:* = this._2135247928batteringRam;
            if (_loc_2 !== param1)
            {
                this._2135247928batteringRam = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "batteringRam", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get carriage() : String
        {
            return this._5304340carriage;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function get ballista() : String
        {
            return this._1914804330ballista;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.archer = this.archer;
            _loc_1.ballista = this.ballista;
            _loc_1.batteringRam = this.batteringRam;
            _loc_1.carriage = this.carriage;
            _loc_1.catapult = this.catapult;
            _loc_1.heavyCavalry = this.heavyCavalry;
            _loc_1.lightCavalry = this.lightCavalry;
            _loc_1.militia = this.militia;
            _loc_1.peasants = this.peasants;
            _loc_1.pikemen = this.pikemen;
            _loc_1.scouter = this.scouter;
            _loc_1.swordsmen = this.swordsmen;
            return _loc_1;
        }// end function

        public function get lightCavalry() : String
        {
            return this._1821715860lightCavalry;
        }// end function

        public function get catapult() : String
        {
            return this._47090712catapult;
        }// end function

        public function set militia(param1:String) : void
        {
            var _loc_2:* = this._1062697427militia;
            if (_loc_2 !== param1)
            {
                this._1062697427militia = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "militia", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set lightCavalry(param1:String) : void
        {
            var _loc_2:* = this._1821715860lightCavalry;
            if (_loc_2 !== param1)
            {
                this._1821715860lightCavalry = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lightCavalry", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set ballista(param1:String) : void
        {
            var _loc_2:* = this._1914804330ballista;
            if (_loc_2 !== param1)
            {
                this._1914804330ballista = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ballista", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set peasants(param1:String) : void
        {
            var _loc_2:* = this._43947821peasants;
            if (_loc_2 !== param1)
            {
                this._43947821peasants = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "peasants", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set catapult(param1:String) : void
        {
            var _loc_2:* = this._47090712catapult;
            if (_loc_2 !== param1)
            {
                this._47090712catapult = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "catapult", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get scouter() : String
        {
            return this._1924105259scouter;
        }// end function

        public function set carriage(param1:String) : void
        {
            var _loc_2:* = this._5304340carriage;
            if (_loc_2 !== param1)
            {
                this._5304340carriage = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "carriage", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get heavyCavalry() : String
        {
            return this._1671895235heavyCavalry;
        }// end function

        public function set pikemen(param1:String) : void
        {
            var _loc_2:* = this._570808349pikemen;
            if (_loc_2 !== param1)
            {
                this._570808349pikemen = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pikemen", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get batteringRam() : String
        {
            return this._2135247928batteringRam;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "archer = " + this.archer + "\n");
            _loc_2 = _loc_2 + (param1 + "ballista = " + this.ballista + "\n");
            _loc_2 = _loc_2 + (param1 + "batteringRam = " + this.batteringRam + "\n");
            _loc_2 = _loc_2 + (param1 + "carriage = " + this.carriage + "\n");
            _loc_2 = _loc_2 + (param1 + "catapult = " + this.catapult + "\n");
            _loc_2 = _loc_2 + (param1 + "heavyCavalry = " + this.heavyCavalry + "\n");
            _loc_2 = _loc_2 + (param1 + "lightCavalry = " + this.lightCavalry + "\n");
            _loc_2 = _loc_2 + (param1 + "militia = " + this.militia + "\n");
            _loc_2 = _loc_2 + (param1 + "peasants = " + this.peasants + "\n");
            _loc_2 = _loc_2 + (param1 + "pikemen = " + this.pikemen + "\n");
            _loc_2 = _loc_2 + (param1 + "scouter = " + this.scouter + "\n");
            _loc_2 = _loc_2 + (param1 + "swordsmen = " + this.swordsmen + "\n");
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

        public function get militia() : String
        {
            return this._1062697427militia;
        }// end function

        public function copyTo(param1:TroopStrBean) : void
        {
            param1.archer = this.archer;
            param1.ballista = this.ballista;
            param1.batteringRam = this.batteringRam;
            param1.carriage = this.carriage;
            param1.catapult = this.catapult;
            param1.heavyCavalry = this.heavyCavalry;
            param1.lightCavalry = this.lightCavalry;
            param1.militia = this.militia;
            param1.peasants = this.peasants;
            param1.pikemen = this.pikemen;
            param1.scouter = this.scouter;
            param1.swordsmen = this.swordsmen;
            return;
        }// end function

        public function get peasants() : String
        {
            return this._43947821peasants;
        }// end function

        public function set scouter(param1:String) : void
        {
            var _loc_2:* = this._1924105259scouter;
            if (_loc_2 !== param1)
            {
                this._1924105259scouter = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scouter", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get pikemen() : String
        {
            return this._570808349pikemen;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

    }
}
