package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class FortificationsUpdate extends BaseBean
    {
        public var fortification:FortificationsBean;
        public var castleId:int;

        public function FortificationsUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.castleId != null)
            {
                this.castleId = param2.castleId;
            }// end if
            if (param2.fortification != null)
            {
                this.fortification = new FortificationsBean(param2.fortification);
            }// end if
            return;
        }// end function

        public function copyTo(param1:FortificationsUpdate) : void
        {
            param1.castleId = this.castleId;
            if (fortification != null)
            {
                this.fortification.copyTo(param1.fortification);
            }
            else
            {
                param1.fortification = null;
            }// end else if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.castleId = this.castleId;
            _loc_1.fortification = this.fortification.toObject();
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "castleId = " + this.castleId + "\n");
            if (fortification != null)
            {
                _loc_2 = _loc_2 + this.fortification.toDebugString(param1 + "fortification.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "fortification = null\n");
            }// end else if
            return _loc_2;
        }// end function

    }
}
