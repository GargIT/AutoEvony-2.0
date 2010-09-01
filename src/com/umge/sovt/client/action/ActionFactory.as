package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;

    public class ActionFactory extends Object
    {
        private var heroCommand:HeroCommand;
        private var allianceManagementCommands:AllianceManagementCommands;
        private var fortificationsCommands:FortificationsCommands;
        private var questCommands:QuestCommands;
        private var cityCommands:CityCommands;
        private var commonCommands:CommonCommands;
        private var tradeCommands:TradeCommands;
        private var shopCommands:ShopCommands;
        private var castleCommands:CastleCommands;
        private var stratagemCommands:StratagemCommands;
        private var castleSignCommand:CastleSignCommand;
        private var armyCommands:ArmyCommands;
        private var friendCommands:FriendCommands;
        private var rankCommands:RankCommands;
        private var interiorCommands:InteriorCommands;
        private var techCommand:TechCommand;
        private var allianceCommands:AllianceCommands;
        private var reportCommands:ReportCommands;
        private var mailCommands:MailCommands;
        private var modifyCommands:ModifyCommands;
        private var fieldCommand:FieldCommand;
        private var troopCommands:TroopCommands;
        private static var _instance:ActionFactory = new ActionFactory;

        public function ActionFactory()
        {
            this.allianceCommands = new AllianceCommands();
            this.allianceManagementCommands = new AllianceManagementCommands();
            this.armyCommands = new ArmyCommands();
            this.castleCommands = new CastleCommands();
            this.castleSignCommand = new CastleSignCommand();
            this.cityCommands = new CityCommands();
            this.commonCommands = new CommonCommands();
            this.fieldCommand = new FieldCommand();
            this.fortificationsCommands = new FortificationsCommands();
            this.friendCommands = new FriendCommands();
            this.modifyCommands = new ModifyCommands();
            this.heroCommand = new HeroCommand();
            this.interiorCommands = new InteriorCommands();
            this.mailCommands = new MailCommands();
            this.questCommands = new QuestCommands();
            this.rankCommands = new RankCommands();
            this.reportCommands = new ReportCommands();
            this.shopCommands = new ShopCommands();
            this.stratagemCommands = new StratagemCommands();
            this.techCommand = new TechCommand();
            this.tradeCommands = new TradeCommands();
            this.troopCommands = new TroopCommands();
            return;
        }// end function

        public function getCastleSignCommand() : CastleSignCommand
        {
            return this.castleSignCommand;
        }// end function

        public function getCityCommands() : CityCommands
        {
            return this.cityCommands;
        }// end function

        public function getCastleCommands() : CastleCommands
        {
            return this.castleCommands;
        }// end function

        public function getTechCommand() : TechCommand
        {
            return this.techCommand;
        }// end function

        public function getShopCommands() : ShopCommands
        {
            return this.shopCommands;
        }// end function

        public function getCommonCommands() : CommonCommands
        {
            return this.commonCommands;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.allianceCommands.setSender(param1);
            this.allianceManagementCommands.setSender(param1);
            this.armyCommands.setSender(param1);
            this.castleCommands.setSender(param1);
            this.castleSignCommand.setSender(param1);
            this.cityCommands.setSender(param1);
            this.commonCommands.setSender(param1);
            this.fieldCommand.setSender(param1);
            this.fortificationsCommands.setSender(param1);
            this.friendCommands.setSender(param1);
            this.modifyCommands.setSender(param1);
            this.heroCommand.setSender(param1);
            this.interiorCommands.setSender(param1);
            this.mailCommands.setSender(param1);
            this.questCommands.setSender(param1);
            this.rankCommands.setSender(param1);
            this.reportCommands.setSender(param1);
            this.shopCommands.setSender(param1);
            this.stratagemCommands.setSender(param1);
            this.techCommand.setSender(param1);
            this.tradeCommands.setSender(param1);
            this.troopCommands.setSender(param1);
            return;
        }// end function

        public function getArmyCommands() : ArmyCommands
        {
            return this.armyCommands;
        }// end function

        public function getHeroCommand() : HeroCommand
        {
            return this.heroCommand;
        }// end function

        public function getFriendCommands() : FriendCommands
        {
            return this.friendCommands;
        }// end function

        public function getRankCommands() : RankCommands
        {
            return this.rankCommands;
        }// end function

        public function getTroopCommands() : TroopCommands
        {
            return this.troopCommands;
        }// end function

        public function getInteriorCommands() : InteriorCommands
        {
            return this.interiorCommands;
        }// end function

        public function getReportCommands() : ReportCommands
        {
            return this.reportCommands;
        }// end function

        public function getAllianceCommands() : AllianceCommands
        {
            return this.allianceCommands;
        }// end function

        public function getTradeCommands() : TradeCommands
        {
            return this.tradeCommands;
        }// end function

        public function getQuestCommands() : QuestCommands
        {
            return this.questCommands;
        }// end function

        public function getMailCommands() : MailCommands
        {
            return this.mailCommands;
        }// end function

        public function getFieldCommand() : FieldCommand
        {
            return this.fieldCommand;
        }// end function

        public function getStratagemCommands() : StratagemCommands
        {
            return this.stratagemCommands;
        }// end function

        public function getModifyCommands() : ModifyCommands
        {
            return this.modifyCommands;
        }// end function

        public function getAllianceManagementCommands() : AllianceManagementCommands
        {
            return this.allianceManagementCommands;
        }// end function

        public function getFortificationsCommands() : FortificationsCommands
        {
            return this.fortificationsCommands;
        }// end function

        public static function getInstance() : ActionFactory
        {
            return _instance;
        }// end function

    }
}
