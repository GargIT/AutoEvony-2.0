package com.umge.sovt.common.module.mail
{
    import com.umge.sovt.common.*;

    public class MailResponse extends BaseBean
    {
        public var msg:String;
        public var type_id:int;
        public var packageId:Number;
        public var targetId:int;
        public var receiveTime:Number;
        public var content:String;
        public var mailid:int;
        public var errorMsg:String;
        public var playerId:int;
        public var title:String;
        public var isRead:int;
        public var ok:int;
        public var receiver:String;
        public var sender:String;

        public function MailResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.content != null)
            {
                this.content = param2.content;
            }// end if
            if (param2.errorMsg != null)
            {
                this.errorMsg = param2.errorMsg;
            }// end if
            if (param2.isRead != null)
            {
                this.isRead = param2.isRead;
            }// end if
            if (param2.mailid != null)
            {
                this.mailid = param2.mailid;
            }// end if
            if (param2.msg != null)
            {
                this.msg = param2.msg;
            }// end if
            if (param2.ok != null)
            {
                this.ok = param2.ok;
            }// end if
            if (param2.packageId != null)
            {
                this.packageId = param2.packageId;
            }// end if
            if (param2.playerId != null)
            {
                this.playerId = param2.playerId;
            }// end if
            if (param2.receiveTime != null)
            {
                this.receiveTime = param2.receiveTime;
            }// end if
            if (param2.receiver != null)
            {
                this.receiver = param2.receiver;
            }// end if
            if (param2.sender != null)
            {
                this.sender = param2.sender;
            }// end if
            if (param2.targetId != null)
            {
                this.targetId = param2.targetId;
            }// end if
            if (param2.title != null)
            {
                this.title = param2.title;
            }// end if
            if (param2.type_id != null)
            {
                this.type_id = param2.type_id;
            }// end if
            return;
        }// end function

        public function copyTo(param1:MailResponse) : void
        {
            param1.content = this.content;
            param1.errorMsg = this.errorMsg;
            param1.isRead = this.isRead;
            param1.mailid = this.mailid;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            param1.playerId = this.playerId;
            param1.receiveTime = this.receiveTime;
            param1.receiver = this.receiver;
            param1.sender = this.sender;
            param1.targetId = this.targetId;
            param1.title = this.title;
            param1.type_id = this.type_id;
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.content = this.content;
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.isRead = this.isRead;
            _loc_1.mailid = this.mailid;
            _loc_1.msg = this.msg;
            _loc_1.ok = this.ok;
            _loc_1.packageId = this.packageId;
            _loc_1.playerId = this.playerId;
            _loc_1.receiveTime = this.receiveTime;
            _loc_1.receiver = this.receiver;
            _loc_1.sender = this.sender;
            _loc_1.targetId = this.targetId;
            _loc_1.title = this.title;
            _loc_1.type_id = this.type_id;
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "content = " + this.content + "\n");
            _loc_2 = _loc_2 + (param1 + "errorMsg = " + this.errorMsg + "\n");
            _loc_2 = _loc_2 + (param1 + "isRead = " + this.isRead + "\n");
            _loc_2 = _loc_2 + (param1 + "mailid = " + this.mailid + "\n");
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "ok = " + this.ok + "\n");
            _loc_2 = _loc_2 + (param1 + "packageId = " + this.packageId + "\n");
            _loc_2 = _loc_2 + (param1 + "playerId = " + this.playerId + "\n");
            _loc_2 = _loc_2 + (param1 + "receiveTime = " + this.receiveTime + "\n");
            _loc_2 = _loc_2 + (param1 + "receiver = " + this.receiver + "\n");
            _loc_2 = _loc_2 + (param1 + "sender = " + this.sender + "\n");
            _loc_2 = _loc_2 + (param1 + "targetId = " + this.targetId + "\n");
            _loc_2 = _loc_2 + (param1 + "title = " + this.title + "\n");
            _loc_2 = _loc_2 + (param1 + "type_id = " + this.type_id + "\n");
            return _loc_2;
        }// end function

    }
}
