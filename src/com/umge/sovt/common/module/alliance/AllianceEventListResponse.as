package com.umge.sovt.common.module.alliance
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;
    import mx.collections.*;

    public class AllianceEventListResponse extends BaseBean
    {
        public var packageId:Number;
        public var eventsArray:ArrayCollection;
        public var msg:String;
        public var pageNo:int;
        public var errorMsg:String;
        public var totalPage:int;
        public var ok:int;

        public function AllianceEventListResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            var _loc_6:AllianceEvent;
            eventsArray = new ArrayCollection();
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
            if (param2.pageNo != null)
            {
                this.pageNo = param2.pageNo;
            }// end if
            if (param2.totalPage != null)
            {
                this.totalPage = param2.totalPage;
            }// end if
            if (param2.events)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.events.length)
                {
                    // label
                    _loc_6 = new AllianceEvent(param2.events[_loc_5]);
                    this.eventsArray.addItem(_loc_6);
                    _loc_5++;
                }// end while
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
            _loc_2 = _loc_2 + (param1 + "pageNo = " + this.pageNo + "\n");
            _loc_2 = _loc_2 + (param1 + "totalPage = " + this.totalPage + "\n");
            _loc_3 = 0;
            while (_loc_3 < this.eventsArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getEvents(_loc_3).toDebugString(param1 + "events[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.msg = this.msg;
            _loc_1.ok = this.ok;
            _loc_1.packageId = this.packageId;
            _loc_1.pageNo = this.pageNo;
            _loc_1.totalPage = this.totalPage;
            return _loc_1;
        }// end function

        public function getEvents(param1:int) : AllianceEvent
        {
            var _loc_2:* = this.eventsArray[param1] as AllianceEvent;
            return _loc_2;
        }// end function

        public function copyTo(param1:AllianceEventListResponse) : void
        {
            param1.errorMsg = this.errorMsg;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            param1.pageNo = this.pageNo;
            param1.totalPage = this.totalPage;
            CommonUtil.arrayCopy(this.eventsArray, param1.eventsArray);
            return;
        }// end function

        public function setEvents(param1:AllianceEvent, param2:int) : void
        {
            this.eventsArray[param2] = param1;
            return;
        }// end function

    }
}
