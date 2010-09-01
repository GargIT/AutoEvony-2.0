package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;

    public class QuestFinished extends BaseBean
    {
        public var finishedQuest:int;

        public function QuestFinished(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.finishedQuest != null)
            {
                this.finishedQuest = param2.finishedQuest;
            }// end if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.finishedQuest = this.finishedQuest;
            return _loc_1;
        }// end function

        public function copyTo(param1:QuestFinished) : void
        {
            param1.finishedQuest = this.finishedQuest;
            return;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "finishedQuest = " + this.finishedQuest + "\n");
            return _loc_2;
        }// end function

    }
}
