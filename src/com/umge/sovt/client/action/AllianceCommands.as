package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.alliance.*;

    public class AllianceCommands extends Object
    {
        public var _getAllianceArmyReport_callback:Function;
        public var _getAllianceInfo_callback:Function;
        public var _getMilitarySituationList_callback:Function;
        private var sender:Sender;
        public var _getAllianceList_callback:Function;
        public var _getAllianceMembers_callback:Function;
        public var _getAllianceEventList_callback:Function;

        public function AllianceCommands()
        {
            return;
        }// end function

        public function getMilitarySituationList(param1:int, param2:int, param3:Function = null) : MilitarySituationListResponse
        {
            this._getMilitarySituationList_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.pageNo = param1;
            _loc_4.pageSize = param2;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.getMilitarySituationList", _loc_4);
            }// end if
            return null;
        }// end function

        public function getAllianceList(param1:int, param2:int, param3:int, param4:String, param5:Function = null) : AllianceListResponse
        {
            this._getAllianceList_callback = param5;
            var _loc_6:* = new Object();
            _loc_6.pageSize = param1;
            _loc_6.pageNum = param2;
            _loc_6.ranking = param3;
            _loc_6.name = param4;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.getAllianceList", _loc_6);
            }// end if
            return null;
        }// end function

        public function getAllianceEventList(param1:int, param2:Function = null) : AllianceEventListResponse
        {
            this._getAllianceEventList_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.pageNo = param1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.getAllianceEventList", _loc_3);
            }// end if
            return null;
        }// end function

        public function getAllianceArmyReport(param1:int, param2:Function = null) : AllianceArmyResponse
        {
            this._getAllianceArmyReport_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.armyId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.getAllianceArmyReport", _loc_3);
            }// end if
            return null;
        }// end function

        public function getAllianceMembers(param1:Function = null) : AllianceMembersResponse
        {
            this._getAllianceMembers_callback = param1;
            var _loc_2:* = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.getAllianceMembers", _loc_2);
            }// end if
            return null;
        }// end function

        public function getAllianceInfo(param1:String, param2:Function = null) : AllianceInfoResponse
        {
            this._getAllianceInfo_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.allianceName = param1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.getAllianceInfo", _loc_3);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

    }
}
