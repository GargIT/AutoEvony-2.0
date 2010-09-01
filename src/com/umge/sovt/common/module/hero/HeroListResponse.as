package com.umge.sovt.common.module.hero
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;
    import mx.collections.*;

    public class HeroListResponse extends BaseBean
    {
        public var herosArray:ArrayCollection;
        public var packageId:Number;
        public var msg:String;
        public var errorMsg:String;
        public var posCount:int;
        public var ok:int;

        public function HeroListResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            var _loc_6:HeroBean;
            herosArray = new ArrayCollection();
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
            if (param2.posCount != null)
            {
                this.posCount = param2.posCount;
            }// end if
            if (param2.heros)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.heros.length)
                {
                    // label
                    _loc_6 = new HeroBean(param2.heros[_loc_5]);
                    this.herosArray.addItem(_loc_6);
                    _loc_5++;
                }// end while
            }// end if
            return;
        }// end function

        public function getHeros(param1:int) : HeroBean
        {
            var _loc_2:* = this.herosArray[param1] as HeroBean;
            return _loc_2;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "errorMsg = " + this.errorMsg + "\n");
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "ok = " + this.ok + "\n");
            _loc_2 = _loc_2 + (param1 + "packageId = " + this.packageId + "\n");
            _loc_2 = _loc_2 + (param1 + "posCount = " + this.posCount + "\n");
            _loc_3 = 0;
            while (_loc_3 < this.herosArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getHeros(_loc_3).toDebugString(param1 + "heros[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function copyTo(param1:HeroListResponse) : void
        {
            param1.errorMsg = this.errorMsg;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            param1.posCount = this.posCount;
            CommonUtil.arrayCopy(this.herosArray, param1.herosArray);
            return;
        }// end function

        public function setHeros(param1:HeroBean, param2:int) : void
        {
            this.herosArray[param2] = param1;
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.msg = this.msg;
            _loc_1.ok = this.ok;
            _loc_1.packageId = this.packageId;
            _loc_1.posCount = this.posCount;
            return _loc_1;
        }// end function

    }
}
