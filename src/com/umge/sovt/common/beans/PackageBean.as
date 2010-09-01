package com.umge.sovt.common.beans
{
    import com.umge.sovt.common.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.events.*;

    public class PackageBean extends Object implements IEventDispatcher
    {
        private var _892481550status:int;
        private var _3575610type:int;
        private var _1049685640itemListArray:ArrayCollection;
        private var _2063817998provideTime:Number;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _3355id:int;
        private var _162030183isUseNow:int;
        private var _1530923192claimedTime:String;
        private var _907766751scores:int;
        private var _391026675maxMedal:int;
        private var _1385169979minMedal:int;
        private var _3079825desc:String;
        private var _908759025packageName:String;
        private var _92515438expiredTime:Number;
        public static const PACKAGE_TYPE_SERIAL:int = 1;
        public static const PACKAGE_TYPE_NORMAL:int = 3;
        public static const PACKAGE_TYPE_SCORES:int = 2;

        public function PackageBean(param1:Object = null)
        {
            var _loc_2:int;
            var _loc_3:ItemBean;
            _1049685640itemListArray = new ArrayCollection();
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.claimedTime != null)
                {
                    this.claimedTime = param1.claimedTime;
                }// end if
                if (param1.desc != null)
                {
                    this.desc = param1.desc;
                }// end if
                if (param1.expiredTime != null)
                {
                    this.expiredTime = param1.expiredTime;
                }// end if
                if (param1.id != null)
                {
                    this.id = param1.id;
                }// end if
                if (param1.isUseNow != null)
                {
                    this.isUseNow = param1.isUseNow;
                }// end if
                if (param1.maxMedal != null)
                {
                    this.maxMedal = param1.maxMedal;
                }// end if
                if (param1.minMedal != null)
                {
                    this.minMedal = param1.minMedal;
                }// end if
                if (param1.packageName != null)
                {
                    this.packageName = param1.packageName;
                }// end if
                if (param1.provideTime != null)
                {
                    this.provideTime = param1.provideTime;
                }// end if
                if (param1.scores != null)
                {
                    this.scores = param1.scores;
                }// end if
                if (param1.status != null)
                {
                    this.status = param1.status;
                }// end if
                if (param1.type != null)
                {
                    this.type = param1.type;
                }// end if
                if (param1.itemList)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.itemList.length)
                    {
                        // label
                        _loc_3 = new ItemBean(param1.itemList[_loc_2]);
                        this.itemListArray.addItem(_loc_3);
                        _loc_2++;
                    }// end while
                }// end if
            }// end if
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function get itemListArray() : ArrayCollection
        {
            return this._1049685640itemListArray;
        }// end function

        public function set minMedal(param1:int) : void
        {
            var _loc_2:* = this._1385169979minMedal;
            if (_loc_2 !== param1)
            {
                this._1385169979minMedal = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "minMedal", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get desc() : String
        {
            return this._3079825desc;
        }// end function

        public function get expiredTime() : Number
        {
            return this._92515438expiredTime;
        }// end function

        public function get provideTime() : Number
        {
            return this._2063817998provideTime;
        }// end function

        public function set type(param1:int) : void
        {
            var _loc_2:* = this._3575610type;
            if (_loc_2 !== param1)
            {
                this._3575610type = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set claimedTime(param1:String) : void
        {
            var _loc_2:* = this._1530923192claimedTime;
            if (_loc_2 !== param1)
            {
                this._1530923192claimedTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "claimedTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get isUseNow() : int
        {
            return this._162030183isUseNow;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.claimedTime = this.claimedTime;
            _loc_1.desc = this.desc;
            _loc_1.expiredTime = this.expiredTime;
            _loc_1.id = this.id;
            _loc_1.isUseNow = this.isUseNow;
            _loc_1.maxMedal = this.maxMedal;
            _loc_1.minMedal = this.minMedal;
            _loc_1.packageName = this.packageName;
            _loc_1.provideTime = this.provideTime;
            _loc_1.scores = this.scores;
            _loc_1.status = this.status;
            _loc_1.type = this.type;
            return _loc_1;
        }// end function

        public function get id() : int
        {
            return this._3355id;
        }// end function

        public function set provideTime(param1:Number) : void
        {
            var _loc_2:* = this._2063817998provideTime;
            if (_loc_2 !== param1)
            {
                this._2063817998provideTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "provideTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set itemListArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._1049685640itemListArray;
            if (_loc_2 !== param1)
            {
                this._1049685640itemListArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemListArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get scores() : int
        {
            return this._907766751scores;
        }// end function

        public function set desc(param1:String) : void
        {
            var _loc_2:* = this._3079825desc;
            if (_loc_2 !== param1)
            {
                this._3079825desc = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desc", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set expiredTime(param1:Number) : void
        {
            var _loc_2:* = this._92515438expiredTime;
            if (_loc_2 !== param1)
            {
                this._92515438expiredTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "expiredTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function set isUseNow(param1:int) : void
        {
            var _loc_2:* = this._162030183isUseNow;
            if (_loc_2 !== param1)
            {
                this._162030183isUseNow = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isUseNow", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set id(param1:int) : void
        {
            var _loc_2:* = this._3355id;
            if (_loc_2 !== param1)
            {
                this._3355id = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "id", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function set scores(param1:int) : void
        {
            var _loc_2:* = this._907766751scores;
            if (_loc_2 !== param1)
            {
                this._907766751scores = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scores", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get minMedal() : int
        {
            return this._1385169979minMedal;
        }// end function

        public function getItemList(param1:int) : ItemBean
        {
            var _loc_2:* = this.itemListArray[param1] as ItemBean;
            return _loc_2;
        }// end function

        public function get claimedTime() : String
        {
            return this._1530923192claimedTime;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "claimedTime = " + this.claimedTime + "\n");
            _loc_2 = _loc_2 + (param1 + "desc = " + this.desc + "\n");
            _loc_2 = _loc_2 + (param1 + "expiredTime = " + this.expiredTime + "\n");
            _loc_2 = _loc_2 + (param1 + "id = " + this.id + "\n");
            _loc_2 = _loc_2 + (param1 + "isUseNow = " + this.isUseNow + "\n");
            _loc_2 = _loc_2 + (param1 + "maxMedal = " + this.maxMedal + "\n");
            _loc_2 = _loc_2 + (param1 + "minMedal = " + this.minMedal + "\n");
            _loc_2 = _loc_2 + (param1 + "packageName = " + this.packageName + "\n");
            _loc_2 = _loc_2 + (param1 + "provideTime = " + this.provideTime + "\n");
            _loc_2 = _loc_2 + (param1 + "scores = " + this.scores + "\n");
            _loc_2 = _loc_2 + (param1 + "status = " + this.status + "\n");
            _loc_2 = _loc_2 + (param1 + "type = " + this.type + "\n");
            _loc_3 = 0;
            while (_loc_3 < this.itemListArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getItemList(_loc_3).toDebugString(param1 + "itemList[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function copyTo(param1:PackageBean) : void
        {
            param1.claimedTime = this.claimedTime;
            param1.desc = this.desc;
            param1.expiredTime = this.expiredTime;
            param1.id = this.id;
            param1.isUseNow = this.isUseNow;
            param1.maxMedal = this.maxMedal;
            param1.minMedal = this.minMedal;
            param1.packageName = this.packageName;
            param1.provideTime = this.provideTime;
            param1.scores = this.scores;
            param1.status = this.status;
            param1.type = this.type;
            CommonUtil.arrayCopy(this.itemListArray, param1.itemListArray);
            return;
        }// end function

        public function get type() : int
        {
            return this._3575610type;
        }// end function

        public function setItemList(param1:ItemBean, param2:int) : void
        {
            this.itemListArray[param2] = param1;
            return;
        }// end function

        public function set packageName(param1:String) : void
        {
            var _loc_2:* = this._908759025packageName;
            if (_loc_2 !== param1)
            {
                this._908759025packageName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "packageName", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set status(param1:int) : void
        {
            var _loc_2:* = this._892481550status;
            if (_loc_2 !== param1)
            {
                this._892481550status = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "status", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set maxMedal(param1:int) : void
        {
            var _loc_2:* = this._391026675maxMedal;
            if (_loc_2 !== param1)
            {
                this._391026675maxMedal = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxMedal", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get packageName() : String
        {
            return this._908759025packageName;
        }// end function

        public function get status() : int
        {
            return this._892481550status;
        }// end function

        public function get maxMedal() : int
        {
            return this._391026675maxMedal;
        }// end function

    }
}
