package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;

    public class NewFinishedQuest extends BaseBean
    {

        public function NewFinishedQuest(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            return;
        }// end function

        public function copyTo(param1:NewFinishedQuest) : void
        {
            return;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            return _loc_2;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            return _loc_1;
        }// end function

    }
}
