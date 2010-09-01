package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class CastleUpdate extends BaseBean
    {
        public var updateType:int;
        public var castleBean:CastleBean;

        public function CastleUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.castleBean != null)
            {
                this.castleBean = new CastleBean(param2.castleBean);
            }// end if
            if (param2.updateType != null)
            {
                this.updateType = param2.updateType;
            }// end if
            return;
        }// end function

        public function copyTo(param1:CastleUpdate) : void
        {
            if (castleBean != null)
            {
                this.castleBean.copyTo(param1.castleBean);
            }
            else
            {
                param1.castleBean = null;
            }// end else if
            param1.updateType = this.updateType;
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.castleBean = this.castleBean.toObject();
            _loc_1.updateType = this.updateType;
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            if (castleBean != null)
            {
                _loc_2 = _loc_2 + this.castleBean.toDebugString(param1 + "castleBean.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "castleBean = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "updateType = " + this.updateType + "\n");
            return _loc_2;
        }// end function

    }
}
