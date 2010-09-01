package com.umge.sovt.client.response
{
    import com.umge.sovt.client.action.*;
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.alliance.*;
    import com.umge.sovt.common.module.army.*;
    import com.umge.sovt.common.module.castle.*;
    import com.umge.sovt.common.module.city.*;
    import com.umge.sovt.common.module.common.*;
    import com.umge.sovt.common.module.field.*;
    import com.umge.sovt.common.module.fortifications.*;
    import com.umge.sovt.common.module.friend.*;
    import com.umge.sovt.common.module.gamemaster.*;
    import com.umge.sovt.common.module.hero.*;
    import com.umge.sovt.common.module.interior.*;
    import com.umge.sovt.common.module.mail.*;
    import com.umge.sovt.common.module.quest.*;
    import com.umge.sovt.common.module.rank.*;
    import com.umge.sovt.common.module.report.*;
    import com.umge.sovt.common.module.shop.*;
    import com.umge.sovt.common.module.tech.*;
    import com.umge.sovt.common.module.trade.*;
    import com.umge.sovt.common.module.troop.*;
    import com.umge.sovt.common.server.events.*;
    import flash.events.*;

    public class ResponseDispatcher extends EventDispatcher
    {
        public var onRegisterResponse:Function = null;
        public var onSelfArmysUpdate:Function = null;
        public var onCastleFieldUpdate:Function = null;
        public var onEnemyArmysUpdate:Function = null;
        public var onResourceUpdate:Function = null;
        public var onChannelChatMsg:Function = null;
        public var onPrivateChatMessage:Function = null;
        public var onFortificationsUpdate:Function = null;
        public var onTransingTradeUpdate:Function = null;
        public var onKickedOut:Function = null;
        public var onNewMail:Function = null;
        public var onResearchCompleteUpdate:Function = null;
        public var onWorldChatMsg:Function = null;
        public var onHeroUpdate:Function = null;
        public var onPackageList:Function = null;
        public var onTradesUpdate:Function = null;
        public var onPlayerBuffUpdate:Function = null;
        public var onPlayerInfoUpdate:Function = null;
        public var onInjuredTroopUpdate:Function = null;
        public var onConnectionLost:Function = null;
        public var onAllianceChatMsg:Function = null;
        public var onItemUpdate:Function = null;
        public var onItemBuff:Function = null;
        public var onBuildComplate:Function = null;
        public var onSystemInfoMsg:Function = null;
        public var onLoginResponse:Function = null;
        public var onFriendArmysUpdate:Function = null;
        public var onTroopUpdate:Function = null;
        public var onCastleUpdate:Function = null;
        private var respMap:Object;
        public var onNewFinishedQuest:Function = null;
        public var onNewReport:Function = null;
        public var onQuestFinished:Function = null;
        public var onStrategyBuff:Function = null;
        private var actionFactory:ActionFactory;
        public static const TROOP_GET_TROOP_PRODUCE_LIST:String = "troop.getTroopProduceList";
        public static const ALLIANCE_DROP_ALLIANCE_FRIENDSHIP_RELATION:String = "alliance.dropAllianceFriendshipRelation";
        public static const CASTLE_UPGRADE_BUILDING:String = "castle.upgradeBuilding";
        public static const SERVER_NEW_FINISHED_QUEST:String = "server.NewFinishedQuest";
        public static const GAMEMASTER_ADD_HERO:String = "gamemaster.addHero";
        public static const ALLIANCE_CREATE_ALLIANCE:String = "alliance.createAlliance";
        public static const HERO_REFRESH_HEROS_LIST_FROM_TAVERN:String = "hero.refreshHerosListFromTavern";
        public static const SERVER_CASTLE_UPDATE:String = "server.CastleUpdate";
        public static const HERO_DISCHARGE_CHIEF:String = "hero.dischargeChief";
        public static const COMMON_ZONE_INFO:String = "common.zoneInfo";
        public static const GAMEMASTER_SET_RESOURCES:String = "gamemaster.setResources";
        public static const TECH_GET_RESEARCH_LIST:String = "tech.getResearchList";
        public static const TROOP_CHECK_IDLE_BARRACK:String = "troop.checkIdleBarrack";
        public static const TECH_CANCEL_RESEARCH:String = "tech.cancelResearch";
        public static const SERVER_TROOP_UPDATE:String = "server.TroopUpdate";
        public static const FIELD_GET_CASTLE_FIELD_INFO:String = "field.getCastleFieldInfo";
        public static const HERO_ADD_POINT:String = "hero.addPoint";
        public static const COMMON_MAP_CASTLE:String = "common.mapCastle";
        public static const SERVER_INJURED_TROOP_UPDATE:String = "server.InjuredTroopUpdate";
        public static const ARMY_CALL_BACK_ARMY:String = "army.callBackArmy";
        public static const MAIL_READ_MAIL:String = "mail.readMail";
        public static const SERVER_ITEM_BUFF:String = "server.ItemBuff";
        public static const CITY_MODIFY_STORE_PERCENT:String = "city.modifyStorePercent";
        public static const INTERIOR_GET_RESOURCE_PRODUCE_DATA:String = "interior.getResourceProduceData";
        public static const GAMEMASTER_ADD_BUILDING:String = "gamemaster.addBuilding";
        public static const TECH_GET_COINS_NEED:String = "tech.getCoinsNeed";
        public static const ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_USER:String = "alliance.agreeComeinAllianceByUser";
        public static const STRATAGEM_USE_STRATAGEM:String = "stratagem.useStratagem";
        public static const ALLIANCE_USER_WANT_IN_ALLIANCE:String = "alliance.userWantInAlliance";
        public static const COMMON_CREATE_NEW_PLAYER:String = "common.createNewPlayer";
        public static const ALLIANCE_CANCELADD_USERTO_ALLIANCE:String = "alliance.canceladdUsertoAlliance";
        public static const MAIL_REPORT_BUG:String = "mail.reportBug";
        public static const CITY_MOVE_CASTLE:String = "city.moveCastle";
        public static const SERVER_PLAYER_BUFF_UPDATE:String = "server.PlayerBuffUpdate";
        public static const ALLIANCE_GET_ALLIANCE_LIST:String = "alliance.getAllianceList";
        public static const COMMON_CHANGE_USER_FACE:String = "common.changeUserFace";
        public static const ALLIANCE_KICK_OUT_MEMBERFROM_ALLIANCE:String = "alliance.kickOutMemberfromAlliance";
        public static const CASTLE_GET_AVAILABLE_BUILDING_LIST_INSIDE:String = "castle.getAvailableBuildingListInside";
        public static const FRIEND_ADD_FRIEND:String = "friend.addFriend";
        public static const HERO_HIRE_HERO:String = "hero.hireHero";
        public static const TRADE_CANCEL_TRADE:String = "trade.cancelTrade";
        public static const QUEST_GET_QUEST_TYPE:String = "quest.getQuestType";
        public static const ALLIANCE_GET_ALLIANCE_INFO:String = "alliance.getAllianceInfo";
        public static const FORTIFICATIONS_PRODUCE_WALL_PROTECT:String = "fortifications.produceWallProtect";
        public static const SERVER_REGISTER_RESPONSE:String = "server.RegisterResponse";
        public static const INTERIOR_MODIFY_TAX_RATE:String = "interior.modifyTaxRate";
        public static const HERO_FIRE_HERO:String = "hero.fireHero";
        public static const ALLIANCE_RESIGN_FOR_ALLIANCE:String = "alliance.resignForAlliance";
        public static const CASTLE_GET_AVAILABLE_BUILDING_BEAN:String = "castle.getAvailableBuildingBean";
        public static const SHOP_BUY_RESOURCE:String = "shop.buyResource";
        public static const SERVER_ITEM_UPDATE:String = "server.ItemUpdate";
        public static const CASTLE_NEW_BUILDING:String = "castle.newBuilding";
        public static const REPORT_DELETE_REPORT:String = "report.deleteReport";
        public static const ALLIANCE_GET_ALLIANCE_ARMY_REPORT:String = "alliance.getAllianceArmyReport";
        public static const QUEST_AWARD:String = "quest.award";
        public static const CASTLE_GET_DESTRUCT_BUILD_BEAN:String = "castle.getDestructBuildBean";
        public static const ARMY_EXERCISE_ARMY:String = "army.exerciseArmy";
        public static const HERO_AWARD_GOLD:String = "hero.awardGold";
        public static const COMMON_PRIVATE_CHAT:String = "common.privateChat";
        public static const SHOP_USE_GOODS:String = "shop.useGoods";
        public static const SERVER_PACKAGE_LIST:String = "server.PackageList";
        private static var instance:ResponseDispatcher = new ResponseDispatcher;
        public static const HERO_CALL_BACK_HERO:String = "hero.callBackHero";
        public static const ALLIANCE_CANCELAGREE_COMEIN_ALLIANCE:String = "alliance.cancelagreeComeinAlliance";
        public static const TROOP_CANCEL_TROOP_PRODUCE:String = "troop.cancelTroopProduce";
        public static const RANK_GET_ALLIANCE_RANK:String = "rank.getAllianceRank";
        public static const GAMEMASTER_REMOVE_BUILDING:String = "gamemaster.removeBuilding";
        public static const ALLIANCE_GET_ALLIANCE_WANTED:String = "alliance.getAllianceWanted";
        public static const CASTLE_GET_AVAILABLE_BUILDING_LIST_OUTSIDE:String = "castle.getAvailableBuildingListOutside";
        public static const CITY_ADV_MOVE_CASTLE:String = "city.advMoveCastle";
        public static const ALLIANCE_ADD_USERTO_ALLIANCE_LIST:String = "alliance.addUsertoAllianceList";
        public static const RANK_GET_HERO_RANK:String = "rank.getHeroRank";
        public static const SERVER_TRANSING_TRADE_UPDATE:String = "server.TransingTradeUpdate";
        public static const CASTLE_DELETE_CASTLE_SIGN:String = "castle.deleteCastleSign";
        public static const COMMON_DELETE_USER_AND_RESTART:String = "common.deleteUserAndRestart";
        public static const COMMON_GET_PLAYER_INFO_BY_NAME:String = "common.getPlayerInfoByName";
        public static const GAMEMASTER_ADD_ITEMS:String = "gamemaster.addItems";
        public static const ALLIANCE_GET_POWER_FROM_ALLIANCE:String = "alliance.getPowerFromAlliance";
        public static const FRIEND_IS_BLOCK_MAIL_PLAYER:String = "friend.isBlockMailPlayer";
        public static const ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_LEADER:String = "alliance.agreeComeinAllianceByLeader";
        public static const HERO_PROMOTE_TO_CHIEF:String = "hero.promoteToChief";
        public static const CITY_MODIFY_CASTLE_NAME:String = "city.modifyCastleName";
        public static const FRIEND_ADD_BLOCK:String = "friend.addBlock";
        public static const TRADE_SEARCH_TRADES:String = "trade.searchTrades";
        public static const TRADE_NEW_TRADE:String = "trade.newTrade";
        public static const SERVER_CASTLE_FIELD_UPDATE:String = "server.CastleFieldUpdate";
        public static const TROOP_PRODUCE_TROOP:String = "troop.produceTroop";
        public static const CITY_CONSTRUCT_CASTLE:String = "city.constructCastle";
        public static const SERVER_NEW_MAIL:String = "server.NewMail";
        public static const COMMON_WORLD_CHAT:String = "common.worldChat";
        public static const FRIEND_DELETE_BLOCK:String = "friend.deleteBlock";
        public static const FORTIFICATIONS_GET_FORTIFICATIONS_PRODUCE_LIST:String = "fortifications.getFortificationsProduceList";
        public static const SERVER_ENEMY_ARMYS_UPDATE:String = "server.EnemyArmysUpdate";
        public static const INTERIOR_MODIFY_COMMENCE_RATE:String = "interior.modifyCommenceRate";
        public static const SERVER_CONNECTION_LOST:String = "server.ConnectionLost";
        public static const SHOP_GET_BUY_RESOURCE_INFO:String = "shop.getBuyResourceInfo";
        public static const SERVER_PRIVATE_CHAT_MESSAGE:String = "server.PrivateChatMessage";
        public static const SERVER_LOGIN_RESPONSE:String = "server.LoginResponse";
        public static const ARMY_GET_TROOP_PARAM:String = "army.getTroopParam";
        public static const SERVER_WORLD_CHAT_MSG:String = "server.WorldChatMsg";
        public static const SERVER_SELF_ARMYS_UPDATE:String = "server.SelfArmysUpdate";
        public static const ALLIANCE_REJECT_COMEIN_ALLIANCE:String = "alliance.rejectComeinAlliance";
        public static const CITY_MODIFY_FLAG:String = "city.modifyFlag";
        public static const FIELD_GIVE_UP_FIELD:String = "field.giveUpField";
        public static const GAMEMASTER_REMOVE_ITEM:String = "gamemaster.removeItem";
        public static const COMMON_CHANNEL_CHAT:String = "common.channelChat";
        public static const ALLIANCE_ADD_USERTO_ALLIANCE:String = "alliance.addUsertoAlliance";
        public static const COMMON_ALLIANCE_CHAT:String = "common.allianceChat";
        public static const HERO_CHANGE_NAME:String = "hero.changeName";
        public static const SERVER_ALLIANCE_CHAT_MSG:String = "server.AllianceChatMsg";
        public static const INTERIOR_PACIFY_PEOPLE:String = "interior.pacifyPeople";
        public static const ARMY_SET_ARMY_GO_OUT:String = "army.setArmyGoOut";
        public static const SERVER_FORTIFICATIONS_UPDATE:String = "server.FortificationsUpdate";
        public static const SERVER_RESOURCE_UPDATE:String = "server.ResourceUpdate";
        public static const FORTIFICATIONS_DESTRUCT_WALL_PROTECT:String = "fortifications.destructWallProtect";
        public static const QUEST_AWARD_PACKET:String = "quest.awardPacket";
        public static const MAIL_RECEIVE_MAIL_LIST:String = "mail.receiveMailList";
        public static const TECH_RESEARCH:String = "tech.research";
        public static const CITY_SET_STOP_WAR_STATE:String = "city.setStopWarState";
        public static const RANK_GET_PLAYER_RANK:String = "rank.getPlayerRank";
        public static const REPORT_MARK_AS_READ:String = "report.markAsRead";
        public static const TECH_SPEED_UP_RESEARCH:String = "tech.speedUpResearch";
        public static const SHOP_USE_CASTLE_GOODS:String = "shop.useCastleGoods";
        public static const MAIL_DELETE_MAIL:String = "mail.deleteMail";
        public static const HERO_TRY_GET_SEIZED_HERO:String = "hero.tryGetSeizedHero";
        public static const ALLIANCE_IS_HAS_ALLIANCE:String = "alliance.isHasAlliance";
        public static const FORTIFICATIONS_CANCEL_FORTIFICATION_PRODUCE:String = "fortifications.cancelFortificationProduce";
        public static const SERVER_NEW_REPORT:String = "server.NewReport";
        public static const ARMY_GET_INJURED_TROOP:String = "army.getInjuredTroop";
        public static const COMMON_GET_PACKAGE_LIST:String = "common.getPackageList";
        public static const CITY_GIVEUP_CASTLE:String = "city.giveupCastle";
        public static const TROOP_DISBAND_TROOP:String = "troop.disbandTroop";
        public static const ALLIANCE_CANCEL_USER_WANT_IN_ALLIANCE:String = "alliance.cancelUserWantInAlliance";
        public static const TRADE_GET_TRANSING_TRADE_LIST:String = "trade.getTransingTradeList";
        public static const ALLIANCE_SET_ALLIANCE_FRIENDSHIP:String = "alliance.setAllianceFriendship";
        public static const ARMY_NEW_ARMY:String = "army.newArmy";
        public static const CITY_GET_STORE_LIST:String = "city.getStoreList";
        public static const SERVER_CHANNEL_CHAT_MSG:String = "server.ChannelChatMsg";
        public static const SERVER_RESEARCH_COMPLETE_UPDATE:String = "server.ResearchCompleteUpdate";
        public static const CASTLE_CANCLE_BUILD_COMMAND:String = "castle.cancleBuildCommand";
        public static const TRADE_SPEED_UP_TRANS:String = "trade.speedUpTrans";
        public static const HERO_RELEASE_HERO:String = "hero.releaseHero";
        public static const ALLIANCE_SET_ALL_INFO_FOR_ALLIANCE:String = "alliance.setAllInfoForAlliance";
        public static const SERVER_SYSTEM_INFO_MSG:String = "server.SystemInfoMsg";
        public static const MAIL_GET_ALL_T_V_MSG:String = "mail.getAllTVMsg";
        public static const REPORT_READ_OVER_REPORT:String = "report.readOverReport";
        public static const ALLIANCE_RESET_TOP_POWER_FOR_ALLIANCE:String = "alliance.resetTopPowerForAlliance";
        public static const COMMON_MAP_INFO_SIMPLE:String = "common.mapInfoSimple";
        public static const CASTLE_CHECK_OUT_UPGRADE:String = "castle.checkOutUpgrade";
        public static const CITY_MODIFY_USER_NAME:String = "city.modifyUserName";
        public static const HERO_USE_ITEM:String = "hero.useItem";
        public static const MAIL_SEND_MAIL:String = "mail.sendMail";
        public static const TROOP_ACC_TROOP_PRODUCE:String = "troop.accTroopProduce";
        public static const HERO_RESET_POINT:String = "hero.resetPoint";
        public static const SHOP_BUY:String = "shop.buy";
        public static const SERVER_PLAYER_INFO_UPDATE:String = "server.PlayerInfoUpdate";
        public static const ALLIANCE_MESSAGES_FOR_ALLIANCE_MEMBER:String = "alliance.messagesForAllianceMember";
        public static const CASTLE_GET_COINS_NEED:String = "castle.getCoinsNeed";
        public static const RANK_GET_CASTLE_RANK:String = "rank.getCastleRank";
        public static const COMMON_MAP_INFO:String = "common.mapInfo";
        public static const HERO_GET_HEROS_LIST_FROM_TAVERN:String = "hero.getHerosListFromTavern";
        public static const TROOP_GET_PRODUCE_QUEUE:String = "troop.getProduceQueue";
        public static const CASTLE_DESTRUCT_BUILDING:String = "castle.destructBuilding";
        public static const ALLIANCE_GET_ALLIANCE_EVENT_LIST:String = "alliance.getAllianceEventList";
        public static const SERVER_BUILD_COMPLATE:String = "server.BuildComplate";
        public static const MAIL_READ_OVER_MAIL_LIST:String = "mail.readOverMailList";
        public static const FORTIFICATIONS_ACC_TROOP_PRODUCE:String = "fortifications.accTroopProduce";
        public static const ALLIANCE_GET_MILITARY_SITUATION_LIST:String = "alliance.getMilitarySituationList";
        public static const QUEST_GET_QUEST_LIST:String = "quest.getQuestList";
        public static const REPORT_RECEIVE_REPORT_LIST:String = "report.receiveReportList";
        public static const SERVER_TRADES_UPDATE:String = "server.TradesUpdate";
        public static const SERVER_STRATEGY_BUFF:String = "server.StrategyBuff";
        public static const ALLIANCE_SET_POWER_FOR_USER_BY_ALLIANCE:String = "alliance.setPowerForUserByAlliance";
        public static const ARMY_GET_STAY_ALLIANCE_ARMYS:String = "army.getStayAllianceArmys";
        public static const FORTIFICATIONS_GET_PRODUCE_QUEUE:String = "fortifications.getProduceQueue";
        public static const MAIL_REPORT_PLAYER:String = "mail.reportPlayer";
        public static const ALLIANCE_GET_ALLIANCE_FRIENDSHIP_LIST:String = "alliance.getAllianceFriendshipList";
        public static const FIELD_GET_OTHER_FIELD_INFO:String = "field.getOtherFieldInfo";
        public static const FRIEND_DELETE_FRIEND:String = "friend.deleteFriend";
        public static const CASTLE_SPEED_UP_BUILD_COMMAND:String = "castle.speedUpBuildCommand";
        public static const SERVER_FRIEND_ARMYS_UPDATE:String = "server.FriendArmysUpdate";
        public static const COMMON_GET_PACKAGE:String = "common.getPackage";
        public static const INTERIOR_TAXATION:String = "interior.taxation";
        public static const SERVER_QUEST_FINISHED:String = "server.QuestFinished";
        public static const CASTLE_SAVE_CASTLE_SIGN_LIST:String = "castle.saveCastleSignList";
        public static const SERVER_HERO_UPDATE:String = "server.HeroUpdate";
        public static const ALLIANCE_GET_ALLIANCE_MEMBERS:String = "alliance.getAllianceMembers";
        public static const ALLIANCE_SAY_BYETO_ALLIANCE:String = "alliance.sayByetoAlliance";
        public static const GAMEMASTER_REMOVE_HERO:String = "gamemaster.removeHero";
        public static const ALLIANCE_AGREE_COMEIN_ALLIANCE_LIST:String = "alliance.agreeComeinAllianceList";
        public static const TRADE_GET_MY_TRADE_LIST:String = "trade.getMyTradeList";
        public static const ARMY_SET_ALLOW_ALLIANCE_ARMY:String = "army.setAllowAllianceArmy";
        public static const SERVER_KICKED_OUT:String = "server.KickedOut";
        public static const GAMEMASTER_SET_TECHNOLOGY:String = "gamemaster.setTechnology";
        public static const ARMY_DISBAND_INJURED_TROOP:String = "army.disbandInjuredTroop";
        public static const HERO_LEVEL_UP:String = "hero.levelUp";
        public static const ARMY_CURE_INJURED_TROOP:String = "army.cureInjuredTroop";
        public static const ALLIANCE_LEADER_WANT_USER_IN_ALLIANCE_LIST:String = "alliance.leaderWantUserInAllianceList";

        public function ResponseDispatcher()
        {
            actionFactory = ActionFactory.getInstance();
            respMap = new Object();
            respMap["alliance.getAllianceArmyReport"] = _resp_alliance_getAllianceArmyReport;
            respMap["alliance.getAllianceEventList"] = _resp_alliance_getAllianceEventList;
            respMap["alliance.getAllianceInfo"] = _resp_alliance_getAllianceInfo;
            respMap["alliance.getAllianceList"] = _resp_alliance_getAllianceList;
            respMap["alliance.getAllianceMembers"] = _resp_alliance_getAllianceMembers;
            respMap["alliance.getMilitarySituationList"] = _resp_alliance_getMilitarySituationList;
            respMap["alliance.addUsertoAlliance"] = _resp_alliance_addUsertoAlliance;
            respMap["alliance.addUsertoAllianceList"] = _resp_alliance_addUsertoAllianceList;
            respMap["alliance.agreeComeinAllianceByLeader"] = _resp_alliance_agreeComeinAllianceByLeader;
            respMap["alliance.agreeComeinAllianceByUser"] = _resp_alliance_agreeComeinAllianceByUser;
            respMap["alliance.agreeComeinAllianceList"] = _resp_alliance_agreeComeinAllianceList;
            respMap["alliance.cancelUserWantInAlliance"] = _resp_alliance_cancelUserWantInAlliance;
            respMap["alliance.canceladdUsertoAlliance"] = _resp_alliance_canceladdUsertoAlliance;
            respMap["alliance.cancelagreeComeinAlliance"] = _resp_alliance_cancelagreeComeinAlliance;
            respMap["alliance.createAlliance"] = _resp_alliance_createAlliance;
            respMap["alliance.dropAllianceFriendshipRelation"] = _resp_alliance_dropAllianceFriendshipRelation;
            respMap["alliance.getAllianceFriendshipList"] = _resp_alliance_getAllianceFriendshipList;
            respMap["alliance.getAllianceWanted"] = _resp_alliance_getAllianceWanted;
            respMap["alliance.getPowerFromAlliance"] = _resp_alliance_getPowerFromAlliance;
            respMap["alliance.isHasAlliance"] = _resp_alliance_isHasAlliance;
            respMap["alliance.kickOutMemberfromAlliance"] = _resp_alliance_kickOutMemberfromAlliance;
            respMap["alliance.leaderWantUserInAllianceList"] = _resp_alliance_leaderWantUserInAllianceList;
            respMap["alliance.messagesForAllianceMember"] = _resp_alliance_messagesForAllianceMember;
            respMap["alliance.rejectComeinAlliance"] = _resp_alliance_rejectComeinAlliance;
            respMap["alliance.resetTopPowerForAlliance"] = _resp_alliance_resetTopPowerForAlliance;
            respMap["alliance.resignForAlliance"] = _resp_alliance_resignForAlliance;
            respMap["alliance.sayByetoAlliance"] = _resp_alliance_sayByetoAlliance;
            respMap["alliance.setAllInfoForAlliance"] = _resp_alliance_setAllInfoForAlliance;
            respMap["alliance.setAllianceFriendship"] = _resp_alliance_setAllianceFriendship;
            respMap["alliance.setPowerForUserByAlliance"] = _resp_alliance_setPowerForUserByAlliance;
            respMap["alliance.userWantInAlliance"] = _resp_alliance_userWantInAlliance;
            respMap["army.callBackArmy"] = _resp_army_callBackArmy;
            respMap["army.cureInjuredTroop"] = _resp_army_cureInjuredTroop;
            respMap["army.disbandInjuredTroop"] = _resp_army_disbandInjuredTroop;
            respMap["army.exerciseArmy"] = _resp_army_exerciseArmy;
            respMap["army.getInjuredTroop"] = _resp_army_getInjuredTroop;
            respMap["army.getStayAllianceArmys"] = _resp_army_getStayAllianceArmys;
            respMap["army.getTroopParam"] = _resp_army_getTroopParam;
            respMap["army.newArmy"] = _resp_army_newArmy;
            respMap["army.setAllowAllianceArmy"] = _resp_army_setAllowAllianceArmy;
            respMap["army.setArmyGoOut"] = _resp_army_setArmyGoOut;
            respMap["castle.cancleBuildCommand"] = _resp_castle_cancleBuildCommand;
            respMap["castle.checkOutUpgrade"] = _resp_castle_checkOutUpgrade;
            respMap["castle.destructBuilding"] = _resp_castle_destructBuilding;
            respMap["castle.getAvailableBuildingBean"] = _resp_castle_getAvailableBuildingBean;
            respMap["castle.getAvailableBuildingListInside"] = _resp_castle_getAvailableBuildingListInside;
            respMap["castle.getAvailableBuildingListOutside"] = _resp_castle_getAvailableBuildingListOutside;
            respMap["castle.getCoinsNeed"] = _resp_castle_getCoinsNeed;
            respMap["castle.getDestructBuildBean"] = _resp_castle_getDestructBuildBean;
            respMap["castle.newBuilding"] = _resp_castle_newBuilding;
            respMap["castle.speedUpBuildCommand"] = _resp_castle_speedUpBuildCommand;
            respMap["castle.upgradeBuilding"] = _resp_castle_upgradeBuilding;
            respMap["castle.deleteCastleSign"] = _resp_castle_deleteCastleSign;
            respMap["castle.saveCastleSignList"] = _resp_castle_saveCastleSignList;
            respMap["city.advMoveCastle"] = _resp_city_advMoveCastle;
            respMap["city.constructCastle"] = _resp_city_constructCastle;
            respMap["city.getStoreList"] = _resp_city_getStoreList;
            respMap["city.giveupCastle"] = _resp_city_giveupCastle;
            respMap["city.modifyCastleName"] = _resp_city_modifyCastleName;
            respMap["city.modifyFlag"] = _resp_city_modifyFlag;
            respMap["city.modifyStorePercent"] = _resp_city_modifyStorePercent;
            respMap["city.modifyUserName"] = _resp_city_modifyUserName;
            respMap["city.moveCastle"] = _resp_city_moveCastle;
            respMap["city.setStopWarState"] = _resp_city_setStopWarState;
            respMap["common.allianceChat"] = _resp_common_allianceChat;
            respMap["common.changeUserFace"] = _resp_common_changeUserFace;
            respMap["common.channelChat"] = _resp_common_channelChat;
            respMap["common.createNewPlayer"] = _resp_common_createNewPlayer;
            respMap["common.deleteUserAndRestart"] = _resp_common_deleteUserAndRestart;
            respMap["common.getPackage"] = _resp_common_getPackage;
            respMap["common.getPackageList"] = _resp_common_getPackageList;
            respMap["common.getPlayerInfoByName"] = _resp_common_getPlayerInfoByName;
            respMap["common.mapCastle"] = _resp_common_mapCastle;
            respMap["common.mapInfo"] = _resp_common_mapInfo;
            respMap["common.mapInfoSimple"] = _resp_common_mapInfoSimple;
            respMap["common.privateChat"] = _resp_common_privateChat;
            respMap["common.worldChat"] = _resp_common_worldChat;
            respMap["common.zoneInfo"] = _resp_common_zoneInfo;
            respMap["field.getCastleFieldInfo"] = _resp_field_getCastleFieldInfo;
            respMap["field.getOtherFieldInfo"] = _resp_field_getOtherFieldInfo;
            respMap["field.giveUpField"] = _resp_field_giveUpField;
            respMap["fortifications.accTroopProduce"] = _resp_fortifications_accTroopProduce;
            respMap["fortifications.cancelFortificationProduce"] = _resp_fortifications_cancelFortificationProduce;
            respMap["fortifications.destructWallProtect"] = _resp_fortifications_destructWallProtect;
            respMap["fortifications.getFortificationsProduceList"] = _resp_fortifications_getFortificationsProduceList;
            respMap["fortifications.getProduceQueue"] = _resp_fortifications_getProduceQueue;
            respMap["fortifications.produceWallProtect"] = _resp_fortifications_produceWallProtect;
            respMap["friend.addBlock"] = _resp_friend_addBlock;
            respMap["friend.addFriend"] = _resp_friend_addFriend;
            respMap["friend.deleteBlock"] = _resp_friend_deleteBlock;
            respMap["friend.deleteFriend"] = _resp_friend_deleteFriend;
            respMap["friend.isBlockMailPlayer"] = _resp_friend_isBlockMailPlayer;
            respMap["gamemaster.addBuilding"] = _resp_gamemaster_addBuilding;
            respMap["gamemaster.addHero"] = _resp_gamemaster_addHero;
            respMap["gamemaster.addItems"] = _resp_gamemaster_addItems;
            respMap["gamemaster.removeBuilding"] = _resp_gamemaster_removeBuilding;
            respMap["gamemaster.removeHero"] = _resp_gamemaster_removeHero;
            respMap["gamemaster.removeItem"] = _resp_gamemaster_removeItem;
            respMap["gamemaster.setResources"] = _resp_gamemaster_setResources;
            respMap["gamemaster.setTechnology"] = _resp_gamemaster_setTechnology;
            respMap["hero.addPoint"] = _resp_hero_addPoint;
            respMap["hero.awardGold"] = _resp_hero_awardGold;
            respMap["hero.callBackHero"] = _resp_hero_callBackHero;
            respMap["hero.changeName"] = _resp_hero_changeName;
            respMap["hero.dischargeChief"] = _resp_hero_dischargeChief;
            respMap["hero.fireHero"] = _resp_hero_fireHero;
            respMap["hero.getHerosListFromTavern"] = _resp_hero_getHerosListFromTavern;
            respMap["hero.hireHero"] = _resp_hero_hireHero;
            respMap["hero.levelUp"] = _resp_hero_levelUp;
            respMap["hero.promoteToChief"] = _resp_hero_promoteToChief;
            respMap["hero.refreshHerosListFromTavern"] = _resp_hero_refreshHerosListFromTavern;
            respMap["hero.releaseHero"] = _resp_hero_releaseHero;
            respMap["hero.resetPoint"] = _resp_hero_resetPoint;
            respMap["hero.tryGetSeizedHero"] = _resp_hero_tryGetSeizedHero;
            respMap["hero.useItem"] = _resp_hero_useItem;
            respMap["interior.getResourceProduceData"] = _resp_interior_getResourceProduceData;
            respMap["interior.modifyCommenceRate"] = _resp_interior_modifyCommenceRate;
            respMap["interior.modifyTaxRate"] = _resp_interior_modifyTaxRate;
            respMap["interior.pacifyPeople"] = _resp_interior_pacifyPeople;
            respMap["interior.taxation"] = _resp_interior_taxation;
            respMap["mail.deleteMail"] = _resp_mail_deleteMail;
            respMap["mail.getAllTVMsg"] = _resp_mail_getAllTVMsg;
            respMap["mail.readMail"] = _resp_mail_readMail;
            respMap["mail.readOverMailList"] = _resp_mail_readOverMailList;
            respMap["mail.receiveMailList"] = _resp_mail_receiveMailList;
            respMap["mail.reportBug"] = _resp_mail_reportBug;
            respMap["mail.reportPlayer"] = _resp_mail_reportPlayer;
            respMap["mail.sendMail"] = _resp_mail_sendMail;
            respMap["quest.award"] = _resp_quest_award;
            respMap["quest.awardPacket"] = _resp_quest_awardPacket;
            respMap["quest.getQuestList"] = _resp_quest_getQuestList;
            respMap["quest.getQuestType"] = _resp_quest_getQuestType;
            respMap["rank.getAllianceRank"] = _resp_rank_getAllianceRank;
            respMap["rank.getCastleRank"] = _resp_rank_getCastleRank;
            respMap["rank.getHeroRank"] = _resp_rank_getHeroRank;
            respMap["rank.getPlayerRank"] = _resp_rank_getPlayerRank;
            respMap["report.deleteReport"] = _resp_report_deleteReport;
            respMap["report.markAsRead"] = _resp_report_markAsRead;
            respMap["report.readOverReport"] = _resp_report_readOverReport;
            respMap["report.receiveReportList"] = _resp_report_receiveReportList;
            respMap["shop.buy"] = _resp_shop_buy;
            respMap["shop.buyResource"] = _resp_shop_buyResource;
            respMap["shop.getBuyResourceInfo"] = _resp_shop_getBuyResourceInfo;
            respMap["shop.useCastleGoods"] = _resp_shop_useCastleGoods;
            respMap["shop.useGoods"] = _resp_shop_useGoods;
            respMap["stratagem.useStratagem"] = _resp_stratagem_useStratagem;
            respMap["tech.cancelResearch"] = _resp_tech_cancelResearch;
            respMap["tech.getCoinsNeed"] = _resp_tech_getCoinsNeed;
            respMap["tech.getResearchList"] = _resp_tech_getResearchList;
            respMap["tech.research"] = _resp_tech_research;
            respMap["tech.speedUpResearch"] = _resp_tech_speedUpResearch;
            respMap["trade.cancelTrade"] = _resp_trade_cancelTrade;
            respMap["trade.getMyTradeList"] = _resp_trade_getMyTradeList;
            respMap["trade.getTransingTradeList"] = _resp_trade_getTransingTradeList;
            respMap["trade.newTrade"] = _resp_trade_newTrade;
            respMap["trade.searchTrades"] = _resp_trade_searchTrades;
            respMap["trade.speedUpTrans"] = _resp_trade_speedUpTrans;
            respMap["troop.accTroopProduce"] = _resp_troop_accTroopProduce;
            respMap["troop.cancelTroopProduce"] = _resp_troop_cancelTroopProduce;
            respMap["troop.checkIdleBarrack"] = _resp_troop_checkIdleBarrack;
            respMap["troop.disbandTroop"] = _resp_troop_disbandTroop;
            respMap["troop.getProduceQueue"] = _resp_troop_getProduceQueue;
            respMap["troop.getTroopProduceList"] = _resp_troop_getTroopProduceList;
            respMap["troop.produceTroop"] = _resp_troop_produceTroop;
            respMap["server.AllianceChatMsg"] = _resp_AllianceChatMsg;
            respMap["server.BuildComplate"] = _resp_BuildComplate;
            respMap["server.CastleFieldUpdate"] = _resp_CastleFieldUpdate;
            respMap["server.CastleUpdate"] = _resp_CastleUpdate;
            respMap["server.ChannelChatMsg"] = _resp_ChannelChatMsg;
            respMap["server.ConnectionLost"] = _resp_ConnectionLost;
            respMap["server.EnemyArmysUpdate"] = _resp_EnemyArmysUpdate;
            respMap["server.FortificationsUpdate"] = _resp_FortificationsUpdate;
            respMap["server.FriendArmysUpdate"] = _resp_FriendArmysUpdate;
            respMap["server.HeroUpdate"] = _resp_HeroUpdate;
            respMap["server.InjuredTroopUpdate"] = _resp_InjuredTroopUpdate;
            respMap["server.ItemBuff"] = _resp_ItemBuff;
            respMap["server.ItemUpdate"] = _resp_ItemUpdate;
            respMap["server.KickedOut"] = _resp_KickedOut;
            respMap["server.LoginResponse"] = _resp_LoginResponse;
            respMap["server.NewFinishedQuest"] = _resp_NewFinishedQuest;
            respMap["server.NewMail"] = _resp_NewMail;
            respMap["server.NewReport"] = _resp_NewReport;
            respMap["server.PackageList"] = _resp_PackageList;
            respMap["server.PlayerBuffUpdate"] = _resp_PlayerBuffUpdate;
            respMap["server.PlayerInfoUpdate"] = _resp_PlayerInfoUpdate;
            respMap["server.PrivateChatMessage"] = _resp_PrivateChatMessage;
            respMap["server.QuestFinished"] = _resp_QuestFinished;
            respMap["server.RegisterResponse"] = _resp_RegisterResponse;
            respMap["server.ResearchCompleteUpdate"] = _resp_ResearchCompleteUpdate;
            respMap["server.ResourceUpdate"] = _resp_ResourceUpdate;
            respMap["server.SelfArmysUpdate"] = _resp_SelfArmysUpdate;
            respMap["server.StrategyBuff"] = _resp_StrategyBuff;
            respMap["server.SystemInfoMsg"] = _resp_SystemInfoMsg;
            respMap["server.TradesUpdate"] = _resp_TradesUpdate;
            respMap["server.TransingTradeUpdate"] = _resp_TransingTradeUpdate;
            respMap["server.TroopUpdate"] = _resp_TroopUpdate;
            respMap["server.WorldChatMsg"] = _resp_WorldChatMsg;
            return;
        }// end function

        private function _resp_mail_receiveMailList(param1:Object) : void
        {
            var _loc_2:* = new MailListResponse("mail.receiveMailList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getMailCommands()._receiveMailList_callback != null)
            {
                actionFactory.getMailCommands()._receiveMailList_callback.apply(this, [_loc_2]);
                actionFactory.getMailCommands()._receiveMailList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_army_cureInjuredTroop(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("army.cureInjuredTroop", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getArmyCommands()._cureInjuredTroop_callback != null)
            {
                actionFactory.getArmyCommands()._cureInjuredTroop_callback.apply(this, [_loc_2]);
                actionFactory.getArmyCommands()._cureInjuredTroop_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_hero_tryGetSeizedHero(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("hero.tryGetSeizedHero", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getHeroCommand()._tryGetSeizedHero_callback != null)
            {
                actionFactory.getHeroCommand()._tryGetSeizedHero_callback.apply(this, [_loc_2]);
                actionFactory.getHeroCommand()._tryGetSeizedHero_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_castle_getAvailableBuildingBean(param1:Object) : void
        {
            var _loc_2:* = new AvailableBuilingListResponse("castle.getAvailableBuildingBean", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCastleCommands()._getAvailableBuildingBean_callback != null)
            {
                actionFactory.getCastleCommands()._getAvailableBuildingBean_callback.apply(this, [_loc_2]);
                actionFactory.getCastleCommands()._getAvailableBuildingBean_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_shop_useCastleGoods(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("shop.useCastleGoods", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getShopCommands()._useCastleGoods_callback != null)
            {
                actionFactory.getShopCommands()._useCastleGoods_callback.apply(this, [_loc_2]);
                actionFactory.getShopCommands()._useCastleGoods_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_troop_getProduceQueue(param1:Object) : void
        {
            var _loc_2:* = new ProduceQueueResponse("troop.getProduceQueue", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTroopCommands()._getProduceQueue_callback != null)
            {
                actionFactory.getTroopCommands()._getProduceQueue_callback.apply(this, [_loc_2]);
                actionFactory.getTroopCommands()._getProduceQueue_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_common_getPackageList(param1:Object) : void
        {
            var _loc_2:* = new GetPackageListResponse("common.getPackageList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCommonCommands()._getPackageList_callback != null)
            {
                actionFactory.getCommonCommands()._getPackageList_callback.apply(this, [_loc_2]);
                actionFactory.getCommonCommands()._getPackageList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_StrategyBuff(param1:Object) : void
        {
            var _loc_2:* = new StrategyBuff("server.StrategyBuff", param1);
            trace(_loc_2.toDebugString());
            if (onStrategyBuff != null)
            {
                onStrategyBuff.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_castle_getAvailableBuildingListInside(param1:Object) : void
        {
            var _loc_2:* = new AvailableBuilingListResponse("castle.getAvailableBuildingListInside", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCastleCommands()._getAvailableBuildingListInside_callback != null)
            {
                actionFactory.getCastleCommands()._getAvailableBuildingListInside_callback.apply(this, [_loc_2]);
                actionFactory.getCastleCommands()._getAvailableBuildingListInside_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_hero_hireHero(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("hero.hireHero", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getHeroCommand()._hireHero_callback != null)
            {
                actionFactory.getHeroCommand()._hireHero_callback.apply(this, [_loc_2]);
                actionFactory.getHeroCommand()._hireHero_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_getAllianceMembers(param1:Object) : void
        {
            var _loc_2:* = new AllianceMembersResponse("alliance.getAllianceMembers", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceCommands()._getAllianceMembers_callback != null)
            {
                actionFactory.getAllianceCommands()._getAllianceMembers_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceCommands()._getAllianceMembers_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_ResourceUpdate(param1:Object) : void
        {
            var _loc_2:* = new ResourceUpdate("server.ResourceUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onResourceUpdate != null)
            {
                onResourceUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_alliance_addUsertoAllianceList(param1:Object) : void
        {
            var _loc_2:* = new AllianceInviteBeanResponse("alliance.addUsertoAllianceList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._addUsertoAllianceList_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._addUsertoAllianceList_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._addUsertoAllianceList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_getAllianceFriendshipList(param1:Object) : void
        {
            var _loc_2:* = new AllianceFriendshipResponse("alliance.getAllianceFriendshipList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._getAllianceFriendshipList_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._getAllianceFriendshipList_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._getAllianceFriendshipList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_hero_changeName(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("hero.changeName", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getHeroCommand()._changeName_callback != null)
            {
                actionFactory.getHeroCommand()._changeName_callback.apply(this, [_loc_2]);
                actionFactory.getHeroCommand()._changeName_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_agreeComeinAllianceByLeader(param1:Object) : void
        {
            var _loc_2:* = new AllianceManagementResponse("alliance.agreeComeinAllianceByLeader", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByLeader_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByLeader_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByLeader_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_common_channelChat(param1:Object) : void
        {
            var _loc_2:* = new ChatResponse("common.channelChat", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCommonCommands()._channelChat_callback != null)
            {
                actionFactory.getCommonCommands()._channelChat_callback.apply(this, [_loc_2]);
                actionFactory.getCommonCommands()._channelChat_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_report_readOverReport(param1:Object) : void
        {
            var _loc_2:* = new ReportResponse("report.readOverReport", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getReportCommands()._readOverReport_callback != null)
            {
                actionFactory.getReportCommands()._readOverReport_callback.apply(this, [_loc_2]);
                actionFactory.getReportCommands()._readOverReport_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_setAllInfoForAlliance(param1:Object) : void
        {
            var _loc_2:* = new AllianceManagementResponse("alliance.setAllInfoForAlliance", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._setAllInfoForAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._setAllInfoForAlliance_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._setAllInfoForAlliance_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_common_createNewPlayer(param1:Object) : void
        {
            var _loc_2:* = new CreatePlayerResponse("common.createNewPlayer", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCommonCommands()._createNewPlayer_callback != null)
            {
                actionFactory.getCommonCommands()._createNewPlayer_callback.apply(this, [_loc_2]);
                actionFactory.getCommonCommands()._createNewPlayer_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_common_getPlayerInfoByName(param1:Object) : void
        {
            var _loc_2:* = new PlayerInfoResponse("common.getPlayerInfoByName", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCommonCommands()._getPlayerInfoByName_callback != null)
            {
                actionFactory.getCommonCommands()._getPlayerInfoByName_callback.apply(this, [_loc_2]);
                actionFactory.getCommonCommands()._getPlayerInfoByName_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_getAllianceWanted(param1:Object) : void
        {
            var _loc_2:* = new WantedAllianceResponse("alliance.getAllianceWanted", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._getAllianceWanted_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._getAllianceWanted_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._getAllianceWanted_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_getAllianceArmyReport(param1:Object) : void
        {
            var _loc_2:* = new AllianceArmyResponse("alliance.getAllianceArmyReport", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceCommands()._getAllianceArmyReport_callback != null)
            {
                actionFactory.getAllianceCommands()._getAllianceArmyReport_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceCommands()._getAllianceArmyReport_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_interior_taxation(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("interior.taxation", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getInteriorCommands()._taxation_callback != null)
            {
                actionFactory.getInteriorCommands()._taxation_callback.apply(this, [_loc_2]);
                actionFactory.getInteriorCommands()._taxation_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_common_worldChat(param1:Object) : void
        {
            var _loc_2:* = new ChatResponse("common.worldChat", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCommonCommands()._worldChat_callback != null)
            {
                actionFactory.getCommonCommands()._worldChat_callback.apply(this, [_loc_2]);
                actionFactory.getCommonCommands()._worldChat_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_fortifications_cancelFortificationProduce(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("fortifications.cancelFortificationProduce", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getFortificationsCommands()._cancelFortificationProduce_callback != null)
            {
                actionFactory.getFortificationsCommands()._cancelFortificationProduce_callback.apply(this, [_loc_2]);
                actionFactory.getFortificationsCommands()._cancelFortificationProduce_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_InjuredTroopUpdate(param1:Object) : void
        {
            var _loc_2:* = new InjuredTroopUpdate("server.InjuredTroopUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onInjuredTroopUpdate != null)
            {
                onInjuredTroopUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_army_newArmy(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("army.newArmy", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getArmyCommands()._newArmy_callback != null)
            {
                actionFactory.getArmyCommands()._newArmy_callback.apply(this, [_loc_2]);
                actionFactory.getArmyCommands()._newArmy_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_quest_getQuestType(param1:Object) : void
        {
            var _loc_2:* = new QuestTypeResponse("quest.getQuestType", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getQuestCommands()._getQuestType_callback != null)
            {
                actionFactory.getQuestCommands()._getQuestType_callback.apply(this, [_loc_2]);
                actionFactory.getQuestCommands()._getQuestType_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_city_giveupCastle(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("city.giveupCastle", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCityCommands()._giveupCastle_callback != null)
            {
                actionFactory.getCityCommands()._giveupCastle_callback.apply(this, [_loc_2]);
                actionFactory.getCityCommands()._giveupCastle_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_interior_modifyTaxRate(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("interior.modifyTaxRate", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getInteriorCommands()._modifyTaxRate_callback != null)
            {
                actionFactory.getInteriorCommands()._modifyTaxRate_callback.apply(this, [_loc_2]);
                actionFactory.getInteriorCommands()._modifyTaxRate_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_report_deleteReport(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("report.deleteReport", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getReportCommands()._deleteReport_callback != null)
            {
                actionFactory.getReportCommands()._deleteReport_callback.apply(this, [_loc_2]);
                actionFactory.getReportCommands()._deleteReport_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_dropAllianceFriendshipRelation(param1:Object) : void
        {
            var _loc_2:* = new AllianceFriendshipResponse("alliance.dropAllianceFriendshipRelation", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._dropAllianceFriendshipRelation_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._dropAllianceFriendshipRelation_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._dropAllianceFriendshipRelation_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_castle_checkOutUpgrade(param1:Object) : void
        {
            var _loc_2:* = new CheckOutBuildingResponse("castle.checkOutUpgrade", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCastleCommands()._checkOutUpgrade_callback != null)
            {
                actionFactory.getCastleCommands()._checkOutUpgrade_callback.apply(this, [_loc_2]);
                actionFactory.getCastleCommands()._checkOutUpgrade_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_ChannelChatMsg(param1:Object) : void
        {
            var _loc_2:* = new ChannelChatMsg("server.ChannelChatMsg", param1);
            trace(_loc_2.toDebugString());
            if (onChannelChatMsg != null)
            {
                onChannelChatMsg.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_hero_fireHero(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("hero.fireHero", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getHeroCommand()._fireHero_callback != null)
            {
                actionFactory.getHeroCommand()._fireHero_callback.apply(this, [_loc_2]);
                actionFactory.getHeroCommand()._fireHero_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_addUsertoAlliance(param1:Object) : void
        {
            var _loc_2:* = new AllianceManagementResponse("alliance.addUsertoAlliance", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._addUsertoAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._addUsertoAlliance_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._addUsertoAlliance_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_getPowerFromAlliance(param1:Object) : void
        {
            var _loc_2:* = new AlliancePowerLevelResponse("alliance.getPowerFromAlliance", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._getPowerFromAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._getPowerFromAlliance_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._getPowerFromAlliance_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_kickOutMemberfromAlliance(param1:Object) : void
        {
            var _loc_2:* = new AllianceManagementResponse("alliance.kickOutMemberfromAlliance", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._kickOutMemberfromAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._kickOutMemberfromAlliance_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._kickOutMemberfromAlliance_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_PlayerBuffUpdate(param1:Object) : void
        {
            var _loc_2:* = new PlayerBuffUpdate("server.PlayerBuffUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onPlayerBuffUpdate != null)
            {
                onPlayerBuffUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_report_markAsRead(param1:Object) : void
        {
            var _loc_2:* = new ReportResponse("report.markAsRead", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getReportCommands()._markAsRead_callback != null)
            {
                actionFactory.getReportCommands()._markAsRead_callback.apply(this, [_loc_2]);
                actionFactory.getReportCommands()._markAsRead_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_city_constructCastle(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("city.constructCastle", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCityCommands()._constructCastle_callback != null)
            {
                actionFactory.getCityCommands()._constructCastle_callback.apply(this, [_loc_2]);
                actionFactory.getCityCommands()._constructCastle_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_interior_getResourceProduceData(param1:Object) : void
        {
            var _loc_2:* = new ResourceProduceDataResponse("interior.getResourceProduceData", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getInteriorCommands()._getResourceProduceData_callback != null)
            {
                actionFactory.getInteriorCommands()._getResourceProduceData_callback.apply(this, [_loc_2]);
                actionFactory.getInteriorCommands()._getResourceProduceData_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_messagesForAllianceMember(param1:Object) : void
        {
            var _loc_2:* = new AllianceManagementResponse("alliance.messagesForAllianceMember", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._messagesForAllianceMember_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._messagesForAllianceMember_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._messagesForAllianceMember_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_gamemaster_removeItem(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("gamemaster.removeItem", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getModifyCommands()._removeItem_callback != null)
            {
                actionFactory.getModifyCommands()._removeItem_callback.apply(this, [_loc_2]);
                actionFactory.getModifyCommands()._removeItem_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_common_allianceChat(param1:Object) : void
        {
            var _loc_2:* = new ChatResponse("common.allianceChat", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCommonCommands()._allianceChat_callback != null)
            {
                actionFactory.getCommonCommands()._allianceChat_callback.apply(this, [_loc_2]);
                actionFactory.getCommonCommands()._allianceChat_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_shop_buyResource(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("shop.buyResource", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getShopCommands()._buyResource_callback != null)
            {
                actionFactory.getShopCommands()._buyResource_callback.apply(this, [_loc_2]);
                actionFactory.getShopCommands()._buyResource_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_SelfArmysUpdate(param1:Object) : void
        {
            var _loc_2:* = new SelfArmysUpdate("server.SelfArmysUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onSelfArmysUpdate != null)
            {
                onSelfArmysUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_mail_readMail(param1:Object) : void
        {
            var _loc_2:* = new MailResponse("mail.readMail", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getMailCommands()._readMail_callback != null)
            {
                actionFactory.getMailCommands()._readMail_callback.apply(this, [_loc_2]);
                actionFactory.getMailCommands()._readMail_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_fortifications_accTroopProduce(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("fortifications.accTroopProduce", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getFortificationsCommands()._accTroopProduce_callback != null)
            {
                actionFactory.getFortificationsCommands()._accTroopProduce_callback.apply(this, [_loc_2]);
                actionFactory.getFortificationsCommands()._accTroopProduce_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_report_receiveReportList(param1:Object) : void
        {
            var _loc_2:* = new ReportListResponse("report.receiveReportList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getReportCommands()._receiveReportList_callback != null)
            {
                actionFactory.getReportCommands()._receiveReportList_callback.apply(this, [_loc_2]);
                actionFactory.getReportCommands()._receiveReportList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_gamemaster_setTechnology(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("gamemaster.setTechnology", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getModifyCommands()._setTechnology_callback != null)
            {
                actionFactory.getModifyCommands()._setTechnology_callback.apply(this, [_loc_2]);
                actionFactory.getModifyCommands()._setTechnology_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_trade_getMyTradeList(param1:Object) : void
        {
            var _loc_2:* = new TradeListResponse("trade.getMyTradeList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTradeCommands()._getMyTradeList_callback != null)
            {
                actionFactory.getTradeCommands()._getMyTradeList_callback.apply(this, [_loc_2]);
                actionFactory.getTradeCommands()._getMyTradeList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_troop_cancelTroopProduce(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("troop.cancelTroopProduce", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTroopCommands()._cancelTroopProduce_callback != null)
            {
                actionFactory.getTroopCommands()._cancelTroopProduce_callback.apply(this, [_loc_2]);
                actionFactory.getTroopCommands()._cancelTroopProduce_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_PlayerInfoUpdate(param1:Object) : void
        {
            var _loc_2:* = new PlayerInfoUpdate("server.PlayerInfoUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onPlayerInfoUpdate != null)
            {
                onPlayerInfoUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        public function dispatch(param1:String, param2:Object) : void
        {
            var _loc_3:* = this.respMap[param1] as Function;
            if (_loc_3 != null)
            {
                _loc_3.apply(this, [param2]);
            }
            else
            {
                trace("ResponseDispatcher.dispatch: [" + param1 + "] not found!");
            }// end else if
            return;
        }// end function

        private function _resp_hero_addPoint(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("hero.addPoint", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getHeroCommand()._addPoint_callback != null)
            {
                actionFactory.getHeroCommand()._addPoint_callback.apply(this, [_loc_2]);
                actionFactory.getHeroCommand()._addPoint_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_sayByetoAlliance(param1:Object) : void
        {
            var _loc_2:* = new AllianceManagementResponse("alliance.sayByetoAlliance", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._sayByetoAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._sayByetoAlliance_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._sayByetoAlliance_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_agreeComeinAllianceList(param1:Object) : void
        {
            var _loc_2:* = new AllianceUserAddResponse("alliance.agreeComeinAllianceList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._agreeComeinAllianceList_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._agreeComeinAllianceList_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._agreeComeinAllianceList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_gamemaster_removeBuilding(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("gamemaster.removeBuilding", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getModifyCommands()._removeBuilding_callback != null)
            {
                actionFactory.getModifyCommands()._removeBuilding_callback.apply(this, [_loc_2]);
                actionFactory.getModifyCommands()._removeBuilding_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_hero_callBackHero(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("hero.callBackHero", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getHeroCommand()._callBackHero_callback != null)
            {
                actionFactory.getHeroCommand()._callBackHero_callback.apply(this, [_loc_2]);
                actionFactory.getHeroCommand()._callBackHero_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_interior_modifyCommenceRate(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("interior.modifyCommenceRate", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getInteriorCommands()._modifyCommenceRate_callback != null)
            {
                actionFactory.getInteriorCommands()._modifyCommenceRate_callback.apply(this, [_loc_2]);
                actionFactory.getInteriorCommands()._modifyCommenceRate_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_friend_deleteFriend(param1:Object) : void
        {
            var _loc_2:* = new FriendResponse("friend.deleteFriend", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getFriendCommands()._deleteFriend_callback != null)
            {
                actionFactory.getFriendCommands()._deleteFriend_callback.apply(this, [_loc_2]);
                actionFactory.getFriendCommands()._deleteFriend_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_CastleFieldUpdate(param1:Object) : void
        {
            var _loc_2:* = new CastleFieldUpdate("server.CastleFieldUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onCastleFieldUpdate != null)
            {
                onCastleFieldUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_mail_readOverMailList(param1:Object) : void
        {
            var _loc_2:* = new MailResponse("mail.readOverMailList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getMailCommands()._readOverMailList_callback != null)
            {
                actionFactory.getMailCommands()._readOverMailList_callback.apply(this, [_loc_2]);
                actionFactory.getMailCommands()._readOverMailList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_getAllianceEventList(param1:Object) : void
        {
            var _loc_2:* = new AllianceEventListResponse("alliance.getAllianceEventList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceCommands()._getAllianceEventList_callback != null)
            {
                actionFactory.getAllianceCommands()._getAllianceEventList_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceCommands()._getAllianceEventList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_troop_getTroopProduceList(param1:Object) : void
        {
            var _loc_2:* = new TroopProduceListResponse("troop.getTroopProduceList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTroopCommands()._getTroopProduceList_callback != null)
            {
                actionFactory.getTroopCommands()._getTroopProduceList_callback.apply(this, [_loc_2]);
                actionFactory.getTroopCommands()._getTroopProduceList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_troop_disbandTroop(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("troop.disbandTroop", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTroopCommands()._disbandTroop_callback != null)
            {
                actionFactory.getTroopCommands()._disbandTroop_callback.apply(this, [_loc_2]);
                actionFactory.getTroopCommands()._disbandTroop_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_tech_getCoinsNeed(param1:Object) : void
        {
            var _loc_2:* = new CoinsNeedResponse("tech.getCoinsNeed", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTechCommand()._getCoinsNeed_callback != null)
            {
                actionFactory.getTechCommand()._getCoinsNeed_callback.apply(this, [_loc_2]);
                actionFactory.getTechCommand()._getCoinsNeed_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_rank_getHeroRank(param1:Object) : void
        {
            var _loc_2:* = new RankHeroResponse("rank.getHeroRank", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getRankCommands()._getHeroRank_callback != null)
            {
                actionFactory.getRankCommands()._getHeroRank_callback.apply(this, [_loc_2]);
                actionFactory.getRankCommands()._getHeroRank_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_common_zoneInfo(param1:Object) : void
        {
            var _loc_2:* = new ZoneInfoResponse("common.zoneInfo", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCommonCommands()._zoneInfo_callback != null)
            {
                actionFactory.getCommonCommands()._zoneInfo_callback.apply(this, [_loc_2]);
                actionFactory.getCommonCommands()._zoneInfo_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_army_getTroopParam(param1:Object) : void
        {
            var _loc_2:* = new TroopParamResponse("army.getTroopParam", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getArmyCommands()._getTroopParam_callback != null)
            {
                actionFactory.getArmyCommands()._getTroopParam_callback.apply(this, [_loc_2]);
                actionFactory.getArmyCommands()._getTroopParam_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_city_modifyCastleName(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("city.modifyCastleName", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCityCommands()._modifyCastleName_callback != null)
            {
                actionFactory.getCityCommands()._modifyCastleName_callback.apply(this, [_loc_2]);
                actionFactory.getCityCommands()._modifyCastleName_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_common_privateChat(param1:Object) : void
        {
            var _loc_2:* = new ChatResponse("common.privateChat", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCommonCommands()._privateChat_callback != null)
            {
                actionFactory.getCommonCommands()._privateChat_callback.apply(this, [_loc_2]);
                actionFactory.getCommonCommands()._privateChat_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_common_mapInfoSimple(param1:Object) : void
        {
            var _loc_2:* = new MapInfoSimpleResponse("common.mapInfoSimple", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCommonCommands()._mapInfoSimple_callback != null)
            {
                actionFactory.getCommonCommands()._mapInfoSimple_callback.apply(this, [_loc_2]);
                actionFactory.getCommonCommands()._mapInfoSimple_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_createAlliance(param1:Object) : void
        {
            var _loc_2:* = new AllianceManagementResponse("alliance.createAlliance", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._createAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._createAlliance_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._createAlliance_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_WorldChatMsg(param1:Object) : void
        {
            var _loc_2:* = new WorldChatMsg("server.WorldChatMsg", param1);
            trace(_loc_2.toDebugString());
            if (onWorldChatMsg != null)
            {
                onWorldChatMsg.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_alliance_userWantInAlliance(param1:Object) : void
        {
            var _loc_2:* = new AllianceManagementResponse("alliance.userWantInAlliance", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._userWantInAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._userWantInAlliance_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._userWantInAlliance_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_fortifications_getProduceQueue(param1:Object) : void
        {
            var _loc_2:* = new ProduceQueueResponse("fortifications.getProduceQueue", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getFortificationsCommands()._getProduceQueue_callback != null)
            {
                actionFactory.getFortificationsCommands()._getProduceQueue_callback.apply(this, [_loc_2]);
                actionFactory.getFortificationsCommands()._getProduceQueue_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_ConnectionLost(param1:Object) : void
        {
            var _loc_2:* = new ConnectionLost("server.ConnectionLost", param1);
            trace(_loc_2.toDebugString());
            if (onConnectionLost != null)
            {
                onConnectionLost.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_fortifications_produceWallProtect(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("fortifications.produceWallProtect", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getFortificationsCommands()._produceWallProtect_callback != null)
            {
                actionFactory.getFortificationsCommands()._produceWallProtect_callback.apply(this, [_loc_2]);
                actionFactory.getFortificationsCommands()._produceWallProtect_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_tech_speedUpResearch(param1:Object) : void
        {
            var _loc_2:* = new ResearchResponse("tech.speedUpResearch", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTechCommand()._speedUpResearch_callback != null)
            {
                actionFactory.getTechCommand()._speedUpResearch_callback.apply(this, [_loc_2]);
                actionFactory.getTechCommand()._speedUpResearch_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_stratagem_useStratagem(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("stratagem.useStratagem", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getStratagemCommands()._useStratagem_callback != null)
            {
                actionFactory.getStratagemCommands()._useStratagem_callback.apply(this, [_loc_2]);
                actionFactory.getStratagemCommands()._useStratagem_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_city_setStopWarState(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("city.setStopWarState", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCityCommands()._setStopWarState_callback != null)
            {
                actionFactory.getCityCommands()._setStopWarState_callback.apply(this, [_loc_2]);
                actionFactory.getCityCommands()._setStopWarState_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_PackageList(param1:Object) : void
        {
            var _loc_2:* = new PackageList("server.PackageList", param1);
            trace(_loc_2.toDebugString());
            if (onPackageList != null)
            {
                onPackageList.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_alliance_isHasAlliance(param1:Object) : void
        {
            var _loc_2:* = new HasAllianceResponse("alliance.isHasAlliance", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._isHasAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._isHasAlliance_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._isHasAlliance_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_cancelUserWantInAlliance(param1:Object) : void
        {
            var _loc_2:* = new AllianceManagementResponse("alliance.cancelUserWantInAlliance", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._cancelUserWantInAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._cancelUserWantInAlliance_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._cancelUserWantInAlliance_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_rank_getAllianceRank(param1:Object) : void
        {
            var _loc_2:* = new RankAllianceResponse("rank.getAllianceRank", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getRankCommands()._getAllianceRank_callback != null)
            {
                actionFactory.getRankCommands()._getAllianceRank_callback.apply(this, [_loc_2]);
                actionFactory.getRankCommands()._getAllianceRank_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_TradesUpdate(param1:Object) : void
        {
            var _loc_2:* = new TradesUpdate("server.TradesUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onTradesUpdate != null)
            {
                onTradesUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_interior_pacifyPeople(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("interior.pacifyPeople", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getInteriorCommands()._pacifyPeople_callback != null)
            {
                actionFactory.getInteriorCommands()._pacifyPeople_callback.apply(this, [_loc_2]);
                actionFactory.getInteriorCommands()._pacifyPeople_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_field_getOtherFieldInfo(param1:Object) : void
        {
            var _loc_2:* = new OtherFieldInfoResponse("field.getOtherFieldInfo", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getFieldCommand()._getOtherFieldInfo_callback != null)
            {
                actionFactory.getFieldCommand()._getOtherFieldInfo_callback.apply(this, [_loc_2]);
                actionFactory.getFieldCommand()._getOtherFieldInfo_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_city_advMoveCastle(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("city.advMoveCastle", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCityCommands()._advMoveCastle_callback != null)
            {
                actionFactory.getCityCommands()._advMoveCastle_callback.apply(this, [_loc_2]);
                actionFactory.getCityCommands()._advMoveCastle_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_resetTopPowerForAlliance(param1:Object) : void
        {
            var _loc_2:* = new AllianceManagementResponse("alliance.resetTopPowerForAlliance", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._resetTopPowerForAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._resetTopPowerForAlliance_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._resetTopPowerForAlliance_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_castle_getDestructBuildBean(param1:Object) : void
        {
            var _loc_2:* = new AvailableBuilingListResponse("castle.getDestructBuildBean", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCastleCommands()._getDestructBuildBean_callback != null)
            {
                actionFactory.getCastleCommands()._getDestructBuildBean_callback.apply(this, [_loc_2]);
                actionFactory.getCastleCommands()._getDestructBuildBean_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_setAllianceFriendship(param1:Object) : void
        {
            var _loc_2:* = new AllianceManagementResponse("alliance.setAllianceFriendship", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._setAllianceFriendship_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._setAllianceFriendship_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._setAllianceFriendship_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_TransingTradeUpdate(param1:Object) : void
        {
            var _loc_2:* = new TransingTradeUpdate("server.TransingTradeUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onTransingTradeUpdate != null)
            {
                onTransingTradeUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_alliance_setPowerForUserByAlliance(param1:Object) : void
        {
            var _loc_2:* = new AllianceManagementResponse("alliance.setPowerForUserByAlliance", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._setPowerForUserByAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._setPowerForUserByAlliance_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._setPowerForUserByAlliance_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_castle_getAvailableBuildingListOutside(param1:Object) : void
        {
            var _loc_2:* = new AvailableBuilingListResponse("castle.getAvailableBuildingListOutside", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCastleCommands()._getAvailableBuildingListOutside_callback != null)
            {
                actionFactory.getCastleCommands()._getAvailableBuildingListOutside_callback.apply(this, [_loc_2]);
                actionFactory.getCastleCommands()._getAvailableBuildingListOutside_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_city_modifyFlag(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("city.modifyFlag", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCityCommands()._modifyFlag_callback != null)
            {
                actionFactory.getCityCommands()._modifyFlag_callback.apply(this, [_loc_2]);
                actionFactory.getCityCommands()._modifyFlag_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_TroopUpdate(param1:Object) : void
        {
            var _loc_2:* = new TroopUpdate("server.TroopUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onTroopUpdate != null)
            {
                onTroopUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_castle_saveCastleSignList(param1:Object) : void
        {
            var _loc_2:* = new CastleSignResponse("castle.saveCastleSignList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCastleSignCommand()._saveCastleSignList_callback != null)
            {
                actionFactory.getCastleSignCommand()._saveCastleSignList_callback.apply(this, [_loc_2]);
                actionFactory.getCastleSignCommand()._saveCastleSignList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_friend_deleteBlock(param1:Object) : void
        {
            var _loc_2:* = new FriendResponse("friend.deleteBlock", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getFriendCommands()._deleteBlock_callback != null)
            {
                actionFactory.getFriendCommands()._deleteBlock_callback.apply(this, [_loc_2]);
                actionFactory.getFriendCommands()._deleteBlock_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_BuildComplate(param1:Object) : void
        {
            var _loc_2:* = new BuildComplate("server.BuildComplate", param1);
            trace(_loc_2.toDebugString());
            if (onBuildComplate != null)
            {
                onBuildComplate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_alliance_resignForAlliance(param1:Object) : void
        {
            var _loc_2:* = new AllianceManagementResponse("alliance.resignForAlliance", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._resignForAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._resignForAlliance_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._resignForAlliance_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_cancelagreeComeinAlliance(param1:Object) : void
        {
            var _loc_2:* = new AllianceUserAddResponse("alliance.cancelagreeComeinAlliance", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._cancelagreeComeinAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._cancelagreeComeinAlliance_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._cancelagreeComeinAlliance_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_SystemInfoMsg(param1:Object) : void
        {
            var _loc_2:* = new SystemInfoMsg("server.SystemInfoMsg", param1);
            trace(_loc_2.toDebugString());
            if (onSystemInfoMsg != null)
            {
                onSystemInfoMsg.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_mail_getAllTVMsg(param1:Object) : void
        {
            var _loc_2:* = new TVResponse("mail.getAllTVMsg", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getMailCommands()._getAllTVMsg_callback != null)
            {
                actionFactory.getMailCommands()._getAllTVMsg_callback.apply(this, [_loc_2]);
                actionFactory.getMailCommands()._getAllTVMsg_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_trade_cancelTrade(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("trade.cancelTrade", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTradeCommands()._cancelTrade_callback != null)
            {
                actionFactory.getTradeCommands()._cancelTrade_callback.apply(this, [_loc_2]);
                actionFactory.getTradeCommands()._cancelTrade_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_trade_speedUpTrans(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("trade.speedUpTrans", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTradeCommands()._speedUpTrans_callback != null)
            {
                actionFactory.getTradeCommands()._speedUpTrans_callback.apply(this, [_loc_2]);
                actionFactory.getTradeCommands()._speedUpTrans_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_gamemaster_addBuilding(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("gamemaster.addBuilding", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getModifyCommands()._addBuilding_callback != null)
            {
                actionFactory.getModifyCommands()._addBuilding_callback.apply(this, [_loc_2]);
                actionFactory.getModifyCommands()._addBuilding_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_AllianceChatMsg(param1:Object) : void
        {
            var _loc_2:* = new AllianceChatMsg("server.AllianceChatMsg", param1);
            trace(_loc_2.toDebugString());
            if (onAllianceChatMsg != null)
            {
                onAllianceChatMsg.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_castle_speedUpBuildCommand(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("castle.speedUpBuildCommand", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCastleCommands()._speedUpBuildCommand_callback != null)
            {
                actionFactory.getCastleCommands()._speedUpBuildCommand_callback.apply(this, [_loc_2]);
                actionFactory.getCastleCommands()._speedUpBuildCommand_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_gamemaster_addItems(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("gamemaster.addItems", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getModifyCommands()._addItems_callback != null)
            {
                actionFactory.getModifyCommands()._addItems_callback.apply(this, [_loc_2]);
                actionFactory.getModifyCommands()._addItems_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_city_getStoreList(param1:Object) : void
        {
            var _loc_2:* = new StoreListResponse("city.getStoreList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCityCommands()._getStoreList_callback != null)
            {
                actionFactory.getCityCommands()._getStoreList_callback.apply(this, [_loc_2]);
                actionFactory.getCityCommands()._getStoreList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_common_deleteUserAndRestart(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("common.deleteUserAndRestart", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCommonCommands()._deleteUserAndRestart_callback != null)
            {
                actionFactory.getCommonCommands()._deleteUserAndRestart_callback.apply(this, [_loc_2]);
                actionFactory.getCommonCommands()._deleteUserAndRestart_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_canceladdUsertoAlliance(param1:Object) : void
        {
            var _loc_2:* = new AllianceInviteBeanResponse("alliance.canceladdUsertoAlliance", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._canceladdUsertoAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._canceladdUsertoAlliance_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._canceladdUsertoAlliance_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_mail_reportPlayer(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("mail.reportPlayer", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getMailCommands()._reportPlayer_callback != null)
            {
                actionFactory.getMailCommands()._reportPlayer_callback.apply(this, [_loc_2]);
                actionFactory.getMailCommands()._reportPlayer_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_HeroUpdate(param1:Object) : void
        {
            var _loc_2:* = new HeroUpdate("server.HeroUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onHeroUpdate != null)
            {
                onHeroUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_tech_getResearchList(param1:Object) : void
        {
            var _loc_2:* = new AvailableResearchListResponse("tech.getResearchList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTechCommand()._getResearchList_callback != null)
            {
                actionFactory.getTechCommand()._getResearchList_callback.apply(this, [_loc_2]);
                actionFactory.getTechCommand()._getResearchList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_quest_award(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("quest.award", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getQuestCommands()._award_callback != null)
            {
                actionFactory.getQuestCommands()._award_callback.apply(this, [_loc_2]);
                actionFactory.getQuestCommands()._award_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_army_setArmyGoOut(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("army.setArmyGoOut", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getArmyCommands()._setArmyGoOut_callback != null)
            {
                actionFactory.getArmyCommands()._setArmyGoOut_callback.apply(this, [_loc_2]);
                actionFactory.getArmyCommands()._setArmyGoOut_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_LoginResponse(param1:Object) : void
        {
            var _loc_2:* = new LoginResponse("server.LoginResponse", param1);
            trace(_loc_2.toDebugString());
            if (onLoginResponse != null)
            {
                onLoginResponse.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_castle_newBuilding(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("castle.newBuilding", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCastleCommands()._newBuilding_callback != null)
            {
                actionFactory.getCastleCommands()._newBuilding_callback.apply(this, [_loc_2]);
                actionFactory.getCastleCommands()._newBuilding_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_castle_upgradeBuilding(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("castle.upgradeBuilding", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCastleCommands()._upgradeBuilding_callback != null)
            {
                actionFactory.getCastleCommands()._upgradeBuilding_callback.apply(this, [_loc_2]);
                actionFactory.getCastleCommands()._upgradeBuilding_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_castle_destructBuilding(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("castle.destructBuilding", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCastleCommands()._destructBuilding_callback != null)
            {
                actionFactory.getCastleCommands()._destructBuilding_callback.apply(this, [_loc_2]);
                actionFactory.getCastleCommands()._destructBuilding_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_NewReport(param1:Object) : void
        {
            var _loc_2:* = new NewReport("server.NewReport", param1);
            trace(_loc_2.toDebugString());
            if (onNewReport != null)
            {
                onNewReport.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_shop_buy(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("shop.buy", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getShopCommands()._buy_callback != null)
            {
                actionFactory.getShopCommands()._buy_callback.apply(this, [_loc_2]);
                actionFactory.getShopCommands()._buy_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_common_getPackage(param1:Object) : void
        {
            var _loc_2:* = new GetPackageResponse("common.getPackage", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCommonCommands()._getPackage_callback != null)
            {
                actionFactory.getCommonCommands()._getPackage_callback.apply(this, [_loc_2]);
                actionFactory.getCommonCommands()._getPackage_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_hero_resetPoint(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("hero.resetPoint", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getHeroCommand()._resetPoint_callback != null)
            {
                actionFactory.getHeroCommand()._resetPoint_callback.apply(this, [_loc_2]);
                actionFactory.getHeroCommand()._resetPoint_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_fortifications_getFortificationsProduceList(param1:Object) : void
        {
            var _loc_2:* = new FortProduceListResponse("fortifications.getFortificationsProduceList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getFortificationsCommands()._getFortificationsProduceList_callback != null)
            {
                actionFactory.getFortificationsCommands()._getFortificationsProduceList_callback.apply(this, [_loc_2]);
                actionFactory.getFortificationsCommands()._getFortificationsProduceList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_castle_getCoinsNeed(param1:Object) : void
        {
            var _loc_2:* = new CoinsNeedResponse("castle.getCoinsNeed", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCastleCommands()._getCoinsNeed_callback != null)
            {
                actionFactory.getCastleCommands()._getCoinsNeed_callback.apply(this, [_loc_2]);
                actionFactory.getCastleCommands()._getCoinsNeed_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_friend_addBlock(param1:Object) : void
        {
            var _loc_2:* = new FriendResponse("friend.addBlock", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getFriendCommands()._addBlock_callback != null)
            {
                actionFactory.getFriendCommands()._addBlock_callback.apply(this, [_loc_2]);
                actionFactory.getFriendCommands()._addBlock_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_mail_sendMail(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("mail.sendMail", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getMailCommands()._sendMail_callback != null)
            {
                actionFactory.getMailCommands()._sendMail_callback.apply(this, [_loc_2]);
                actionFactory.getMailCommands()._sendMail_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_common_mapInfo(param1:Object) : void
        {
            var _loc_2:* = new MapInfoResponse("common.mapInfo", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCommonCommands()._mapInfo_callback != null)
            {
                actionFactory.getCommonCommands()._mapInfo_callback.apply(this, [_loc_2]);
                actionFactory.getCommonCommands()._mapInfo_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_army_exerciseArmy(param1:Object) : void
        {
            var _loc_2:* = new ArmyPracticeResponse("army.exerciseArmy", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getArmyCommands()._exerciseArmy_callback != null)
            {
                actionFactory.getArmyCommands()._exerciseArmy_callback.apply(this, [_loc_2]);
                actionFactory.getArmyCommands()._exerciseArmy_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_gamemaster_removeHero(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("gamemaster.removeHero", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getModifyCommands()._removeHero_callback != null)
            {
                actionFactory.getModifyCommands()._removeHero_callback.apply(this, [_loc_2]);
                actionFactory.getModifyCommands()._removeHero_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_field_getCastleFieldInfo(param1:Object) : void
        {
            var _loc_2:* = new CastleFieldInfoResponse("field.getCastleFieldInfo", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getFieldCommand()._getCastleFieldInfo_callback != null)
            {
                actionFactory.getFieldCommand()._getCastleFieldInfo_callback.apply(this, [_loc_2]);
                actionFactory.getFieldCommand()._getCastleFieldInfo_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_getMilitarySituationList(param1:Object) : void
        {
            var _loc_2:* = new MilitarySituationListResponse("alliance.getMilitarySituationList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceCommands()._getMilitarySituationList_callback != null)
            {
                actionFactory.getAllianceCommands()._getMilitarySituationList_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceCommands()._getMilitarySituationList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_getAllianceList(param1:Object) : void
        {
            var _loc_2:* = new AllianceListResponse("alliance.getAllianceList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceCommands()._getAllianceList_callback != null)
            {
                actionFactory.getAllianceCommands()._getAllianceList_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceCommands()._getAllianceList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_army_callBackArmy(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("army.callBackArmy", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getArmyCommands()._callBackArmy_callback != null)
            {
                actionFactory.getArmyCommands()._callBackArmy_callback.apply(this, [_loc_2]);
                actionFactory.getArmyCommands()._callBackArmy_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_tech_cancelResearch(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("tech.cancelResearch", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTechCommand()._cancelResearch_callback != null)
            {
                actionFactory.getTechCommand()._cancelResearch_callback.apply(this, [_loc_2]);
                actionFactory.getTechCommand()._cancelResearch_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_rejectComeinAlliance(param1:Object) : void
        {
            var _loc_2:* = new AllianceUserAddResponse("alliance.rejectComeinAlliance", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._rejectComeinAlliance_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._rejectComeinAlliance_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._rejectComeinAlliance_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_field_giveUpField(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("field.giveUpField", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getFieldCommand()._giveUpField_callback != null)
            {
                actionFactory.getFieldCommand()._giveUpField_callback.apply(this, [_loc_2]);
                actionFactory.getFieldCommand()._giveUpField_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_hero_releaseHero(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("hero.releaseHero", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getHeroCommand()._releaseHero_callback != null)
            {
                actionFactory.getHeroCommand()._releaseHero_callback.apply(this, [_loc_2]);
                actionFactory.getHeroCommand()._releaseHero_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_castle_cancleBuildCommand(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("castle.cancleBuildCommand", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCastleCommands()._cancleBuildCommand_callback != null)
            {
                actionFactory.getCastleCommands()._cancleBuildCommand_callback.apply(this, [_loc_2]);
                actionFactory.getCastleCommands()._cancleBuildCommand_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_gamemaster_addHero(param1:Object) : void
        {
            var _loc_2:* = new CreateHeroResponse("gamemaster.addHero", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getModifyCommands()._addHero_callback != null)
            {
                actionFactory.getModifyCommands()._addHero_callback.apply(this, [_loc_2]);
                actionFactory.getModifyCommands()._addHero_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_getAllianceInfo(param1:Object) : void
        {
            var _loc_2:* = new AllianceInfoResponse("alliance.getAllianceInfo", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceCommands()._getAllianceInfo_callback != null)
            {
                actionFactory.getAllianceCommands()._getAllianceInfo_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceCommands()._getAllianceInfo_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_ItemUpdate(param1:Object) : void
        {
            var _loc_2:* = new ItemUpdate("server.ItemUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onItemUpdate != null)
            {
                onItemUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_hero_useItem(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("hero.useItem", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getHeroCommand()._useItem_callback != null)
            {
                actionFactory.getHeroCommand()._useItem_callback.apply(this, [_loc_2]);
                actionFactory.getHeroCommand()._useItem_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_NewFinishedQuest(param1:Object) : void
        {
            var _loc_2:* = new NewFinishedQuest("server.NewFinishedQuest", param1);
            trace(_loc_2.toDebugString());
            if (onNewFinishedQuest != null)
            {
                onNewFinishedQuest.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_FortificationsUpdate(param1:Object) : void
        {
            var _loc_2:* = new FortificationsUpdate("server.FortificationsUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onFortificationsUpdate != null)
            {
                onFortificationsUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_friend_isBlockMailPlayer(param1:Object) : void
        {
            var _loc_2:* = new FriendResponse("friend.isBlockMailPlayer", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getFriendCommands()._isBlockMailPlayer_callback != null)
            {
                actionFactory.getFriendCommands()._isBlockMailPlayer_callback.apply(this, [_loc_2]);
                actionFactory.getFriendCommands()._isBlockMailPlayer_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_rank_getPlayerRank(param1:Object) : void
        {
            var _loc_2:* = new RankPlayerResponse("rank.getPlayerRank", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getRankCommands()._getPlayerRank_callback != null)
            {
                actionFactory.getRankCommands()._getPlayerRank_callback.apply(this, [_loc_2]);
                actionFactory.getRankCommands()._getPlayerRank_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_hero_levelUp(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("hero.levelUp", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getHeroCommand()._levelUp_callback != null)
            {
                actionFactory.getHeroCommand()._levelUp_callback.apply(this, [_loc_2]);
                actionFactory.getHeroCommand()._levelUp_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_city_modifyUserName(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("city.modifyUserName", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCityCommands()._modifyUserName_callback != null)
            {
                actionFactory.getCityCommands()._modifyUserName_callback.apply(this, [_loc_2]);
                actionFactory.getCityCommands()._modifyUserName_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_CastleUpdate(param1:Object) : void
        {
            var _loc_2:* = new CastleUpdate("server.CastleUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onCastleUpdate != null)
            {
                onCastleUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_tech_research(param1:Object) : void
        {
            var _loc_2:* = new ResearchResponse("tech.research", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTechCommand()._research_callback != null)
            {
                actionFactory.getTechCommand()._research_callback.apply(this, [_loc_2]);
                actionFactory.getTechCommand()._research_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_ResearchCompleteUpdate(param1:Object) : void
        {
            var _loc_2:* = new ResearchCompleteUpdate("server.ResearchCompleteUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onResearchCompleteUpdate != null)
            {
                onResearchCompleteUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_shop_getBuyResourceInfo(param1:Object) : void
        {
            var _loc_2:* = new BuyResourceInfoResponse("shop.getBuyResourceInfo", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getShopCommands()._getBuyResourceInfo_callback != null)
            {
                actionFactory.getShopCommands()._getBuyResourceInfo_callback.apply(this, [_loc_2]);
                actionFactory.getShopCommands()._getBuyResourceInfo_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_mail_reportBug(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("mail.reportBug", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getMailCommands()._reportBug_callback != null)
            {
                actionFactory.getMailCommands()._reportBug_callback.apply(this, [_loc_2]);
                actionFactory.getMailCommands()._reportBug_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_troop_checkIdleBarrack(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("troop.checkIdleBarrack", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTroopCommands()._checkIdleBarrack_callback != null)
            {
                actionFactory.getTroopCommands()._checkIdleBarrack_callback.apply(this, [_loc_2]);
                actionFactory.getTroopCommands()._checkIdleBarrack_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_shop_useGoods(param1:Object) : void
        {
            var _loc_2:* = new UseItemResultResponse("shop.useGoods", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getShopCommands()._useGoods_callback != null)
            {
                actionFactory.getShopCommands()._useGoods_callback.apply(this, [_loc_2]);
                actionFactory.getShopCommands()._useGoods_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_common_mapCastle(param1:Object) : void
        {
            var _loc_2:* = new MapCastleResponse("common.mapCastle", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCommonCommands()._mapCastle_callback != null)
            {
                actionFactory.getCommonCommands()._mapCastle_callback.apply(this, [_loc_2]);
                actionFactory.getCommonCommands()._mapCastle_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_hero_refreshHerosListFromTavern(param1:Object) : void
        {
            var _loc_2:* = new HeroListResponse("hero.refreshHerosListFromTavern", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getHeroCommand()._refreshHerosListFromTavern_callback != null)
            {
                actionFactory.getHeroCommand()._refreshHerosListFromTavern_callback.apply(this, [_loc_2]);
                actionFactory.getHeroCommand()._refreshHerosListFromTavern_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_RegisterResponse(param1:Object) : void
        {
            var _loc_2:* = new RegisterResponse("server.RegisterResponse", param1);
            trace(_loc_2.toDebugString());
            if (onRegisterResponse != null)
            {
                onRegisterResponse.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_alliance_agreeComeinAllianceByUser(param1:Object) : void
        {
            var _loc_2:* = new AllianceUserAddResponse("alliance.agreeComeinAllianceByUser", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByUser_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByUser_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._agreeComeinAllianceByUser_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_quest_getQuestList(param1:Object) : void
        {
            var _loc_2:* = new QuestListResponse("quest.getQuestList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getQuestCommands()._getQuestList_callback != null)
            {
                actionFactory.getQuestCommands()._getQuestList_callback.apply(this, [_loc_2]);
                actionFactory.getQuestCommands()._getQuestList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_FriendArmysUpdate(param1:Object) : void
        {
            var _loc_2:* = new FriendArmysUpdate("server.FriendArmysUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onFriendArmysUpdate != null)
            {
                onFriendArmysUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_PrivateChatMessage(param1:Object) : void
        {
            var _loc_2:* = new PrivateChatMessage("server.PrivateChatMessage", param1);
            trace(_loc_2.toDebugString());
            if (onPrivateChatMessage != null)
            {
                onPrivateChatMessage.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_ItemBuff(param1:Object) : void
        {
            var _loc_2:* = new ItemBuff("server.ItemBuff", param1);
            trace(_loc_2.toDebugString());
            if (onItemBuff != null)
            {
                onItemBuff.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_castle_deleteCastleSign(param1:Object) : void
        {
            var _loc_2:* = new CastleSignResponse("castle.deleteCastleSign", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCastleSignCommand()._deleteCastleSign_callback != null)
            {
                actionFactory.getCastleSignCommand()._deleteCastleSign_callback.apply(this, [_loc_2]);
                actionFactory.getCastleSignCommand()._deleteCastleSign_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_QuestFinished(param1:Object) : void
        {
            var _loc_2:* = new QuestFinished("server.QuestFinished", param1);
            trace(_loc_2.toDebugString());
            if (onQuestFinished != null)
            {
                onQuestFinished.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_trade_newTrade(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("trade.newTrade", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTradeCommands()._newTrade_callback != null)
            {
                actionFactory.getTradeCommands()._newTrade_callback.apply(this, [_loc_2]);
                actionFactory.getTradeCommands()._newTrade_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_army_disbandInjuredTroop(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("army.disbandInjuredTroop", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getArmyCommands()._disbandInjuredTroop_callback != null)
            {
                actionFactory.getArmyCommands()._disbandInjuredTroop_callback.apply(this, [_loc_2]);
                actionFactory.getArmyCommands()._disbandInjuredTroop_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_friend_addFriend(param1:Object) : void
        {
            var _loc_2:* = new FriendResponse("friend.addFriend", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getFriendCommands()._addFriend_callback != null)
            {
                actionFactory.getFriendCommands()._addFriend_callback.apply(this, [_loc_2]);
                actionFactory.getFriendCommands()._addFriend_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_army_getStayAllianceArmys(param1:Object) : void
        {
            var _loc_2:* = new StayAllianceReponse("army.getStayAllianceArmys", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getArmyCommands()._getStayAllianceArmys_callback != null)
            {
                actionFactory.getArmyCommands()._getStayAllianceArmys_callback.apply(this, [_loc_2]);
                actionFactory.getArmyCommands()._getStayAllianceArmys_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_troop_accTroopProduce(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("troop.accTroopProduce", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTroopCommands()._accTroopProduce_callback != null)
            {
                actionFactory.getTroopCommands()._accTroopProduce_callback.apply(this, [_loc_2]);
                actionFactory.getTroopCommands()._accTroopProduce_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_NewMail(param1:Object) : void
        {
            var _loc_2:* = new NewMail("server.NewMail", param1);
            trace(_loc_2.toDebugString());
            if (onNewMail != null)
            {
                onNewMail.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_hero_getHerosListFromTavern(param1:Object) : void
        {
            var _loc_2:* = new HeroListResponse("hero.getHerosListFromTavern", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getHeroCommand()._getHerosListFromTavern_callback != null)
            {
                actionFactory.getHeroCommand()._getHerosListFromTavern_callback.apply(this, [_loc_2]);
                actionFactory.getHeroCommand()._getHerosListFromTavern_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_city_modifyStorePercent(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("city.modifyStorePercent", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCityCommands()._modifyStorePercent_callback != null)
            {
                actionFactory.getCityCommands()._modifyStorePercent_callback.apply(this, [_loc_2]);
                actionFactory.getCityCommands()._modifyStorePercent_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_trade_getTransingTradeList(param1:Object) : void
        {
            var _loc_2:* = new TransingTradeListResponse("trade.getTransingTradeList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTradeCommands()._getTransingTradeList_callback != null)
            {
                actionFactory.getTradeCommands()._getTransingTradeList_callback.apply(this, [_loc_2]);
                actionFactory.getTradeCommands()._getTransingTradeList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_gamemaster_setResources(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("gamemaster.setResources", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getModifyCommands()._setResources_callback != null)
            {
                actionFactory.getModifyCommands()._setResources_callback.apply(this, [_loc_2]);
                actionFactory.getModifyCommands()._setResources_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_quest_awardPacket(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("quest.awardPacket", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getQuestCommands()._awardPacket_callback != null)
            {
                actionFactory.getQuestCommands()._awardPacket_callback.apply(this, [_loc_2]);
                actionFactory.getQuestCommands()._awardPacket_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_fortifications_destructWallProtect(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("fortifications.destructWallProtect", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getFortificationsCommands()._destructWallProtect_callback != null)
            {
                actionFactory.getFortificationsCommands()._destructWallProtect_callback.apply(this, [_loc_2]);
                actionFactory.getFortificationsCommands()._destructWallProtect_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_trade_searchTrades(param1:Object) : void
        {
            var _loc_2:* = new SearchTradesResponse("trade.searchTrades", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTradeCommands()._searchTrades_callback != null)
            {
                actionFactory.getTradeCommands()._searchTrades_callback.apply(this, [_loc_2]);
                actionFactory.getTradeCommands()._searchTrades_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_common_changeUserFace(param1:Object) : void
        {
            var _loc_2:* = new ChangeUserFaceResponse("common.changeUserFace", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCommonCommands()._changeUserFace_callback != null)
            {
                actionFactory.getCommonCommands()._changeUserFace_callback.apply(this, [_loc_2]);
                actionFactory.getCommonCommands()._changeUserFace_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_army_getInjuredTroop(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("army.getInjuredTroop", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getArmyCommands()._getInjuredTroop_callback != null)
            {
                actionFactory.getArmyCommands()._getInjuredTroop_callback.apply(this, [_loc_2]);
                actionFactory.getArmyCommands()._getInjuredTroop_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_EnemyArmysUpdate(param1:Object) : void
        {
            var _loc_2:* = new EnemyArmysUpdate("server.EnemyArmysUpdate", param1);
            trace(_loc_2.toDebugString());
            if (onEnemyArmysUpdate != null)
            {
                onEnemyArmysUpdate.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_army_setAllowAllianceArmy(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("army.setAllowAllianceArmy", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getArmyCommands()._setAllowAllianceArmy_callback != null)
            {
                actionFactory.getArmyCommands()._setAllowAllianceArmy_callback.apply(this, [_loc_2]);
                actionFactory.getArmyCommands()._setAllowAllianceArmy_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_hero_awardGold(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("hero.awardGold", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getHeroCommand()._awardGold_callback != null)
            {
                actionFactory.getHeroCommand()._awardGold_callback.apply(this, [_loc_2]);
                actionFactory.getHeroCommand()._awardGold_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_troop_produceTroop(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("troop.produceTroop", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getTroopCommands()._produceTroop_callback != null)
            {
                actionFactory.getTroopCommands()._produceTroop_callback.apply(this, [_loc_2]);
                actionFactory.getTroopCommands()._produceTroop_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_rank_getCastleRank(param1:Object) : void
        {
            var _loc_2:* = new RankCastleResponse("rank.getCastleRank", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getRankCommands()._getCastleRank_callback != null)
            {
                actionFactory.getRankCommands()._getCastleRank_callback.apply(this, [_loc_2]);
                actionFactory.getRankCommands()._getCastleRank_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_hero_dischargeChief(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("hero.dischargeChief", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getHeroCommand()._dischargeChief_callback != null)
            {
                actionFactory.getHeroCommand()._dischargeChief_callback.apply(this, [_loc_2]);
                actionFactory.getHeroCommand()._dischargeChief_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_KickedOut(param1:Object) : void
        {
            var _loc_2:* = new KickedOut("server.KickedOut", param1);
            trace(_loc_2.toDebugString());
            if (onKickedOut != null)
            {
                onKickedOut.apply(this, [_loc_2]);
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            return;
        }// end function

        private function _resp_mail_deleteMail(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("mail.deleteMail", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getMailCommands()._deleteMail_callback != null)
            {
                actionFactory.getMailCommands()._deleteMail_callback.apply(this, [_loc_2]);
                actionFactory.getMailCommands()._deleteMail_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_city_moveCastle(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("city.moveCastle", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getCityCommands()._moveCastle_callback != null)
            {
                actionFactory.getCityCommands()._moveCastle_callback.apply(this, [_loc_2]);
                actionFactory.getCityCommands()._moveCastle_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_alliance_leaderWantUserInAllianceList(param1:Object) : void
        {
            var _loc_2:* = new AllianceInviteOnClientBeanResponse("alliance.leaderWantUserInAllianceList", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getAllianceManagementCommands()._leaderWantUserInAllianceList_callback != null)
            {
                actionFactory.getAllianceManagementCommands()._leaderWantUserInAllianceList_callback.apply(this, [_loc_2]);
                actionFactory.getAllianceManagementCommands()._leaderWantUserInAllianceList_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        private function _resp_hero_promoteToChief(param1:Object) : void
        {
            var _loc_2:* = new CommandResponse("hero.promoteToChief", param1);
            trace(_loc_2.toDebugString());
            if (actionFactory.getHeroCommand()._promoteToChief_callback != null)
            {
                actionFactory.getHeroCommand()._promoteToChief_callback.apply(this, [_loc_2]);
                actionFactory.getHeroCommand()._promoteToChief_callback = null;
            }// end if
            if (!hasEventListener(_loc_2.type))
            {
                trace("EventListener:" + _loc_2.type + " not found!");
                dispatchEvent(new NoListenerEvent(_loc_2.type, _loc_2));
            }
            else
            {
                dispatchEvent(_loc_2);
            }// end else if
            MouseManager.setNormal();
            return;
        }// end function

        public static function getInstance() : ResponseDispatcher
        {
            return instance;
        }// end function

    }
}
