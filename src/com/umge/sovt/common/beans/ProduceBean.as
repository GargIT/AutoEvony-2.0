package com.umge.sovt.common.beans
{
    import flash.events.*;
    import mx.events.*;

    public class ProduceBean extends Object implements IEventDispatcher
    {
        private var _424687558costTime:Number;
        private var _1607243192endTime:Number;
        private var _655172108queueId:int;
        private var _109446num:int;
        private var _3575610type:int;
        private var _bindingEventDispatcher:EventDispatcher;

        public function ProduceBean(param1:Object = null)
        {
            var _loc_2:int;
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.costTime != null)
                {
                    this.costTime = param1.costTime;
                }// end if
                if (param1.endTime != null)
                {
                    this.endTime = param1.endTime;
                }// end if
                if (param1.num != null)
                {
                    this.num = param1.num;
                }// end if
                if (param1.queueId != null)
                {
                    this.queueId = param1.queueId;
                }// end if
                if (param1.type != null)
                {
                    this.type = param1.type;
                }// end if
            }// end if
            return;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function get type() : int
        {
            return this._3575610type;
        }// end function

        public function get num() : int
        {
            return this._109446num;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "costTime = " + this.costTime + "\n");
            _loc_2 = _loc_2 + (param1 + "endTime = " + this.endTime + "\n");
            _loc_2 = _loc_2 + (param1 + "num = " + this.num + "\n");
            _loc_2 = _loc_2 + (param1 + "queueId = " + this.queueId + "\n");
            _loc_2 = _loc_2 + (param1 + "type = " + this.type + "\n");
            return _loc_2;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function set num(param1:int) : void
        {
            var _loc_2:* = this._109446num;
            if (_loc_2 !== param1)
            {
                this._109446num = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "num", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function get queueId() : int
        {
            return this._655172108queueId;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function set endTime(param1:Number) : void
        {
            var _loc_2:* = this._1607243192endTime;
            if (_loc_2 !== param1)
            {
                this._1607243192endTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "endTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set queueId(param1:int) : void
        {
            var _loc_2:* = this._655172108queueId;
            if (_loc_2 !== param1)
            {
                this._655172108queueId = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "queueId", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.costTime = this.costTime;
            _loc_1.endTime = this.endTime;
            _loc_1.num = this.num;
            _loc_1.queueId = this.queueId;
            _loc_1.type = this.type;
            return _loc_1;
        }// end function

        public function set costTime(param1:Number) : void
        {
            var _loc_2:* = this._424687558costTime;
            if (_loc_2 !== param1)
            {
                this._424687558costTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "costTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get endTime() : Number
        {
            return this._1607243192endTime;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function copyTo(param1:ProduceBean) : void
        {
            param1.costTime = this.costTime;
            param1.endTime = this.endTime;
            param1.num = this.num;
            param1.queueId = this.queueId;
            param1.type = this.type;
            return;
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

        public function get costTime() : Number
        {
            return this._424687558costTime;
        }// end function

    }
}
