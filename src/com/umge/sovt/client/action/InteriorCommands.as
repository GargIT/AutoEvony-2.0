package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.interior.*;

    public class InteriorCommands extends Object
    {
        public var _pacifyPeople_callback:Function;
        public var _modifyTaxRate_callback:Function;
        public var _modifyCommenceRate_callback:Function;
        private var sender:Sender;
        public var _taxation_callback:Function;
        public var _getResourceProduceData_callback:Function;

        public function InteriorCommands()
        {
            return;
        }// end function

        public function modifyTaxRate(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._modifyTaxRate_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.tax = param2;
            if (this.sender != null)
            {
                sender.sendMessage("interior.modifyTaxRate", _loc_4);
            }// end if
            return null;
        }// end function

        public function taxation(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._taxation_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.typeId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("interior.taxation", _loc_4);
            }// end if
            return null;
        }// end function

        public function getResourceProduceData(param1:int, param2:Function = null) : ResourceProduceDataResponse
        {
            this._getResourceProduceData_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("interior.getResourceProduceData", _loc_3);
            }// end if
            return null;
        }// end function

        public function modifyCommenceRate(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Function = null) : CommandResponse
        {
            this._modifyCommenceRate_callback = param6;
            var _loc_7:* = new Object();
            _loc_7.castleId = param1;
            _loc_7.foodrate = param2;
            _loc_7.woodrate = param3;
            _loc_7.stonerate = param4;
            _loc_7.ironrate = param5;
            if (this.sender != null)
            {
                sender.sendMessage("interior.modifyCommenceRate", _loc_7);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

        public function pacifyPeople(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._pacifyPeople_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.typeId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("interior.pacifyPeople", _loc_4);
            }// end if
            return null;
        }// end function

    }
}
