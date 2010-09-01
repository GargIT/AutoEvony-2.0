package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.army.*;
    import com.umge.sovt.common.paramBeans.*;

    public class ArmyCommands extends Object
    {
        public var _callBackArmy_callback:Function;
        private var sender:Sender;
        public var _getInjuredTroop_callback:Function;
        public var _newArmy_callback:Function;
        public var _getTroopParam_callback:Function;
        public var _setArmyGoOut_callback:Function;
        public var _disbandInjuredTroop_callback:Function;
        public var _exerciseArmy_callback:Function;
        public var _getStayAllianceArmys_callback:Function;
        public var _setAllowAllianceArmy_callback:Function;
        public var _cureInjuredTroop_callback:Function;

        public function ArmyCommands()
        {
            return;
        }// end function

        public function getTroopParam(param1:int, param2:Function = null) : TroopParamResponse
        {
            this._getTroopParam_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("army.getTroopParam", _loc_3);
            }// end if
            return null;
        }// end function

        public function exerciseArmy(param1:int, param2:TroopBean, param3:TroopBean, param4:Function = null) : ArmyPracticeResponse
        {
            this._exerciseArmy_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.troopParamAttack = param2.toObject();
            _loc_5.troopParamDefend = param3.toObject();
            if (this.sender != null)
            {
                sender.sendMessage("army.exerciseArmy", _loc_5);
            }// end if
            return null;
        }// end function

        public function disbandInjuredTroop(param1:int, param2:Function = null) : CommandResponse
        {
            this._disbandInjuredTroop_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("army.disbandInjuredTroop", _loc_3);
            }// end if
            return null;
        }// end function

        public function newArmy(param1:int, param2:NewArmyParam, param3:Function = null) : CommandResponse
        {
            this._newArmy_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.newArmyBean = param2.toObject();
            if (this.sender != null)
            {
                sender.sendMessage("army.newArmy", _loc_4);
            }// end if
            return null;
        }// end function

        public function callBackArmy(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._callBackArmy_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.armyId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("army.callBackArmy", _loc_4);
            }// end if
            return null;
        }// end function

        public function getInjuredTroop(param1:int, param2:Function = null) : CommandResponse
        {
            this._getInjuredTroop_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("army.getInjuredTroop", _loc_3);
            }// end if
            return null;
        }// end function

        public function setArmyGoOut(param1:int, param2:Boolean, param3:Function = null) : CommandResponse
        {
            this._setArmyGoOut_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.isArmyGoOut = param2;
            if (this.sender != null)
            {
                sender.sendMessage("army.setArmyGoOut", _loc_4);
            }// end if
            return null;
        }// end function

        public function setAllowAllianceArmy(param1:int, param2:Boolean, param3:Function = null) : CommandResponse
        {
            this._setAllowAllianceArmy_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.isAllow = param2;
            if (this.sender != null)
            {
                sender.sendMessage("army.setAllowAllianceArmy", _loc_4);
            }// end if
            return null;
        }// end function

        public function cureInjuredTroop(param1:int, param2:Function = null) : CommandResponse
        {
            this._cureInjuredTroop_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("army.cureInjuredTroop", _loc_3);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

        public function getStayAllianceArmys(param1:int, param2:Function = null) : StayAllianceReponse
        {
            this._getStayAllianceArmys_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("army.getStayAllianceArmys", _loc_3);
            }// end if
            return null;
        }// end function

    }
}
