package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.friend.*;

    public class FriendCommands extends Object
    {
        public var _deleteBlock_callback:Function;
        public var _addFriend_callback:Function;
        public var _isBlockMailPlayer_callback:Function;
        private var sender:Sender;
        public var _addBlock_callback:Function;
        public var _deleteFriend_callback:Function;

        public function FriendCommands()
        {
            return;
        }// end function

        public function deleteBlock(param1:String, param2:Function = null) : FriendResponse
        {
            this._deleteBlock_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.player = param1;
            if (this.sender != null)
            {
                sender.sendMessage("friend.deleteBlock", _loc_3);
            }// end if
            return null;
        }// end function

        public function deleteFriend(param1:String, param2:Function = null) : FriendResponse
        {
            this._deleteFriend_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.player = param1;
            if (this.sender != null)
            {
                sender.sendMessage("friend.deleteFriend", _loc_3);
            }// end if
            return null;
        }// end function

        public function addBlock(param1:String, param2:Function = null) : FriendResponse
        {
            this._addBlock_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.player = param1;
            if (this.sender != null)
            {
                sender.sendMessage("friend.addBlock", _loc_3);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

        public function isBlockMailPlayer(param1:int, param2:Function = null) : FriendResponse
        {
            this._isBlockMailPlayer_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.mailId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("friend.isBlockMailPlayer", _loc_3);
            }// end if
            return null;
        }// end function

        public function addFriend(param1:String, param2:Function = null) : FriendResponse
        {
            this._addFriend_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.player = param1;
            if (this.sender != null)
            {
                sender.sendMessage("friend.addFriend", _loc_3);
            }// end if
            return null;
        }// end function

    }
}
