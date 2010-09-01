package com.umge.sovt.common.server.events
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;

    public class HeroUpdate extends BaseBean
    {
        public var castleId:int;
        public var hero:HeroBean;
        public var updateType:int;

        public function HeroUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            super(param1, param3, param4);
            if (param2.castleId != null)
            {
                this.castleId = param2.castleId;
            }// end if
            if (param2.hero != null)
            {
                this.hero = new HeroBean(param2.hero);
            }// end if
            if (param2.updateType != null)
            {
                this.updateType = param2.updateType;
            }// end if
            return;
        }// end function

        public function copyTo(param1:HeroUpdate) : void
        {
            param1.castleId = this.castleId;
            if (hero != null)
            {
                this.hero.copyTo(param1.hero);
            }
            else
            {
                param1.hero = null;
            }// end else if
            param1.updateType = this.updateType;
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.castleId = this.castleId;
            _loc_1.hero = this.hero.toObject();
            _loc_1.updateType = this.updateType;
            return _loc_1;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "castleId = " + this.castleId + "\n");
            if (hero != null)
            {
                _loc_2 = _loc_2 + this.hero.toDebugString(param1 + "hero.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "hero = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "updateType = " + this.updateType + "\n");
            return _loc_2;
        }// end function

    }
}
