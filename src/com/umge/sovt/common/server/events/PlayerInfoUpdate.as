package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class PlayerInfoUpdate extends BaseBean
    {
        public var playerInfo:PlayerInfoBean;

        public function PlayerInfoUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.playerInfo != null)
            {
                this.playerInfo = new PlayerInfoBean(param2.playerInfo);
            }// end if
            return;
        }// end function

        public function copyTo(param1:PlayerInfoUpdate) : void
        {
            if (playerInfo != null)
            {
                this.playerInfo.copyTo(param1.playerInfo);
            }
            else
            {
                param1.playerInfo = null;
            }// end else if
            return;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            if (playerInfo != null)
            {
                _loc_2 = _loc_2 + this.playerInfo.toDebugString(param1 + "playerInfo.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "playerInfo = null\n");
            }// end else if
            return _loc_2;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.playerInfo = this.playerInfo.toObject();
            return _loc_1;
        }// end function

    }
}
