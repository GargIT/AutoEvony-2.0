package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.report.*;

    public class ReportCommands extends Object
    {
        public var _deleteReport_callback:Function;
        public var _readOverReport_callback:Function;
        public var _receiveReportList_callback:Function;
        public var _markAsRead_callback:Function;
        private var sender:Sender;

        public function ReportCommands()
        {
            return;
        }// end function

        public function markAsRead(param1:int, param2:Function = null) : ReportResponse
        {
            this._markAsRead_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.reportId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("report.markAsRead", _loc_3);
            }// end if
            return null;
        }// end function

        public function receiveReportList(param1:int, param2:int, param3:int, param4:Function = null) : ReportListResponse
        {
            this._receiveReportList_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.pageNo = param1;
            _loc_5.pageSize = param2;
            _loc_5.reportType = param3;
            if (this.sender != null)
            {
                sender.sendMessage("report.receiveReportList", _loc_5);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

        public function readOverReport(param1:String, param2:Function = null) : ReportResponse
        {
            this._readOverReport_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.reportIds = param1;
            if (this.sender != null)
            {
                sender.sendMessage("report.readOverReport", _loc_3);
            }// end if
            return null;
        }// end function

        public function deleteReport(param1:String, param2:Function = null) : CommandResponse
        {
            this._deleteReport_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.idStr = param1;
            if (this.sender != null)
            {
                sender.sendMessage("report.deleteReport", _loc_3);
            }// end if
            return null;
        }// end function

    }
}
