package com.umge.sovt.common
{
    import mx.collections.*;

    public class CommonUtil extends Object
    {

        public function CommonUtil()
        {
            return;
        }// end function

        public static function arrayCopy(param1:ArrayCollection, param2:ArrayCollection) : void
        {
            if (param1 == null || param2 == null)
            {
                return;
            }// end if
            param2.removeAll();
            var _loc_3:int;
            while (_loc_3 < param1.length)
            {
                // label
                param2.addItem(param1[_loc_3]);
                _loc_3++;
            }// end while
            return;
        }// end function

    }
}
