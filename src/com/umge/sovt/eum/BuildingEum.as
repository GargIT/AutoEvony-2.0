package com.umge.sovt.eum
{

    public class BuildingEum extends Object
    {
        public var wikiDesc:String;
        public var name:String;
        private var levelData:Array;
        public var desc:String;
        public var typeId:int;
        private var upLevelDescs:Array;
        public var upLevelDesc:String;

        public function BuildingEum()
        {
            levelData = new Array();
            upLevelDescs = new Array();
            return;
        }// end function

        public function addUpLevelDesc(param1:UpLevelDesc) : void
        {
            this.upLevelDescs[param1.level] = param1;
            return;
        }// end function

        public function getUpLevelDesc(param1:int) : UpLevelDesc
        {
            return this.upLevelDescs[param1] as UpLevelDesc;
        }// end function

        public function addLevelData(param1:BuildingLevelData) : void
        {
            this.levelData[param1.level] = param1;
            return;
        }// end function

        public function getLevelData(param1:int) : BuildingLevelData
        {
            return this.levelData[param1] as BuildingLevelData;
        }// end function

    }
}
