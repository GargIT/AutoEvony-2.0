package com.umge.sovt.common
{
    import flash.events.*;

    public class NoListenerEvent extends Event
    {
        private var bean:BaseBean;
        private var cmd:String;
        public static const EVENT:String = "NoListenerEvent";

        public function NoListenerEvent(param1:String, param2:BaseBean, param3:Boolean = false, param4:Boolean = false)
        {
            super(EVENT, param3, param4);
            this.cmd = param1;
            this.bean = param2;
            return;
        }// end function

        public function getResponseName() : String
        {
            return this.cmd;
        }// end function

        public function getBean() : BaseBean
        {
            return this.bean;
        }// end function

    }
}
