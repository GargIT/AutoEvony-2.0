package com.umge.sovt.eum
{
    import flash.utils.*;
    import flash.xml.*;

    public class GetDataXML extends Object
    {
        private var xmlDoc:XMLDocument;
        private var xmlDic:Dictionary;
        public static var instance:GetDataXML = new GetDataXML;

        public function GetDataXML()
        {
            xmlDoc = new XMLDocument();
            xmlDic = new Dictionary();
            var _loc_1:* = GetDataXML_XMLBuilding;
            var _loc_2:* = GetDataXML_XMLCastleLogo;
            var _loc_3:* = GetDataXML_XMLFort;
            var _loc_4:* = GetDataXML_XMLItem;
            var _loc_5:* = GetDataXML_XMLPlayerLogo;
            var _loc_6:* = GetDataXML_XMLTech;
            var _loc_7:* = GetDataXML_XMLTroop;
            xmlDic["XMLBuilding"] = new XMLDocument(new _loc_1);
            xmlDic["XMLCastleLogo"] = new XMLDocument(new _loc_2);
            xmlDic["XMLFort"] = new XMLDocument(new _loc_3);
            xmlDic["XMLItem"] = new XMLDocument(new _loc_4);
            xmlDic["XMLPlayerLogo"] = new XMLDocument(new _loc_5);
            xmlDic["XMLTech"] = new XMLDocument(new _loc_6);
            xmlDic["XMLTroop"] = new XMLDocument(new _loc_7);
            return;
        }// end function

        public function getXMLDoc(param1:String) : XMLDocument
        {
            switch(param1)
            {
                case "BuildingEumDefine":
                {
                    xmlDoc = xmlDic["XMLBuilding"];
                    break;
                }// end case
                case "CityLogoEumDefine":
                {
                    xmlDoc = xmlDic["XMLCastleLogo"];
                    break;
                }// end case
                case "FortificationEumDefine":
                {
                    xmlDoc = xmlDic["XMLFort"];
                    break;
                }// end case
                case "ItemEumDefine":
                {
                    xmlDoc = xmlDic["XMLItem"];
                    break;
                }// end case
                case "LogoEumDefine":
                {
                    xmlDoc = xmlDic["XMLPlayerLogo"];
                    break;
                }// end case
                case "TechEumDefine":
                {
                    xmlDoc = xmlDic["XMLTech"];
                    break;
                }// end case
                case "TroopEumDefine":
                {
                    xmlDoc = xmlDic["XMLTroop"];
                    break;
                }// end case
                default:
                {
                    break;
                }// end default
            }// end switch
            return xmlDoc;
        }// end function

        public static function getInstance() : void
        {
            if (!instance)
            {
                instance = new GetDataXML;
            }// end if
            return;
        }// end function

    }
}
