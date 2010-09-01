package com.umge.sovt.common.module.alliance
{
    import com.umge.sovt.common.*;
    import com.umge.sovt.common.beans.*;
    import mx.collections.*;

    public class AllianceFriendshipResponse extends BaseBean
    {
        public var packageId:Number;
        public var msg:String;
        public var middleListArray:ArrayCollection;
        public var friendlyListArray:ArrayCollection;
        public var errorMsg:String;
        public var enemyListArray:ArrayCollection;
        public var ok:int;

        public function AllianceFriendshipResponse(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
        {
            var _loc_5:int;
            var _loc_6:UnitAlliance;
            var _loc_7:UnitAlliance;
            var _loc_8:UnitAlliance;
            enemyListArray = new ArrayCollection();
            friendlyListArray = new ArrayCollection();
            middleListArray = new ArrayCollection();
            super(param1, param3, param4);
            if (param2.errorMsg != null)
            {
                this.errorMsg = param2.errorMsg;
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
            if (param2.enemyList)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.enemyList.length)
                {
                    // label
                    _loc_6 = new UnitAlliance(param2.enemyList[_loc_5]);
                    this.enemyListArray.addItem(_loc_6);
                    _loc_5++;
                }// end while
            }// end if
            if (param2.friendlyList)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.friendlyList.length)
                {
                    // label
                    _loc_7 = new UnitAlliance(param2.friendlyList[_loc_5]);
                    this.friendlyListArray.addItem(_loc_7);
                    _loc_5++;
                }// end while
            }// end if
            if (param2.middleList)
            {
                _loc_5 = 0;
                while (_loc_5 < param2.middleList.length)
                {
                    // label
                    _loc_8 = new UnitAlliance(param2.middleList[_loc_5]);
                    this.middleListArray.addItem(_loc_8);
                    _loc_5++;
                }// end while
            }// end if
            return;
        }// end function

        public function setEnemyList(param1:UnitAlliance, param2:int) : void
        {
            this.enemyListArray[param2] = param1;
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.errorMsg = this.errorMsg;
            _loc_1.msg = this.msg;
            _loc_1.ok = this.ok;
            _loc_1.packageId = this.packageId;
            return _loc_1;
        }// end function

        public function setFriendlyList(param1:UnitAlliance, param2:int) : void
        {
            this.friendlyListArray[param2] = param1;
            return;
        }// end function

        override public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "errorMsg = " + this.errorMsg + "\n");
            _loc_2 = _loc_2 + (param1 + "msg = " + this.msg + "\n");
            _loc_2 = _loc_2 + (param1 + "ok = " + this.ok + "\n");
            _loc_2 = _loc_2 + (param1 + "packageId = " + this.packageId + "\n");
            _loc_3 = 0;
            while (_loc_3 < this.enemyListArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getEnemyList(_loc_3).toDebugString(param1 + "enemyList[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.friendlyListArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getFriendlyList(_loc_3).toDebugString(param1 + "friendlyList[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.middleListArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getMiddleList(_loc_3).toDebugString(param1 + "middleList[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function setMiddleList(param1:UnitAlliance, param2:int) : void
        {
            this.middleListArray[param2] = param1;
            return;
        }// end function

        public function getMiddleList(param1:int) : UnitAlliance
        {
            var _loc_2:* = this.middleListArray[param1] as UnitAlliance;
            return _loc_2;
        }// end function

        public function getEnemyList(param1:int) : UnitAlliance
        {
            var _loc_2:* = this.enemyListArray[param1] as UnitAlliance;
            return _loc_2;
        }// end function

        public function copyTo(param1:AllianceFriendshipResponse) : void
        {
            param1.errorMsg = this.errorMsg;
            param1.msg = this.msg;
            param1.ok = this.ok;
            param1.packageId = this.packageId;
            CommonUtil.arrayCopy(this.enemyListArray, param1.enemyListArray);
            CommonUtil.arrayCopy(this.friendlyListArray, param1.friendlyListArray);
            CommonUtil.arrayCopy(this.middleListArray, param1.middleListArray);
            return;
        }// end function

        public function getFriendlyList(param1:int) : UnitAlliance
        {
            var _loc_2:* = this.friendlyListArray[param1] as UnitAlliance;
            return _loc_2;
        }// end function

    }
}
