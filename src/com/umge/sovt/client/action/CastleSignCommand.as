package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.castle.*;

    public class CastleSignCommand extends Object
    {
        public var _saveCastleSignList_callback:Function;
        public var _deleteCastleSign_callback:Function;
        private var sender:Sender;

        public function CastleSignCommand()
        {
            return;
        }// end function

        public function deleteCastleSign(param1:int, param2:Function = null) : CastleSignResponse
        {
            this._deleteCastleSign_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.id = param1;
            if (this.sender != null)
            {
                sender.sendMessage("castle.deleteCastleSign", _loc_3);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

        public function saveCastleSignList(param1:int, param2:int, param3:int, param4:Function = null) : CastleSignResponse
        {
            this._saveCastleSignList_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.id = param1;
            _loc_5.x = param2;
            _loc_5.y = param3;
            if (this.sender != null)
            {
                sender.sendMessage("castle.saveCastleSignList", _loc_5);
            }// end if
            return null;
        }// end function

    }
}
