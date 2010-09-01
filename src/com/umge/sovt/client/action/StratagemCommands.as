package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;

    public class StratagemCommands extends Object
    {
        private var sender:Sender;
        public var _useStratagem_callback:Function;

        public function StratagemCommands()
        {
            return;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

        public function useStratagem(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
        {
            this._useStratagem_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.heroId = param2;
            _loc_5.straId = param3;
            if (this.sender != null)
            {
                sender.sendMessage("stratagem.useStratagem", _loc_5);
            }// end if
            return null;
        }// end function

    }
}
