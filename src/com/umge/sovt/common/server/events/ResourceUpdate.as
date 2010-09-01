package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class ResourceUpdate extends BaseBean
    {
        public var packageId:Number;
        public var msg:String;
        public var resource:CastleResourceBean;
        public var castleId:int;
        public var errorMsg:String;
        public var ok:int;

        public function ResourceUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.castleId != null)
            {
                this.castleId = param2.castleId;
            }// end if
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
            if (param2.resource != null)
            {
                this.resource = new CastleResourceBean(param2.resource);
            }// end if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.castleId = this.castleId;
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.msg = this.msg;
            _loc_1.ok = this.ok;
            _loc_1.packageId = this.packageId;
            _loc_1.resource = this.resource.toObject();
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "castleId = " + this.castleId + "\n");
            _loc_2 = _loc_2 + (param1 + "errorMsg = " + this.errorMsg + "\n");
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "ok = " + this.ok + "\n");
            _loc_2 = _loc_2 + (param1 + "packageId = " + this.packageId + "\n");
            if (resource != null)
            {
                _loc_2 = _loc_2 + this.resource.toDebugString(param1 + "resource.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "resource = null\n");
            }// end else if
            return _loc_2;
        }// end function

        public function copyTo(param1:ResourceUpdate) : void
        {
            param1.castleId = this.castleId;
            param1.errorMsg = this.errorMsg;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            if (resource != null)
            {
                this.resource.copyTo(param1.resource);
            }
            else
            {
                param1.resource = null;
            }// end else if
            return;
        }// end function

    }
}
