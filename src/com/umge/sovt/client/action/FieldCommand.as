package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.field.*;

    public class FieldCommand extends Object
    {
        private var sender:Sender;
        public var _getCastleFieldInfo_callback:Function;
        public var _giveUpField_callback:Function;
        public var _getOtherFieldInfo_callback:Function;

        public function FieldCommand()
        {
            return;
        }// end function

        public function giveUpField(param1:int, param2:Function = null) : CommandResponse
        {
            this._giveUpField_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.fieldId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("field.giveUpField", _loc_3);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

        public function getCastleFieldInfo(param1:int, param2:Function = null) : CastleFieldInfoResponse
        {
            this._getCastleFieldInfo_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("field.getCastleFieldInfo", _loc_3);
            }// end if
            return null;
        }// end function

        public function getOtherFieldInfo(param1:int, param2:Function = null) : OtherFieldInfoResponse
        {
            this._getOtherFieldInfo_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.fieldId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("field.getOtherFieldInfo", _loc_3);
            }// end if
            return null;
        }// end function

    }
}
