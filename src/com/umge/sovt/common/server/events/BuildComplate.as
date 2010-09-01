package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class BuildComplate extends BaseBean
    {
        public var castleId:int;
        public var buildingBean:BuildingBean;

        public function BuildComplate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.buildingBean != null)
            {
                this.buildingBean = new BuildingBean(param2.buildingBean);
            }// end if
            if (param2.castleId != null)
            {
                this.castleId = param2.castleId;
            }// end if
            return;
        }// end function

        public function copyTo(param1:BuildComplate) : void
        {
            if (buildingBean != null)
            {
                this.buildingBean.copyTo(param1.buildingBean);
            }
            else
            {
                param1.buildingBean = null;
            }// end else if
            param1.castleId = this.castleId;
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.buildingBean = this.buildingBean.toObject();
            _loc_1.castleId = this.castleId;
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            if (buildingBean != null)
            {
                _loc_2 = _loc_2 + this.buildingBean.toDebugString(param1 + "buildingBean.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "buildingBean = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "castleId = " + this.castleId + "\n");
            return _loc_2;
        }// end function

    }
}
