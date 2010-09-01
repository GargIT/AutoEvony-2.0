package com.umge.sovt.eum
{
    import com.umge.sovt.common.beans.*;

    public class BuildingEumDefine extends Object
    {
        private var map:Object;
        private static var instance:BuildingEumDefine = new BuildingEumDefine;

        public function BuildingEumDefine()
        {
            var _loc_3:XMLNode;
            var _loc_4:BuildingEum;
            var _loc_5:Array;
            var _loc_6:Array;
            var _loc_7:XMLNode;
            var _loc_8:XMLNode;
            map = new Object();
            var _loc_1:* = GetDataXML.instance.getXMLDoc("BuildingEumDefine");
            var _loc_2:* = _loc_1.lastChild.childNodes;
            for each (_loc_3 in _loc_2)
            {
                // label
                _loc_4 = new BuildingEum();
                if (_loc_3.attributes.typeId)
                {
                    _loc_4.name = _loc_3.attributes.name;
                    _loc_4.desc = _loc_3.attributes.desc;
                    _loc_4.wikiDesc = _loc_3.attributes.wikiDesc;
                    _loc_4.typeId = _loc_3.attributes.typeId;
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
                            _loc_4.addLevelData(new BuildingLevelData(_loc_8.attributes.level, _loc_8.attributes.workPeople, _loc_8.attributes.limit, _loc_8.attributes.produce, _loc_8.attributes.food, _loc_8.attributes.wood, _loc_8.attributes.stone, _loc_8.attributes.iron, _loc_8.attributes.time, _loc_8.attributes.buildPeople));
                        }// end if
                    }// end of for each ... in
                    map[_loc_4.typeId] = _loc_4;
                }// end if
            }// end of for each ... in
            return;
        }// end function

        public static function getName(param1:int) : String
        {
            var _loc_2:* = instance.map[param1] as BuildingEum;
            if (_loc_2 == null)
            {
                return param1 + ":null";
            }// end if
            return _loc_2.name;
        }// end function

        public static function getTime(param1:BuildingBean) : Number
        {
            var _loc_2:* = instance.map[param1.typeId] as BuildingEum;
            if (_loc_2 == null)
            {
                return 0;
            }// end if
            return _loc_2.getLevelData(param1.level).time;
        }// end function

        public static function getBuildingEumByType(param1:int) : BuildingEum
        {
            return instance.map[param1] as BuildingEum;
        }// end function

        public static function getDesc(param1:int) : String
        {
            var _loc_2:* = instance.map[param1] as BuildingEum;
            if (_loc_2 == null)
            {
                return param1 + ":null";
            }// end if
            return _loc_2.desc;
        }// end function

    }
}
