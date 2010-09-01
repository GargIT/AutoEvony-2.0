package com.umge.sovt.eum
{

    public class TechLevelData extends Object
    {
        public var level:int;
        public var stone:int;
        public var gold:int;
        public var wood:int;
        public var iron:int;
        public var effect:int;
        public var time:int;
        public var food:int;

        public function TechLevelData(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int)
        {
            this.level = param1;
            this.food = param2;
            this.wood = param3;
            this.iron = param4;
            this.stone = param5;
            this.gold = param6;
            this.time = param7;
            this.effect = param8;
            return;
        }// end function

    }
}
