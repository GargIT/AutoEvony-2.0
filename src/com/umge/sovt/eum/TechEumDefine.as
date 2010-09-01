package com.umge.sovt.eum
{
    import com.umge.sovt.common.beans.*;

    public class TechEumDefine extends Object
    {
        private var map:Object;
        private var map2:Object;
        private static var instance:TechEumDefine = new TechEumDefine;

        public function TechEumDefine()
        {
            var _loc_3:XMLNode;
            var _loc_4:TechEum;
            var _loc_5:Array;
            var _loc_6:Array;
            var _loc_7:XMLNode;
            var _loc_8:XMLNode;
            map = new Object();
            map2 = new Object();
            var _loc_1:* = GetDataXML.instance.getXMLDoc("TechEumDefine");
            var _loc_2:* = _loc_1.lastChild.childNodes;
            for each (_loc_3 in _loc_2)
            {
                // label
                _loc_4 = new TechEum();
                if (_loc_3.attributes.typeId)
                {
                    _loc_4.typeId = _loc_3.attributes.typeId;
                    _loc_4.name = _loc_3.attributes.name;
                    _loc_4.desc = _loc_3.attributes.desc;
                    _loc_4.wikiDesc = _loc_3.attributes.wikiDesc;
                }// end if
                if (_loc_3.hasChildNodes())
                {
                    _loc_5 = _loc_3.firstChild.nextSibling.childNodes;
                    _loc_6 = _loc_3.lastChild.previousSibling.childNodes;
                    for each (_loc_7 in _loc_5)
                    {
                        // label
                        if (_loc_7.attributes.level)
                        {
                            _loc_4.addUpLevelDesc(new UpLevelDesc(_loc_7.attributes.level, _loc_7.attributes.upLevelDesc));
                        }// end if
                    }// end of for each ... in
                    for each (_loc_8 in _loc_6)
                    {
                        // label
                        if (_loc_8.attributes.level)
                        {
                            _loc_4.addLevelData(new TechLevelData(_loc_8.attributes.level, _loc_8.attributes.food, _loc_8.attributes.wood, _loc_8.attributes.iron, _loc_8.attributes.stone, _loc_8.attributes.gold, _loc_8.attributes.time, _loc_8.attributes.effect));
                        }// end if
                    }// end of for each ... in
                    map[_loc_4.typeId] = _loc_4;
                }// end if
            }// end of for each ... in
            return;
        }// end function

        public static function getTime(param1:AvailableResearchListBean) : Number
        {
            var _loc_2:* = instance.map[param1.typeId] as TechEum;
            if (_loc_2 == null)
            {
                return 0;
            }// end if
            return _loc_2.getLevelData(param1.level).time;
        }// end function

        public static function getTechEumByClassName(param1:String) : TechEum
        {
            return instance.map2[param1] as TechEum;
        }// end function

        public static function getTechEumByType(param1:int) : TechEum
        {
            return instance.map[param1] as TechEum;
        }// end function

    }
}
