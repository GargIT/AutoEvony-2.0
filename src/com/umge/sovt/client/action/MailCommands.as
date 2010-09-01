package com.umge.sovt.client.action
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.module.*;
    import com.umge.sovt.common.module.mail.*;

    public class MailCommands extends Object
    {
        public var _receiveMailList_callback:Function;
        public var _reportPlayer_callback:Function;
        public var _readMail_callback:Function;
        public var _deleteMail_callback:Function;
        public var _readOverMailList_callback:Function;
        public var _sendMail_callback:Function;
        public var _getAllTVMsg_callback:Function;
        public var _reportBug_callback:Function;
        private var sender:Sender;

        public function MailCommands()
        {
            return;
        }// end function

        public function deleteMail(param1:String, param2:Function = null) : CommandResponse
        {
            this._deleteMail_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.str_mailid = param1;
            if (this.sender != null)
            {
                sender.sendMessage("mail.deleteMail", _loc_3);
            }// end if
            return null;
        }// end function

        public function getAllTVMsg(param1:Function = null) : TVResponse
        {
            this._getAllTVMsg_callback = param1;
            var _loc_2:* = new Object();
            if (this.sender != null)
            {
                sender.sendMessage("mail.getAllTVMsg", _loc_2);
            }// end if
            return null;
        }// end function

        public function readOverMailList(param1:String, param2:Function = null) : MailResponse
        {
            this._readOverMailList_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.mailIds = param1;
            if (this.sender != null)
            {
                sender.sendMessage("mail.readOverMailList", _loc_3);
            }// end if
            return null;
        }// end function

        public function reportBug(param1:String, param2:String, param3:Function = null) : CommandResponse
        {
            this._reportBug_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.subject = param1;
            _loc_4.content = param2;
            if (this.sender != null)
            {
                sender.sendMessage("mail.reportBug", _loc_4);
            }// end if
            return null;
        }// end function

        public function sendMail(param1:String, param2:String, param3:String, param4:Function = null) : CommandResponse
        {
            this._sendMail_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.username = param1;
            _loc_5.title = param2;
            _loc_5.content = param3;
            if (this.sender != null)
            {
                sender.sendMessage("mail.sendMail", _loc_5);
            }// end if
            return null;
        }// end function

        public function readMail(param1:int, param2:Function = null) : MailResponse
        {
            this._readMail_callback = param2;
            var _loc_3:* = new Object();
            _loc_3.mailId = param1;
            if (this.sender != null)
            {
                sender.sendMessage("mail.readMail", _loc_3);
            }// end if
            return null;
        }// end function

        public function setSender(param1:Sender) : void
        {
            this.sender = param1;
            return;
        }// end function

        public function receiveMailList(param1:int, param2:int, param3:int, param4:Function = null) : MailListResponse
        {
            this._receiveMailList_callback = param4;
            var _loc_5:* = new Object();
            _loc_5.pageNo = param1;
            _loc_5.type = param2;
            _loc_5.pageSize = param3;
            if (this.sender != null)
            {
                sender.sendMessage("mail.receiveMailList", _loc_5);
            }// end if
            return null;
        }// end function

        public function reportPlayer(param1:String, param2:String, param3:Function = null) : CommandResponse
        {
            this._reportPlayer_callback = param3;
            var _loc_4:* = new Object();
            _loc_4.subject = param1;
            _loc_4.content = param2;
            if (this.sender != null)
            {
                sender.sendMessage("mail.reportPlayer", _loc_4);
            }// end if
            return null;
        }// end function

    }
}
