package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.castle.*;
    import com.umge.sovt.common.module.tech.*;

    public class TechCommand extends Object
    {
        public var _getCoinsNeed_callback:Function;
        public var _research_callback:Function;
        public var _speedUpResearch_callback:Function;
        public var _cancelResearch_callback:Function;
        public var _getResearchList_callback:Function;
        private var sender:Sender;

        public function TechCommand()
        {
            return;
        }// end function

        public function getCoinsNeed(param1:int, param2:Function = null) : CoinsNeedResponse
        {
            this._getCoinsNeed_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("tech.getCoinsNeed", _loc_3);
            }// end if
            return null;
        }// end function

        public function getResearchList(param1:int, param2:Function = null) : AvailableResearchListResponse
        {
            this._getResearchList_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("tech.getResearchList", _loc_3);
            }// end if
            return null;
        }// end function

        public function research(param1:int, param2:int, param3:Function = null) : ResearchResponse
        {
            this._research_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.techId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("tech.research", _loc_4);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

        public function cancelResearch(param1:int, param2:Function = null) : CommandResponse
        {
            this._cancelResearch_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.castleId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("tech.cancelResearch", _loc_3);
            }// end if
            return null;
        }// end function

        public function speedUpResearch(param1:int, param2:String, param3:Function = null) : ResearchResponse
        {
            this._speedUpResearch_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.itemId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("tech.speedUpResearch", _loc_4);
            }// end if
            return null;
        }// end function

    }
}
