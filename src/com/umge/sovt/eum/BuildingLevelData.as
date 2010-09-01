package com.umge.sovt.eum
{

    public class BuildingLevelData extends Object
    {
        public var level:int;
        public var stone:int;
        public var wood:int;
        public var workPeople:int;
        public var time:int;
        public var iron:int;
        public var produce:int;
        public var limit:int;
        public var buildPeople:int;
        public var food:int;

        public function BuildingLevelData(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int)
        {
            this.level = param1;
            this.workPeople = param2;
            this.limit = param3;
            this.produce = param4;
            this.food = param5;
            this.wood = param6;
            this.stone = param7;
            this.iron = param8;
            this.time = param9;
            this.buildPeople = param10;
            return;
        }// end function

    }
}
