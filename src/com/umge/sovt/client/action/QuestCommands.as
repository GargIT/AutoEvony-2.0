package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.quest.*;

    public class QuestCommands extends Object
    {
        public var _awardPacket_callback:Function;
        public var _award_callback:Function;
        private var sender:Sender;
        public var _getQuestList_callback:Function;
        public var _getQuestType_callback:Function;

        public function QuestCommands()
        {
            return;
        }// end function

        public function getQuestType(param1:int, param2:int, param3:Function = null) : QuestTypeResponse
        {
            this._getQuestType_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.type = param2;
            if (this.sender != null)
            {
                sender.sendMessage("quest.getQuestType", _loc_4);
            }// end if
            return null;
        }// end function

        public function getQuestList(param1:int, param2:int, param3:Function = null) : QuestListResponse
        {
            this._getQuestList_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.typeId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("quest.getQuestList", _loc_4);
            }// end if
            return null;
        }// end function

        public function awardPacket(param1:int, param2:int, param3:String, param4:Function = null) : CommandResponse
        {
            this._awardPacket_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.castleId = param1;
            _loc_5.questId = param2;
            _loc_5.key = param3;
            if (this.sender != null)
            {
                sender.sendMessage("quest.awardPacket", _loc_5);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

        public function award(param1:int, param2:int, param3:Function = null) : CommandResponse
        {
            this._award_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.questId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("quest.award", _loc_4);
            }// end if
            return null;
        }// end function

    }
}
