package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.rank.*;

    public class RankCommands extends Object
    {
        public var _getPlayerRank_callback:Function;
        public var _getHeroRank_callback:Function;
        public var _getCastleRank_callback:Function;
        public var _getAllianceRank_callback:Function;
        private var sender:Sender;

        public function RankCommands()
        {
            return;
        }// end function

        public function getPlayerRank(param1:String, param2:int, param3:int, param4:int, param5:Function = null) : RankPlayerResponse
        {
            this._getPlayerRank_callback = param5;
            var _loc_6:* = new Object();
            _loc_6.key = param1;
            _loc_6.pageNo = param2;
            _loc_6.pageSize = param3;
            _loc_6.sortType = param4;
            if (this.sender != null)
            {
                sender.sendMessage("rank.getPlayerRank", _loc_6);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

        public function getAllianceRank(param1:String, param2:int, param3:int, param4:int, param5:Function = null) : RankAllianceResponse
        {
            this._getAllianceRank_callback = param5;
            var _loc_6:* = new Object();
            _loc_6.key = param1;
            _loc_6.pageNo = param2;
            _loc_6.pageSize = param3;
            _loc_6.sortType = param4;
            if (this.sender != null)
            {
                sender.sendMessage("rank.getAllianceRank", _loc_6);
            }// end if
            return null;
        }// end function

        public function getCastleRank(param1:String, param2:int, param3:int, param4:int, param5:Function = null) : RankCastleResponse
        {
            this._getCastleRank_callback = param5;
            var _loc_6:* = new Object();
            _loc_6.key = param1;
            _loc_6.pageNo = param2;
            _loc_6.pageSize = param3;
            _loc_6.sortType = param4;
            if (this.sender != null)
            {
                sender.sendMessage("rank.getCastleRank", _loc_6);
            }// end if
            return null;
        }// end function

        public function getHeroRank(param1:String, param2:int, param3:int, param4:int, param5:Function = null) : RankHeroResponse
        {
            this._getHeroRank_callback = param5;
            var _loc_6:* = new Object();
            _loc_6.key = param1;
            _loc_6.pageNo = param2;
            _loc_6.pageSize = param3;
            _loc_6.sortType = param4;
            if (this.sender != null)
            {
                sender.sendMessage("rank.getHeroRank", _loc_6);
            }// end if
            return null;
        }// end function

    }
}
