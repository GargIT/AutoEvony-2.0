package com.umge.sovt.eum
{
	import flash.xml.*;

    public class TroopEumDefine extends Object
    {
        private var data:Object;
        private static var instance:TroopEumDefine = new TroopEumDefine;

        public function TroopEumDefine()
        {
            var _loc_3:XMLNode;
            var _loc_4:TroopEum;
            data = new Object();
            var _loc_1:* = GetDataXML.instance.getXMLDoc("TroopEumDefine");
            var _loc_2:* = _loc_1.lastChild.childNodes;
            for each (_loc_3 in _loc_2)
            {
                // label
                if (_loc_3.attributes.typeId)
                {
                    _loc_4 = new TroopEum();
                    _loc_4.life = _loc_3.attributes.life;
                    _loc_4.attack = _loc_3.attributes.attack;
                    _loc_4.defence = _loc_3.attributes.defence;
                    _loc_4.range = _loc_3.attributes.range;
                    _loc_4.speed = _loc_3.attributes.speed;
                    _loc_4.load = _loc_3.attributes.load;
                    _loc_4.food = _loc_3.attributes.food;
                    _loc_4.wood = _loc_3.attributes.wood;
                    _loc_4.stone = _loc_3.attributes.stone;
                    _loc_4.iron = _loc_3.attributes.iron;
                    _loc_4.foodRequest = _loc_3.attributes.foodRequest;
                    _loc_4.time = _loc_3.attributes.time;
                    _loc_4.population = _loc_3.attributes.population;
                    _loc_4.name = _loc_3.attributes.name;
                    _loc_4.desc = _loc_3.attributes.desc;
                    _loc_4.wikiDesc = _loc_3.attributes.wikiDesc;
                    _loc_4.typeId = _loc_3.attributes.typeId;
                    this.data[_loc_4.typeId] = _loc_4;
                }// end if
            }// end of for each ... in
            return;
        }// end function

        public static function getTroopEumByType(param1:int) : TroopEum
        {
            return instance.data[param1] as TroopEum;
        }// end function

    }
}
