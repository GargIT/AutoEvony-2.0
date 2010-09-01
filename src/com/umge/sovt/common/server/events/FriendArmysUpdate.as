package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;
    import mx.collections.*;

    public class FriendArmysUpdate extends BaseBean
    {
        public var armysArray:ArrayCollection;

        public function FriendArmysUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            var _loc_6:ArmyBean;
            armysArray = new ArrayCollection();
            super(param1, param3, param4);
            if (param2.armys)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.armys.length)
                {
                    // label
                    _loc_6 = new ArmyBean(param2.armys[_loc_5]);
                    this.armysArray.addItem(_loc_6);
                    _loc_5++;
                }// end while
            }// end if
            return;
        }// end function

        public function getArmys(param1:int) : ArmyBean
        {
            var _loc_2:* = this.armysArray[param1] as ArmyBean;
            return _loc_2;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            return _loc_1;
        }// end function

        public function setArmys(param1:ArmyBean, param2:int) : void
        {
            this.armysArray[param2] = param1;
            return;
        }// end function

        public function copyTo(param1:FriendArmysUpdate) : void
        {
            CommonUtil.arrayCopy(this.armysArray, param1.armysArray);
            return;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_3 = 0;
            while (_loc_3 < this.armysArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getArmys(_loc_3).toDebugString(param1 + "armys[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

    }
}
