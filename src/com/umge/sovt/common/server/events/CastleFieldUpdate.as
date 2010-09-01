package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class CastleFieldUpdate extends BaseBean
    {
        public var bean:FieldBean;
        public var updateType:int;
        public var castleId:int;

        public function CastleFieldUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.bean != null)
            {
                this.bean = new FieldBean(param2.bean);
            }// end if
            if (param2.castleId != null)
            {
                this.castleId = param2.castleId;
            }// end if
            if (param2.updateType != null)
            {
                this.updateType = param2.updateType;
            }// end if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.bean = this.bean.toObject();
            _loc_1.castleId = this.castleId;
            _loc_1.updateType = this.updateType;
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            if (bean != null)
            {
                _loc_2 = _loc_2 + this.bean.toDebugString(param1 + "bean.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "bean = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "castleId = " + this.castleId + "\n");
            _loc_2 = _loc_2 + (param1 + "updateType = " + this.updateType + "\n");
            return _loc_2;
        }// end function

        public function copyTo(param1:CastleFieldUpdate) : void
        {
            if (bean != null)
            {
                this.bean.copyTo(param1.bean);
            }
            else
            {
                param1.bean = null;
            }// end else if
            param1.castleId = this.castleId;
            param1.updateType = this.updateType;
            return;
        }// end function

    }
}
