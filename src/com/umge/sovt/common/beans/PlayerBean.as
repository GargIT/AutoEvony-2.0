package com.umge.sovt.common.beans
{
    import com.umge.sovt.common.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.events.*;

    public class PlayerBean extends Object implements IEventDispatcher
    {
        private var _230483579newReportCount:int;
        private var _117401885packageBeanArray:ArrayCollection;
        private var _1425640839itemsArray:ArrayCollection;
        private var _1651231951changedFace:Boolean;
        private var _902435682castlesArray:ArrayCollection;
        private var _811312386redCount:int;
        private var _1378032427enemyArmysArray:ArrayCollection;
        private var _2032248903buffsArray:ArrayCollection;
        private var _167675003mapSizeX:int;
        private var _167675004mapSizeY:int;
        private var _1432206175finishedQuestCount:int;
        private var _1102495504saleItemBeansArray:ArrayCollection;
        private var _989948789gameSpeed:int;
        private var _2041542881newReportCount_army:int;
        private var _925069225saleTypeBeansArray:ArrayCollection;
        private var _29843496newMailCount:int;
        private var _1918704276friendBeansArray:ArrayCollection;
        private var _704639681friendArmysArray:ArrayCollection;
        private var _1123696564newReportCount_other:int;
        private var _859583983selfArmysArray:ArrayCollection;
        private var _248723404currentDateTime:String;
        private var _bindingEventDispatcher:EventDispatcher;
        private var _1484814694gamblingItemIndex:int;
        private var _601235430currentTime:Number;
        private var _675024588castleSignBeanArray:ArrayCollection;
        private var _1119145312newReportCount_trade:int;
        private var _1461815869blockBeansArray:ArrayCollection;
        private var _2026418520newMaileCount_inbox:int;
        private var _2095520559playerInfo:PlayerInfoBean;
        private var _1902496333newMaileCount_system:int;

        public function PlayerBean(param1:Object = null)
        {
            var _loc_2:int;
            var _loc_3:PlayerInfoBean;
            var _loc_4:BuffBean;
            var _loc_5:CastleSignInfoBean;
            var _loc_6:CastleBean;
            var _loc_7:ArmyBean;
            var _loc_8:ArmyBean;
            var _loc_9:PlayerInfoBean;
            var _loc_10:ItemBean;
            var _loc_11:PackageBean;
            var _loc_12:SaleItemBean;
            var _loc_13:SaleTypeBean;
            var _loc_14:ArmyBean;
            _1461815869blockBeansArray = new ArrayCollection();
            _2032248903buffsArray = new ArrayCollection();
            _675024588castleSignBeanArray = new ArrayCollection();
            _902435682castlesArray = new ArrayCollection();
            _1378032427enemyArmysArray = new ArrayCollection();
            _704639681friendArmysArray = new ArrayCollection();
            _1918704276friendBeansArray = new ArrayCollection();
            _1425640839itemsArray = new ArrayCollection();
            _117401885packageBeanArray = new ArrayCollection();
            _1102495504saleItemBeansArray = new ArrayCollection();
            _925069225saleTypeBeansArray = new ArrayCollection();
            _859583983selfArmysArray = new ArrayCollection();
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            if (param1 != null)
            {
                if (param1.changedFace != null)
                {
                    this.changedFace = param1.changedFace;
                }// end if
                if (param1.currentDateTime != null)
                {
                    this.currentDateTime = param1.currentDateTime;
                }// end if
                if (param1.currentTime != null)
                {
                    this.currentTime = param1.currentTime;
                }// end if
                if (param1.finishedQuestCount != null)
                {
                    this.finishedQuestCount = param1.finishedQuestCount;
                }// end if
                if (param1.gamblingItemIndex != null)
                {
                    this.gamblingItemIndex = param1.gamblingItemIndex;
                }// end if
                if (param1.gameSpeed != null)
                {
                    this.gameSpeed = param1.gameSpeed;
                }// end if
                if (param1.mapSizeX != null)
                {
                    this.mapSizeX = param1.mapSizeX;
                }// end if
                if (param1.mapSizeY != null)
                {
                    this.mapSizeY = param1.mapSizeY;
                }// end if
                if (param1.newMailCount != null)
                {
                    this.newMailCount = param1.newMailCount;
                }// end if
                if (param1.newMaileCount_inbox != null)
                {
                    this.newMaileCount_inbox = param1.newMaileCount_inbox;
                }// end if
                if (param1.newMaileCount_system != null)
                {
                    this.newMaileCount_system = param1.newMaileCount_system;
                }// end if
                if (param1.newReportCount != null)
                {
                    this.newReportCount = param1.newReportCount;
                }// end if
                if (param1.newReportCount_army != null)
                {
                    this.newReportCount_army = param1.newReportCount_army;
                }// end if
                if (param1.newReportCount_other != null)
                {
                    this.newReportCount_other = param1.newReportCount_other;
                }// end if
                if (param1.newReportCount_trade != null)
                {
                    this.newReportCount_trade = param1.newReportCount_trade;
                }// end if
                if (param1.playerInfo != null)
                {
                    this.playerInfo = new PlayerInfoBean(param1.playerInfo);
                }// end if
                if (param1.redCount != null)
                {
                    this.redCount = param1.redCount;
                }// end if
                if (param1.blockBeans)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.blockBeans.length)
                    {
                        // label
                        _loc_3 = new PlayerInfoBean(param1.blockBeans[_loc_2]);
                        this.blockBeansArray.addItem(_loc_3);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.buffs)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.buffs.length)
                    {
                        // label
                        _loc_4 = new BuffBean(param1.buffs[_loc_2]);
                        this.buffsArray.addItem(_loc_4);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.castleSignBean)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.castleSignBean.length)
                    {
                        // label
                        _loc_5 = new CastleSignInfoBean(param1.castleSignBean[_loc_2]);
                        this.castleSignBeanArray.addItem(_loc_5);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.castles)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.castles.length)
                    {
                        // label
                        _loc_6 = new CastleBean(param1.castles[_loc_2]);
                        this.castlesArray.addItem(_loc_6);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.enemyArmys)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.enemyArmys.length)
                    {
                        // label
                        _loc_7 = new ArmyBean(param1.enemyArmys[_loc_2]);
                        this.enemyArmysArray.addItem(_loc_7);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.friendArmys)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.friendArmys.length)
                    {
                        // label
                        _loc_8 = new ArmyBean(param1.friendArmys[_loc_2]);
                        this.friendArmysArray.addItem(_loc_8);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.friendBeans)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.friendBeans.length)
                    {
                        // label
                        _loc_9 = new PlayerInfoBean(param1.friendBeans[_loc_2]);
                        this.friendBeansArray.addItem(_loc_9);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.items)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.items.length)
                    {
                        // label
                        _loc_10 = new ItemBean(param1.items[_loc_2]);
                        this.itemsArray.addItem(_loc_10);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.packageBean)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.packageBean.length)
                    {
                        // label
                        _loc_11 = new PackageBean(param1.packageBean[_loc_2]);
                        this.packageBeanArray.addItem(_loc_11);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.saleItemBeans)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.saleItemBeans.length)
                    {
                        // label
                        _loc_12 = new SaleItemBean(param1.saleItemBeans[_loc_2]);
                        this.saleItemBeansArray.addItem(_loc_12);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.saleTypeBeans)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.saleTypeBeans.length)
                    {
                        // label
                        _loc_13 = new SaleTypeBean(param1.saleTypeBeans[_loc_2]);
                        this.saleTypeBeansArray.addItem(_loc_13);
                        _loc_2++;
                    }// end while
                }// end if
                if (param1.selfArmys)
                {
                    _loc_2 = 0;
                    while (_loc_2 < param1.selfArmys.length)
                    {
                        // label
                        _loc_14 = new ArmyBean(param1.selfArmys[_loc_2]);
                        this.selfArmysArray.addItem(_loc_14);
                        _loc_2++;
                    }// end while
                }// end if
            }// end if
            return;
        }// end function

        public function set saleItemBeansArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._1102495504saleItemBeansArray;
            if (_loc_2 !== param1)
            {
                this._1102495504saleItemBeansArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "saleItemBeansArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function setFriendBeans(param1:PlayerInfoBean, param2:int) : void
        {
            this.friendBeansArray[param2] = param1;
            return;
        }// end function

        public function get selfArmysArray() : ArrayCollection
        {
            return this._859583983selfArmysArray;
        }// end function

        public function getItems(param1:int) : ItemBean
        {
            var _loc_2:* = this.itemsArray[param1] as ItemBean;
            return _loc_2;
        }// end function

        public function get saleItemBeansArray() : ArrayCollection
        {
            return this._1102495504saleItemBeansArray;
        }// end function

        public function getCastleSignBean(param1:int) : CastleSignInfoBean
        {
            var _loc_2:* = this.castleSignBeanArray[param1] as CastleSignInfoBean;
            return _loc_2;
        }// end function

        public function set friendBeansArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._1918704276friendBeansArray;
            if (_loc_2 !== param1)
            {
                this._1918704276friendBeansArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendBeansArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get enemyArmysArray() : ArrayCollection
        {
            return this._1378032427enemyArmysArray;
        }// end function

        public function setCastleSignBean(param1:CastleSignInfoBean, param2:int) : void
        {
            this.castleSignBeanArray[param2] = param1;
            return;
        }// end function

        public function get playerInfo() : PlayerInfoBean
        {
            return this._2095520559playerInfo;
        }// end function

        public function get changedFace() : Boolean
        {
            return this._1651231951changedFace;
        }// end function

        public function setBlockBeans(param1:PlayerInfoBean, param2:int) : void
        {
            this.blockBeansArray[param2] = param1;
            return;
        }// end function

        public function set castlesArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._902435682castlesArray;
            if (_loc_2 !== param1)
            {
                this._902435682castlesArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castlesArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function setBuffs(param1:BuffBean, param2:int) : void
        {
            this.buffsArray[param2] = param1;
            return;
        }// end function

        public function set newReportCount_trade(param1:int) : void
        {
            var _loc_2:* = this._1119145312newReportCount_trade;
            if (_loc_2 !== param1)
            {
                this._1119145312newReportCount_trade = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newReportCount_trade", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get currentDateTime() : String
        {
            return this._248723404currentDateTime;
        }// end function

        public function getBlockBeans(param1:int) : PlayerInfoBean
        {
            var _loc_2:* = this.blockBeansArray[param1] as PlayerInfoBean;
            return _loc_2;
        }// end function

        public function getCastles(param1:int) : CastleBean
        {
            var _loc_2:* = this.castlesArray[param1] as CastleBean;
            return _loc_2;
        }// end function

        public function dispatchEvent(param1:Event) : Boolean
        {
            return _bindingEventDispatcher.dispatchEvent(param1);
        }// end function

        public function setSelfArmys(param1:ArmyBean, param2:int) : void
        {
            this.selfArmysArray[param2] = param1;
            return;
        }// end function

        public function getFriendArmys(param1:int) : ArmyBean
        {
            var _loc_2:* = this.friendArmysArray[param1] as ArmyBean;
            return _loc_2;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            _bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function getSaleItemBeans(param1:int) : SaleItemBean
        {
            var _loc_2:* = this.saleItemBeansArray[param1] as SaleItemBean;
            return _loc_2;
        }// end function

        public function set gamblingItemIndex(param1:int) : void
        {
            var _loc_2:* = this._1484814694gamblingItemIndex;
            if (_loc_2 !== param1)
            {
                this._1484814694gamblingItemIndex = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gamblingItemIndex", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set newMaileCount_inbox(param1:int) : void
        {
            var _loc_2:* = this._2026418520newMaileCount_inbox;
            if (_loc_2 !== param1)
            {
                this._2026418520newMaileCount_inbox = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newMaileCount_inbox", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get newReportCount_other() : int
        {
            return this._1123696564newReportCount_other;
        }// end function

        public function get castleSignBeanArray() : ArrayCollection
        {
            return this._675024588castleSignBeanArray;
        }// end function

        public function setPackageBean(param1:PackageBean, param2:int) : void
        {
            this.packageBeanArray[param2] = param1;
            return;
        }// end function

        public function get newMaileCount_system() : int
        {
            return this._1902496333newMaileCount_system;
        }// end function

        public function set enemyArmysArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._1378032427enemyArmysArray;
            if (_loc_2 !== param1)
            {
                this._1378032427enemyArmysArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enemyArmysArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set playerInfo(param1:PlayerInfoBean) : void
        {
            var _loc_2:* = this._2095520559playerInfo;
            if (_loc_2 !== param1)
            {
                this._2095520559playerInfo = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerInfo", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set changedFace(param1:Boolean) : void
        {
            var _loc_2:* = this._1651231951changedFace;
            if (_loc_2 !== param1)
            {
                this._1651231951changedFace = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "changedFace", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            _bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function get finishedQuestCount() : int
        {
            return this._1432206175finishedQuestCount;
        }// end function

        public function set currentDateTime(param1:String) : void
        {
            var _loc_2:* = this._248723404currentDateTime;
            if (_loc_2 !== param1)
            {
                this._248723404currentDateTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentDateTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function getSaleTypeBeans(param1:int) : SaleTypeBean
        {
            var _loc_2:* = this.saleTypeBeansArray[param1] as SaleTypeBean;
            return _loc_2;
        }// end function

        public function set buffsArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._2032248903buffsArray;
            if (_loc_2 !== param1)
            {
                this._2032248903buffsArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buffsArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get gameSpeed() : int
        {
            return this._989948789gameSpeed;
        }// end function

        public function get itemsArray() : ArrayCollection
        {
            return this._1425640839itemsArray;
        }// end function

        public function get mapSizeX() : int
        {
            return this._167675003mapSizeX;
        }// end function

        public function get mapSizeY() : int
        {
            return this._167675004mapSizeY;
        }// end function

        public function setItems(param1:ItemBean, param2:int) : void
        {
            this.itemsArray[param2] = param1;
            return;
        }// end function

        public function set castleSignBeanArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._675024588castleSignBeanArray;
            if (_loc_2 !== param1)
            {
                this._675024588castleSignBeanArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleSignBeanArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get newReportCount() : int
        {
            return this._230483579newReportCount;
        }// end function

        public function get saleTypeBeansArray() : ArrayCollection
        {
            return this._925069225saleTypeBeansArray;
        }// end function

        public function set blockBeansArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._1461815869blockBeansArray;
            if (_loc_2 !== param1)
            {
                this._1461815869blockBeansArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "blockBeansArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set friendArmysArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._704639681friendArmysArray;
            if (_loc_2 !== param1)
            {
                this._704639681friendArmysArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendArmysArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function getFriendBeans(param1:int) : PlayerInfoBean
        {
            var _loc_2:* = this.friendBeansArray[param1] as PlayerInfoBean;
            return _loc_2;
        }// end function

        public function get friendBeansArray() : ArrayCollection
        {
            return this._1918704276friendBeansArray;
        }// end function

        public function set newReportCount_other(param1:int) : void
        {
            var _loc_2:* = this._1123696564newReportCount_other;
            if (_loc_2 !== param1)
            {
                this._1123696564newReportCount_other = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newReportCount_other", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get newReportCount_trade() : int
        {
            return this._1119145312newReportCount_trade;
        }// end function

        public function toObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.changedFace = this.changedFace;
            _loc_1.currentDateTime = this.currentDateTime;
            _loc_1.currentTime = this.currentTime;
            _loc_1.finishedQuestCount = this.finishedQuestCount;
            _loc_1.gamblingItemIndex = this.gamblingItemIndex;
            _loc_1.gameSpeed = this.gameSpeed;
            _loc_1.mapSizeX = this.mapSizeX;
            _loc_1.mapSizeY = this.mapSizeY;
            _loc_1.newMailCount = this.newMailCount;
            _loc_1.newMaileCount_inbox = this.newMaileCount_inbox;
            _loc_1.newMaileCount_system = this.newMaileCount_system;
            _loc_1.newReportCount = this.newReportCount;
            _loc_1.newReportCount_army = this.newReportCount_army;
            _loc_1.newReportCount_other = this.newReportCount_other;
            _loc_1.newReportCount_trade = this.newReportCount_trade;
            _loc_1.playerInfo = this.playerInfo.toObject();
            _loc_1.redCount = this.redCount;
            return _loc_1;
        }// end function

        public function get castlesArray() : ArrayCollection
        {
            return this._902435682castlesArray;
        }// end function

        public function setSaleItemBeans(param1:SaleItemBean, param2:int) : void
        {
            this.saleItemBeansArray[param2] = param1;
            return;
        }// end function

        public function get newMaileCount_inbox() : int
        {
            return this._2026418520newMaileCount_inbox;
        }// end function

        public function get gamblingItemIndex() : int
        {
            return this._1484814694gamblingItemIndex;
        }// end function

        public function set newMailCount(param1:int) : void
        {
            var _loc_2:* = this._29843496newMailCount;
            if (_loc_2 !== param1)
            {
                this._29843496newMailCount = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newMailCount", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set newMaileCount_system(param1:int) : void
        {
            var _loc_2:* = this._1902496333newMaileCount_system;
            if (_loc_2 !== param1)
            {
                this._1902496333newMaileCount_system = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newMaileCount_system", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set saleTypeBeansArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._925069225saleTypeBeansArray;
            if (_loc_2 !== param1)
            {
                this._925069225saleTypeBeansArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "saleTypeBeansArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function setFriendArmys(param1:ArmyBean, param2:int) : void
        {
            this.friendArmysArray[param2] = param1;
            return;
        }// end function

        public function setCastles(param1:CastleBean, param2:int) : void
        {
            this.castlesArray[param2] = param1;
            return;
        }// end function

        public function get buffsArray() : ArrayCollection
        {
            return this._2032248903buffsArray;
        }// end function

        public function get friendArmysArray() : ArrayCollection
        {
            return this._704639681friendArmysArray;
        }// end function

        public function set newReportCount_army(param1:int) : void
        {
            var _loc_2:* = this._2041542881newReportCount_army;
            if (_loc_2 !== param1)
            {
                this._2041542881newReportCount_army = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newReportCount_army", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get blockBeansArray() : ArrayCollection
        {
            return this._1461815869blockBeansArray;
        }// end function

        public function getEnemyArmys(param1:int) : ArmyBean
        {
            var _loc_2:* = this.enemyArmysArray[param1] as ArmyBean;
            return _loc_2;
        }// end function

        public function set finishedQuestCount(param1:int) : void
        {
            var _loc_2:* = this._1432206175finishedQuestCount;
            if (_loc_2 !== param1)
            {
                this._1432206175finishedQuestCount = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "finishedQuestCount", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function toDebugString(param1:String = "") : String
        {
            var _loc_3:int;
            var _loc_2:String;
            _loc_2 = _loc_2 + (param1 + "changedFace = " + this.changedFace + "\n");
            _loc_2 = _loc_2 + (param1 + "currentDateTime = " + this.currentDateTime + "\n");
            _loc_2 = _loc_2 + (param1 + "currentTime = " + this.currentTime + "\n");
            _loc_2 = _loc_2 + (param1 + "finishedQuestCount = " + this.finishedQuestCount + "\n");
            _loc_2 = _loc_2 + (param1 + "gamblingItemIndex = " + this.gamblingItemIndex + "\n");
            _loc_2 = _loc_2 + (param1 + "gameSpeed = " + this.gameSpeed + "\n");
            _loc_2 = _loc_2 + (param1 + "mapSizeX = " + this.mapSizeX + "\n");
            _loc_2 = _loc_2 + (param1 + "mapSizeY = " + this.mapSizeY + "\n");
            _loc_2 = _loc_2 + (param1 + "newMailCount = " + this.newMailCount + "\n");
            _loc_2 = _loc_2 + (param1 + "newMaileCount_inbox = " + this.newMaileCount_inbox + "\n");
            _loc_2 = _loc_2 + (param1 + "newMaileCount_system = " + this.newMaileCount_system + "\n");
            _loc_2 = _loc_2 + (param1 + "newReportCount = " + this.newReportCount + "\n");
            _loc_2 = _loc_2 + (param1 + "newReportCount_army = " + this.newReportCount_army + "\n");
            _loc_2 = _loc_2 + (param1 + "newReportCount_other = " + this.newReportCount_other + "\n");
            _loc_2 = _loc_2 + (param1 + "newReportCount_trade = " + this.newReportCount_trade + "\n");
            if (playerInfo != null)
            {
                _loc_2 = _loc_2 + this.playerInfo.toDebugString(param1 + "playerInfo.");
            }
            else
            {
                _loc_2 = _loc_2 + (param1 + "playerInfo = null\n");
            }// end else if
            _loc_2 = _loc_2 + (param1 + "redCount = " + this.redCount + "\n");
            _loc_3 = 0;
            while (_loc_3 < this.blockBeansArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getBlockBeans(_loc_3).toDebugString(param1 + "blockBeans[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.buffsArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getBuffs(_loc_3).toDebugString(param1 + "buffs[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.castleSignBeanArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getCastleSignBean(_loc_3).toDebugString(param1 + "castleSignBean[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.castlesArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getCastles(_loc_3).toDebugString(param1 + "castles[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.enemyArmysArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getEnemyArmys(_loc_3).toDebugString(param1 + "enemyArmys[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.friendArmysArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getFriendArmys(_loc_3).toDebugString(param1 + "friendArmys[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.friendBeansArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getFriendBeans(_loc_3).toDebugString(param1 + "friendBeans[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.itemsArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getItems(_loc_3).toDebugString(param1 + "items[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.packageBeanArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getPackageBean(_loc_3).toDebugString(param1 + "packageBean[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.saleItemBeansArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getSaleItemBeans(_loc_3).toDebugString(param1 + "saleItemBeans[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.saleTypeBeansArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getSaleTypeBeans(_loc_3).toDebugString(param1 + "saleTypeBeans[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            _loc_3 = 0;
            while (_loc_3 < this.selfArmysArray.length)
            {
                // label
                _loc_2 = _loc_2 + this.getSelfArmys(_loc_3).toDebugString(param1 + "selfArmys[" + _loc_3 + "].");
                _loc_3++;
            }// end while
            return _loc_2;
        }// end function

        public function getBuffs(param1:int) : BuffBean
        {
            var _loc_2:* = this.buffsArray[param1] as BuffBean;
            return _loc_2;
        }// end function

        public function set currentTime(param1:Number) : void
        {
            var _loc_2:* = this._601235430currentTime;
            if (_loc_2 !== param1)
            {
                this._601235430currentTime = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentTime", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set packageBeanArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._117401885packageBeanArray;
            if (_loc_2 !== param1)
            {
                this._117401885packageBeanArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "packageBeanArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function setEnemyArmys(param1:ArmyBean, param2:int) : void
        {
            this.enemyArmysArray[param2] = param1;
            return;
        }// end function

        public function getSelfArmys(param1:int) : ArmyBean
        {
            var _loc_2:* = this.selfArmysArray[param1] as ArmyBean;
            return _loc_2;
        }// end function

        public function copyTo(param1:PlayerBean) : void
        {
            param1.changedFace = this.changedFace;
            param1.currentDateTime = this.currentDateTime;
            param1.currentTime = this.currentTime;
            param1.finishedQuestCount = this.finishedQuestCount;
            param1.gamblingItemIndex = this.gamblingItemIndex;
            param1.gameSpeed = this.gameSpeed;
            param1.mapSizeX = this.mapSizeX;
            param1.mapSizeY = this.mapSizeY;
            param1.newMailCount = this.newMailCount;
            param1.newMaileCount_inbox = this.newMaileCount_inbox;
            param1.newMaileCount_system = this.newMaileCount_system;
            param1.newReportCount = this.newReportCount;
            param1.newReportCount_army = this.newReportCount_army;
            param1.newReportCount_other = this.newReportCount_other;
            param1.newReportCount_trade = this.newReportCount_trade;
            if (playerInfo != null)
            {
                this.playerInfo.copyTo(param1.playerInfo);
            }
            else
            {
                param1.playerInfo = null;
            }// end else if
            param1.redCount = this.redCount;
            CommonUtil.arrayCopy(this.blockBeansArray, param1.blockBeansArray);
            CommonUtil.arrayCopy(this.buffsArray, param1.buffsArray);
            CommonUtil.arrayCopy(this.castleSignBeanArray, param1.castleSignBeanArray);
            CommonUtil.arrayCopy(this.castlesArray, param1.castlesArray);
            CommonUtil.arrayCopy(this.enemyArmysArray, param1.enemyArmysArray);
            CommonUtil.arrayCopy(this.friendArmysArray, param1.friendArmysArray);
            CommonUtil.arrayCopy(this.friendBeansArray, param1.friendBeansArray);
            CommonUtil.arrayCopy(this.itemsArray, param1.itemsArray);
            CommonUtil.arrayCopy(this.packageBeanArray, param1.packageBeanArray);
            CommonUtil.arrayCopy(this.saleItemBeansArray, param1.saleItemBeansArray);
            CommonUtil.arrayCopy(this.saleTypeBeansArray, param1.saleTypeBeansArray);
            CommonUtil.arrayCopy(this.selfArmysArray, param1.selfArmysArray);
            return;
        }// end function

        public function get newMailCount() : int
        {
            return this._29843496newMailCount;
        }// end function

        public function setSaleTypeBeans(param1:SaleTypeBean, param2:int) : void
        {
            this.saleTypeBeansArray[param2] = param1;
            return;
        }// end function

        public function get newReportCount_army() : int
        {
            return this._2041542881newReportCount_army;
        }// end function

        public function set selfArmysArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._859583983selfArmysArray;
            if (_loc_2 !== param1)
            {
                this._859583983selfArmysArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selfArmysArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get currentTime() : Number
        {
            return this._601235430currentTime;
        }// end function

        public function getPackageBean(param1:int) : PackageBean
        {
            var _loc_2:* = this.packageBeanArray[param1] as PackageBean;
            return _loc_2;
        }// end function

        public function set gameSpeed(param1:int) : void
        {
            var _loc_2:* = this._989948789gameSpeed;
            if (_loc_2 !== param1)
            {
                this._989948789gameSpeed = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gameSpeed", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set itemsArray(param1:ArrayCollection) : void
        {
            var _loc_2:* = this._1425640839itemsArray;
            if (_loc_2 !== param1)
            {
                this._1425640839itemsArray = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemsArray", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _bindingEventDispatcher.hasEventListener(param1);
        }// end function

        public function set mapSizeX(param1:int) : void
        {
            var _loc_2:* = this._167675003mapSizeX;
            if (_loc_2 !== param1)
            {
                this._167675003mapSizeX = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mapSizeX", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get packageBeanArray() : ArrayCollection
        {
            return this._117401885packageBeanArray;
        }// end function

        public function set redCount(param1:int) : void
        {
            var _loc_2:* = this._811312386redCount;
            if (_loc_2 !== param1)
            {
                this._811312386redCount = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "redCount", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function set newReportCount(param1:int) : void
        {
            var _loc_2:* = this._230483579newReportCount;
            if (_loc_2 !== param1)
            {
                this._230483579newReportCount = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newReportCount", _loc_2, param1));
            }// end if
            return;
        }// end function

        public function get redCount() : int
        {
            return this._811312386redCount;
        }// end function

        public function set mapSizeY(param1:int) : void
        {
            var _loc_2:* = this._167675004mapSizeY;
            if (_loc_2 !== param1)
            {
                this._167675004mapSizeY = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mapSizeY", _loc_2, param1));
            }// end if
            return;
        }// end function

    }
}
