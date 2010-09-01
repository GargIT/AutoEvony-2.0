package com.umge.sovt.common.module.hero
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class HeroResponse extends BaseBean
    {
        public var packageId:Number;
        public var msg:String;
        public var errorMsg:String;
        public var hero:HeroBean;
        public var ok:int;
        public static const FREE_HERO_STATUS:int = 0;
        public static const INVALID_ADD_POINT:int = -10;
        public static const NO_TAVERN:int = -7;
        public static const NO_CASTLE_FOUND:int = -1;
        public static const NO_HERO_FOUND:int = -2;
        public static const GUARD_HERO_STATUS:int = 2;
        public static const NO_HERO_MANSION:int = -5;
        public static const NOT_ENOUGH_GOLD_HIRE_HERO:int = -8;
        public static const HERO_IN_USE:int = -3;
        public static const INVALID_NAME:int = -4;
        public static const NO_POSITION_FOR_HERO_:int = -6;
        public static const NOT_ENOUGH_GOLD_AWARD_HERO:int = -9;
        public static const CHIEF_HERO_STATUS:int = 1;

        public function HeroResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.errorMsg != null)
            {
                this.errorMsg = param2.errorMsg;
            }// end if
            if (param2.hero != null)
            {
                this.hero = new HeroBean(param2.hero);
            }// end if
            if (param2.msg != null)
            {
                this.msg = param2.msg;
            }// end if
            if (param2.ok != null)
            {
                this.ok = param2.ok;
            }// end if
            if (param2.packageId != null)
            {
                this.packageId = param2.packageId;
            }// end if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.hero = this.hero.toObject();
            _loc_1.msg = this.msg;
            _loc_1.ok = this.ok;
            _loc_1.packageId = this.packageId;
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "errorMsg = " + this.errorMsg + "\n");
            if (hero != null)
            {
                _loc_2 = _loc_2 + this.hero.toDebugString(param1 + "hero.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "hero = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "ok = " + this.ok + "\n");
            _loc_2 = _loc_2 + (param1 + "packageId = " + this.packageId + "\n");
            return _loc_2;
        }// end function

        public function copyTo(param1:HeroResponse) : void
        {
            param1.errorMsg = this.errorMsg;
            if (hero != null)
            {
                this.hero.copyTo(param1.hero);
            }
            else
            {
                param1.hero = null;
            }// end else if
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            return;
        }// end function

    }
}
