package com.umge.sovt.common.module.common
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;
    import mx.collections.*;

    public class MapInfoSimpleResponse extends BaseBean
    {
        public var packageId:Number;
        public var msg:String;
        public var y1:int;
        public var y2:int;
        public var ok:int;
        public var castlesArray:ArrayCollection;
        public var errorMsg:String;
        public var mapStr:String;
        public var x1:int;
        public var x2:int;

        public function MapInfoSimpleResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            var _loc_6:MapCastleBean;
            castlesArray = new ArrayCollection();
            super(param1, param3, param4);
            if (param2.errorMsg != null)
            {
                this.errorMsg = param2.errorMsg;
            }// end if
            if (param2.mapStr != null)
            {
                this.mapStr = param2.mapStr;
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
            if (param2.x1 != null)
            {
                this.x1 = param2.x1;
            }// end if
            if (param2.x2 != null)
            {
                this.x2 = param2.x2;
            }// end if
            if (param2.y1 != null)
            {
                this.y1 = param2.y1;
            }// end if
            if (param2.y2 != null)
            {
                this.y2 = param2.y2;
            }// end if
            if (param2.castles)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.castles.length)
                {
                    // label
                    _loc_6 = new MapCastleBean(param2.castles[_loc_5]);
                    this.castlesArray.addItem(_loc_6);
                    _loc_5++;
                }// end while
            }// end if
            return;
        }// end function

        public function setCastles(param1:MapCastleBean, param2:int) : void
        {
            this.castlesArray[param2] = param1;
            return;
        }// end function

        public function getCastles(param1:int) : MapCastleBean
        {
            var _loc_2:* = this.castlesArray[param1] as MapCastleBean;
            return _loc_2;
        }// end function

        public function copyTo(param1:MapInfoSimpleResponse) : void
        {
            param1.errorMsg = this.errorMsg;
            param1.mapStr = this.mapStr;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            param1.x1 = this.x1;
            param1.x2 = this.x2;
            param1.y1 = this.y1;
            param1.y2 = this.y2;
            CommonUtil.arrayCopy(this.castlesArray, param1.castlesArray);
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.mapStr = this.mapStr;
            _loc_1.msg = this.msg;
            _loc_1.ok = this.ok;
            _loc_1.packageId = this.packageId;
            _loc_1.x1 = this.x1;
            _loc_1.x2 = this.x2;
            _loc_1.y1 = this.y1;
            _loc_1.y2 = this.y2;
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "errorMsg = " + this.errorMsg + "\n");
            _loc_2 = _loc_2 + (param1 + "mapStr = " + this.mapStr + "\n");
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "ok = " + this.ok + "\n");
            _loc_2 = _loc_2 + (param1 + "packageId = " + this.packageId + "\n");
            _loc_2 = _loc_2 + (param1 + "x1 = " + this.x1 + "\n");
            _loc_2 = _loc_2 + (param1 + "x2 = " + this.x2 + "\n");
            _loc_2 = _loc_2 + (param1 + "y1 = " + this.y1 + "\n");
            _loc_2 = _loc_2 + (param1 + "y2 = " + this.y2 + "\n");
            _loc_3 = 0;
            while (_loc_3 < this.castlesArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getCastles(_loc_3).toDebugString(param1 + "castles[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

    }
}
