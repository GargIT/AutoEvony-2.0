package com.umge.sovt.eum
{

    public class FortificationEumDefine extends Object
    {
        private var map:Object;
        private static var instance:FortificationEumDefine = new FortificationEumDefine;

        public function FortificationEumDefine()
        {
            var _loc_3:XMLNode;
            var _loc_4:FortificationEum;
            map = new Object();
            var _loc_1:* = GetDataXML.instance.getXMLDoc("FortificationEumDefine");
            var _loc_2:* = _loc_1.lastChild.childNodes;
            for each (_loc_3 in _loc_2)
            {
                // label
                if (_loc_3.attributes.typeId)
                {
                    _loc_4 = new FortificationEum();
                    _loc_4.typeId = _loc_3.attributes.typeId;
                    _loc_4.name = _loc_3.attributes.name;
                    _loc_4.desc = _loc_3.attributes.desc;
                    _loc_4.wikiDesc = _loc_3.attributes.wikiDesc;
                    _loc_4.food = _loc_3.attributes.food;
                    _loc_4.wood = _loc_3.attributes.wood;
                    _loc_4.stone = _loc_3.attributes.stone;
                    _loc_4.iron = _loc_3.attributes.iron;
                    _loc_4.time = _loc_3.attributes.time;
                    _loc_4.repairRate = _loc_3.attributes.repairRate;
                    _loc_4.space = _loc_3.attributes.space;
                    _loc_4.life = _loc_3.attributes.life;
                    _loc_4.defence = _loc_3.attributes.defence;
                    _loc_4.attack = _loc_3.attributes.attack;
                    _loc_4.range = _loc_3.attributes.range;
                    map[_loc_4.typeId] = _loc_4;
                }// end if
            }// end of for each ... in
            return;
        }// end function

        public static function getFortificationEumByType(param1:int) : FortificationEum
        {
            return instance.map[param1] as FortificationEum;
        }// end function

    }
}
