package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class PlayerBuffUpdate extends BaseBean
    {
        public var updateType:int;
        public var buffBean:BuffBean;

        public function PlayerBuffUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.buffBean != null)
            {
                this.buffBean = new BuffBean(param2.buffBean);
            }// end if
            if (param2.updateType != null)
            {
                this.updateType = param2.updateType;
            }// end if
            return;
        }// end function

        public function copyTo(param1:PlayerBuffUpdate) : void
        {
            if (buffBean != null)
            {
                this.buffBean.copyTo(param1.buffBean);
            }
            else
            {
                param1.buffBean = null;
            }// end else if
            param1.updateType = this.updateType;
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.buffBean = this.buffBean.toObject();
            _loc_1.updateType = this.updateType;
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            if (buffBean != null)
            {
                _loc_2 = _loc_2 + this.buffBean.toDebugString(param1 + "buffBean.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "buffBean = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "updateType = " + this.updateType + "\n");
            return _loc_2;
        }// end function

    }
}
