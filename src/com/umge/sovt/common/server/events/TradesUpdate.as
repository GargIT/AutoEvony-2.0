package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class TradesUpdate extends BaseBean
    {
        public var updateType:int;
        public var castleId:int;
        public var tradeBean:TradeBean;

        public function TradesUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.castleId != null)
            {
                this.castleId = param2.castleId;
            }// end if
            if (param2.tradeBean != null)
            {
                this.tradeBean = new TradeBean(param2.tradeBean);
            }// end if
            if (param2.updateType != null)
            {
                this.updateType = param2.updateType;
            }// end if
            return;
        }// end function

        public function copyTo(param1:TradesUpdate) : void
        {
            param1.castleId = this.castleId;
            if (tradeBean != null)
            {
                this.tradeBean.copyTo(param1.tradeBean);
            }
            else
            {
                param1.tradeBean = null;
            }// end else if
            param1.updateType = this.updateType;
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.castleId = this.castleId;
            _loc_1.tradeBean = this.tradeBean.toObject();
            _loc_1.updateType = this.updateType;
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "castleId = " + this.castleId + "\n");
            if (tradeBean != null)
            {
                _loc_2 = _loc_2 + this.tradeBean.toDebugString(param1 + "tradeBean.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "tradeBean = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "updateType = " + this.updateType + "\n");
            return _loc_2;
        }// end function

    }
}
