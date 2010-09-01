package com.umge.sovt.eum
{

    public class ItemEumDefine extends Object
    {
        private var itemArray:Array;
        private static var instance:ItemEumDefine = new ItemEumDefine;

        public function ItemEumDefine()
        {
            var _loc_3:XMLNode;
            var _loc_4:ItemEum;
            itemArray = new Array();
            var _loc_1:* = GetDataXML.instance.getXMLDoc("ItemEumDefine");
            var _loc_2:* = _loc_1.lastChild.childNodes;
            for each (_loc_3 in _loc_2)
            {
                // label
                if (_loc_3.attributes.id)
                {
                    _loc_4 = new ItemEum();
                    _loc_4.id = _loc_3.attributes.id;
                    _loc_4.name = _loc_3.attributes.name;
                    _loc_4.itemType = _loc_3.attributes.itemType;
                    _loc_4.dayLimit = _loc_3.attributes.dayLimit;
                    _loc_4.userLimit = _loc_3.attributes.userLimit;
                    _loc_4.desc = _loc_3.attributes.desc;
                    _loc_4.itemDesc = _loc_3.attributes.itemDesc;
                    _loc_4.iconUrl = _loc_3.attributes.iconUrl;
                    _loc_4.price = _loc_3.attributes.price;
                    _loc_4.heroItem = _loc_3.attributes.heroItem;
                    _loc_4.playerItem = _loc_3.attributes.playerItem;
                    itemArray[_loc_4.id] = _loc_4;
                }// end if
            }// end of for each ... in
            return;
        }// end function

        public static function getItemEum(param1:String) : ItemEum
        {
            return instance.itemArray[param1] as ItemEum;
        }// end function

        public static function getItemEumArray() : Array
        {
            return instance.itemArray;
        }// end function

    }
}
