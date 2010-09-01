package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.alliance.*;

    public class AllianceManagementCommands extends Object
    {
        public var _rejectComeinAlliance_callback:Function;
        public var _getAllianceWanted_callback:Function;
        public var _dropAllianceFriendshipRelation_callback:Function;
        public var _messagesForAllianceMember_callback:Function;
        public var _setPowerForUserByAlliance_callback:Function;
        public var _addUsertoAlliance_callback:Function;
        public var _addUsertoAllianceList_callback:Function;
        public var _setAllianceFriendship_callback:Function;
        public var _resignForAlliance_callback:Function;
        public var _getPowerFromAlliance_callback:Function;
        public var _sayByetoAlliance_callback:Function;
        public var _agreeComeinAllianceList_callback:Function;
        public var _isHasAlliance_callback:Function;
        public var _kickOutMemberfromAlliance_callback:Function;
        public var _resetTopPowerForAlliance_callback:Function;
        public var _getAllianceFriendshipList_callback:Function;
        private var sender:Sender;
        public var _cancelUserWantInAlliance_callback:Function;
        public var _agreeComeinAllianceByUser_callback:Function;
        public var _agreeComeinAllianceByLeader_callback:Function;
        public var _canceladdUsertoAlliance_callback:Function;
        public var _leaderWantUserInAllianceList_callback:Function;
        public var _setAllInfoForAlliance_callback:Function;
        public var _createAlliance_callback:Function;
        public var _userWantInAlliance_callback:Function;
        public var _cancelagreeComeinAlliance_callback:Function;

        public function AllianceManagementCommands()
        {
            return;
        }// end function

        public function resetTopPowerForAlliance(param1:String, param2:Function = null) : AllianceManagementResponse
        {
            this._resetTopPowerForAlliance_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.userName = param1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.resetTopPowerForAlliance", _loc_3);
            }// end if
            return null;
        }// end function

        public function userWantInAlliance(param1:String, param2:Function = null) : AllianceManagementResponse
        {
            this._userWantInAlliance_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.allianceName = param1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.userWantInAlliance", _loc_3);
            }// end if
            return null;
        }// end function

        public function agreeComeinAllianceList(param1:Function = null) : AllianceUserAddResponse
        {
            this._agreeComeinAllianceList_callback = param1;
            var _loc_2:* = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.agreeComeinAllianceList", _loc_2);
            }// end if
            return null;
        }// end function

        public function resignForAlliance(param1:Function = null) : AllianceManagementResponse
        {
            this._resignForAlliance_callback = param1;
            var _loc_2:* = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.resignForAlliance", _loc_2);
            }// end if
            return null;
        }// end function

        public function cancelUserWantInAlliance(param1:String, param2:Function = null) : AllianceManagementResponse
        {
            this._cancelUserWantInAlliance_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.allianceName = param1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.cancelUserWantInAlliance", _loc_3);
            }// end if
            return null;
        }// end function

        public function rejectComeinAlliance(param1:String, param2:Function = null) : AllianceUserAddResponse
        {
            this._rejectComeinAlliance_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.allianceName = param1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.rejectComeinAlliance", _loc_3);
            }// end if
            return null;
        }// end function

        public function cancelagreeComeinAlliance(param1:String, param2:Function = null) : AllianceUserAddResponse
        {
            this._cancelagreeComeinAlliance_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.userName = param1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.cancelagreeComeinAlliance", _loc_3);
            }// end if
            return null;
        }// end function

        public function addUsertoAllianceList(param1:Function = null) : AllianceInviteBeanResponse
        {
            this._addUsertoAllianceList_callback = param1;
            var _loc_2:* = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.addUsertoAllianceList", _loc_2);
            }// end if
            return null;
        }// end function

        public function setPowerForUserByAlliance(param1:String, param2:int, param3:Function = null) : AllianceManagementResponse
        {
            this._setPowerForUserByAlliance_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.userName = param1;
            _loc_4.typeId = param2;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.setPowerForUserByAlliance", _loc_4);
            }// end if
            return null;
        }// end function

        public function canceladdUsertoAlliance(param1:String, param2:Function = null) : AllianceInviteBeanResponse
        {
            this._canceladdUsertoAlliance_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.userName = param1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.canceladdUsertoAlliance", _loc_3);
            }// end if
            return null;
        }// end function

        public function agreeComeinAllianceByLeader(param1:String, param2:Function = null) : AllianceManagementResponse
        {
            this._agreeComeinAllianceByLeader_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.userName = param1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.agreeComeinAllianceByLeader", _loc_3);
            }// end if
            return null;
        }// end function

        public function sayByetoAlliance(param1:Function = null) : AllianceManagementResponse
        {
            this._sayByetoAlliance_callback = param1;
            var _loc_2:* = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.sayByetoAlliance", _loc_2);
            }// end if
            return null;
        }// end function

        public function getAllianceFriendshipList(param1:Function = null) : AllianceFriendshipResponse
        {
            this._getAllianceFriendshipList_callback = param1;
            var _loc_2:* = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.getAllianceFriendshipList", _loc_2);
            }// end if
            return null;
        }// end function

        public function setAllInfoForAlliance(param1:String, param2:String, param3:String, param4:Function = null) : AllianceManagementResponse
        {
            this._setAllInfoForAlliance_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.allianceName = param1;
            _loc_5.infoText = param2;
            _loc_5.noteText = param3;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.setAllInfoForAlliance", _loc_5);
            }// end if
            return null;
        }// end function

        public function agreeComeinAllianceByUser(param1:int, param2:String, param3:Function = null) : AllianceUserAddResponse
        {
            this._agreeComeinAllianceByUser_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.allianceName = param2;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.agreeComeinAllianceByUser", _loc_4);
            }// end if
            return null;
        }// end function

        public function getAllianceWanted(param1:Function = null) : WantedAllianceResponse
        {
            this._getAllianceWanted_callback = param1;
            var _loc_2:* = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.getAllianceWanted", _loc_2);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

        public function createAlliance(param1:int, param2:String, param3:Function = null) : AllianceManagementResponse
        {
            this._createAlliance_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.castleId = param1;
            _loc_4.allianceName = param2;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.createAlliance", _loc_4);
            }// end if
            return null;
        }// end function

        public function addUsertoAlliance(param1:String, param2:Function = null) : AllianceManagementResponse
        {
            this._addUsertoAlliance_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.userName = param1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.addUsertoAlliance", _loc_3);
            }// end if
            return null;
        }// end function

        public function dropAllianceFriendshipRelation(param1:String, param2:Function = null) : AllianceFriendshipResponse
        {
            this._dropAllianceFriendshipRelation_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.targetAllianceName = param1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.dropAllianceFriendshipRelation", _loc_3);
            }// end if
            return null;
        }// end function

        public function setAllianceFriendship(param1:String, param2:int, param3:Function = null) : AllianceManagementResponse
        {
            this._setAllianceFriendship_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.targetAllianceName = param1;
            _loc_4.type = param2;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.setAllianceFriendship", _loc_4);
            }// end if
            return null;
        }// end function

        public function isHasAlliance(param1:Function = null) : HasAllianceResponse
        {
            this._isHasAlliance_callback = param1;
            var _loc_2:* = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.isHasAlliance", _loc_2);
            }// end if
            return null;
        }// end function

        public function getPowerFromAlliance(param1:Function = null) : AlliancePowerLevelResponse
        {
            this._getPowerFromAlliance_callback = param1;
            var _loc_2:* = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.getPowerFromAlliance", _loc_2);
            }// end if
            return null;
        }// end function

        public function kickOutMemberfromAlliance(param1:String, param2:Function = null) : AllianceManagementResponse
        {
            this._kickOutMemberfromAlliance_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.userName = param1;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.kickOutMemberfromAlliance", _loc_3);
            }// end if
            return null;
        }// end function

        public function messagesForAllianceMember(param1:String, param2:String, param3:int, param4:Function = null) : AllianceManagementResponse
        {
            this._messagesForAllianceMember_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.title = param1;
            _loc_5.message = param2;
            _loc_5.type = param3;
            if (this.sender != null)
            {
                sender.sendMessage("alliance.messagesForAllianceMember", _loc_5);
            }// end if
            return null;
        }// end function

        public function leaderWantUserInAllianceList(param1:Function = null) : AllianceInviteOnClientBeanResponse
        {
            this._leaderWantUserInAllianceList_callback = param1;
            var _loc_2:* = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("alliance.leaderWantUserInAllianceList", _loc_2);
            }// end if
            return null;
        }// end function

    }
}
