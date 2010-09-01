package com.umge.sovt.common.beans
{
    import com.umge.sovt.common.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.events.*;
    

    public class AllProduceBean extends Object implements IEventDispatcher
    {
        private var _bindingEventDispatcher:EventDispatcher;
        private var _267085529allProduceQueueArray:ArrayCollection;
        private var _1381039140positionId:int;

        public function AllProduceBean(param1:Object = null)
        {
            var _loc_2:int;
            var _loc_3:ProduceBean;
            _267085529allProduceQueueArray = new ArrayCollection();
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.positionId != null)
                {
                    this.positionId = param1.positionId;
                }// end if
                if (param1.allProduceQueue)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.allProduceQueue.length)
                    {
                        // label
                        _loc_3 = new ProduceBean(param1.allProduceQueue[_loc_2]);
                        this.allProduceQueueArray.addItem(_loc_3);
                        _loc_2++;
                    }// end while
                }// end if
            }// end if
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function set positionId(param1:int) : void
        {
            var _loc_2:* = this._1381039140positionId;
            if (_loc_2 !== param1)
            {
                this._1381039140positionId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "positionId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "positionId = " + this.positionId + "\n");
            _loc_3 = 0;
            while (_loc_3 < this.allProduceQueueArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getAllProduceQueue(_loc_3).toDebugString(param1 + "allProduceQueue[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function set allProduceQueueArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._267085529allProduceQueueArray;
            if (_loc_2 !== param1)
            {
                this._267085529allProduceQueueArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allProduceQueueArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function setAllProduceQueue(param1:ProduceBean, param2:int) : void
        {
            this.allProduceQueueArray[param2] = param1;
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function copyTo(param1:AllProduceBean) : void
        {
            param1.positionId = this.positionId;
            CommonUtil.arrayCopy(this.allProduceQueueArray, param1.allProduceQueueArray);
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.positionId = this.positionId;
            return _loc_1;
        }// end function

        public function getAllProduceQueue(param1:int) : ProduceBean
        {
            var _loc_2:* = this.allProduceQueueArray[param1] as ProduceBean;
            return _loc_2;
        }// end function

        public function get positionId() : int
        {
            return this._1381039140positionId;
        }// end function

        public function get allProduceQueueArray() : ArrayCollection
        {
            return this._267085529allProduceQueueArray;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

    }
}
