package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class LoginResponse extends BaseBean
    {
        public var packageId:Number;
        public var player:PlayerBean;
        public var msg:String;
        public var errorMsg:String;
        public var ok:int;
        public static const LOGIN_RESULT_NEED_CREATE_PLAYER:int = -4;
        public static const LOGIN_RESULT_ERROR_USERNAME:int = -2;
        public static const LOGIN_RESULT_SERVER_FULL:int = -3;

        public function LoginResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.errorMsg != null)
            {
                this.errorMsg = param2.errorMsg;
            }// end if
            if (param2.msg != null)
            {
                this.msg = param2.msg;
            }// end if
            if (param2.ok != null)
            {
                this.ok = param2.ok;
            }// end if
            if (param2.packageId != null)
            {
                this.packageId = param2.packageId;
            }// end if
            if (param2.player != null)
            {
                this.player = new PlayerBean(param2.player);
            }// end if
            return;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "errorMsg = " + this.errorMsg + "\n");
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "ok = " + this.ok + "\n");
            _loc_2 = _loc_2 + (param1 + "packageId = " + this.packageId + "\n");
            if (player != null)
            {
                _loc_2 = _loc_2 + this.player.toDebugString(param1 + "player.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "player = null\n");
            }// end else if
            return _loc_2;
        }// end function

        public function copyTo(param1:LoginResponse) : void
        {
            param1.errorMsg = this.errorMsg;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            if (player != null)
            {
                this.player.copyTo(param1.player);
            }
            else
            {
                param1.player = null;
            }// end else if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.msg = this.msg;
            _loc_1.ok = this.ok;
            _loc_1.packageId = this.packageId;
            _loc_1.player = this.player.toObject();
            return _loc_1;
        }// end function

    }
}
