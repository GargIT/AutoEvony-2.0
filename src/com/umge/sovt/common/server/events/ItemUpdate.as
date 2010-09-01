package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;
    import mx.collections.*;

    public class ItemUpdate extends BaseBean
    {
        public var itemsArray:ArrayCollection;

        public function ItemUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            var _loc_6:ItemBean;
            itemsArray = new ArrayCollection();
            super(param1, param3, param4);
            if (param2.items)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.items.length)
                {
                    // label
                    _loc_6 = new ItemBean(param2.items[_loc_5]);
                    this.itemsArray.addItem(_loc_6);
                    _loc_5++;
                }// end while
            }// end if
            return;
        }// end function

        public function copyTo(param1:ItemUpdate) : void
        {
            CommonUtil.arrayCopy(this.itemsArray, param1.itemsArray);
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_3 = 0;
            while (_loc_3 < this.itemsArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getItems(_loc_3).toDebugString(param1 + "items[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function getItems(param1:int) : ItemBean
        {
            var _loc_2:* = this.itemsArray[param1] as ItemBean;
            return _loc_2;
        }// end function

        public function setItems(param1:ItemBean, param2:int) : void
        {
            this.itemsArray[param2] = param1;
            return;
        }// end function

    }
}
