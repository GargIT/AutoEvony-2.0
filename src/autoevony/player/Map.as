package autoevony.player
{
	import com.umge.sovt.client.action.ActionFactory;
	import com.umge.sovt.common.beans.MapCastleBean;
	import com.umge.sovt.common.constants.AllianceConstants;
	import com.umge.sovt.common.module.common.MapInfoSimpleResponse;
	import com.umge.sovt.common.module.field.OtherFieldInfoResponse;
	
	import flash.display.*;
	import flash.events.TimerEvent;
	import flash.geom.*;
	import flash.net.SharedObject;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class Map
	{
		public static var fieldNames:Array = new Array("", "Forest", "Desert", "Hill", "Swamp",
			"GrassLand", "Lake", "", "", "", "Flat", "Castle", "NPC"
		);
		
		private static var playerName:String;
		public static var mapImage:Bitmap = new Bitmap();		
		private static var timer:Timer = null;
		public static var map:Array = new Array();
		public static var detail:Array = new Array();
		private static var castles:Array = new Array;
		private static var pendingFieldId:Array = new Array();
		
		public static var WIDTH:int = 800;
		public static var HEIGHT:int = 800;
		private static var WSIZE:int = 10;

		public static var colorENEMY_ALLIANCE:uint = 0xff7878;
		public static var colorFRIEND_ALLIANCE:uint = 0xbebeff;
		public static var colorSAME_ALLIANCE:uint = 0xbeffbe;
		public static var colorMIDDLE_ALLIANCE:uint = 0xeedeee;
		public static var colorPLAYER:uint = 0xebf310;
		public static var colorBACKGROUND:uint = 0x000000;
		public static var colorNPC:uint = 0xf0ebeb;
		public static var colorNPC5:uint = 0xf0ebeb;
		public static var colorNPC10:uint = 0xe6e1e1;
		public static var colorFlat:uint = 0xFFFFFF;
		public static var colorFlat5:uint = 0xFFFFFF;
		public static var colorFlat10:uint = 0xFFFFFF;
		public static var colorUNKOWNFIELD:uint = 0xFFFFFF;
		
		private var service:HTTPService 

        public function useHttpService(parameters:Object):void {
                service = new HTTPService();
                service.url = "http://localhost/mysqltest.php";
                service.method = "POST";
                service.addEventListener("result", httpResult);
                service.addEventListener("fault", httpFault);
                service.send(parameters);
        }

        public function httpResult(event:ResultEvent):void {
                var result:Object = event.result;
            //Do something with the result.
        }

        public function httpFault(event:FaultEvent):void {
                var faultstring:String = event.fault.faultString;
                Alert.show(faultstring);
        }
            
				
		public static function initMap(width:int, height:int, playername:String) : void {
			playerName = playername;
			WIDTH = width;
			HEIGHT = height;
			mapImage.bitmapData = new BitmapData(WIDTH, HEIGHT, false, colorBACKGROUND);
			
			var mapSettings:SharedObject = SharedObject.getLocal("mapSettings");
			if (mapSettings.size > 0)
			{
				try	{
					colorBACKGROUND = mapSettings.data.colorBACKGROUND;
					colorENEMY_ALLIANCE = mapSettings.data.colorENEMY_ALLIANCE;
					colorFRIEND_ALLIANCE = mapSettings.data.colorFRIEND_ALLIANCE;
					colorMIDDLE_ALLIANCE = mapSettings.data.colorMIDDLE_ALLIANCE;
					colorSAME_ALLIANCE = mapSettings.data.colorSAME_ALLIANCE;
					colorUNKOWNFIELD = mapSettings.data.colorUNKOWNFIELD;
					colorNPC10 = mapSettings.data.colorNPC10;
					colorNPC5 = mapSettings.data.colorNPC5;
					colorNPC = mapSettings.data.colorNPC;
					colorPLAYER = mapSettings.data.colorPLAYER;
					colorFlat = mapSettings.data.colorFlat;
					colorFlat5 = mapSettings.data.colorFlat5;
					colorFlat10 = mapSettings.data.colorFlat10;
				}
				catch(error:Error) {
				}
				
			}
			
		}
		
		public static function resetMap() : void {
			map = new Array();
			detail = new Array();
			mapImage.bitmapData = new BitmapData(WIDTH, HEIGHT, false, colorBACKGROUND);
		}

		public static function fullResetMap() : void {
			map = new Array();
			detail = new Array();
			castles = new Array();
		}

		public static function resetArea(cx:int, cy:int, r:int) : void {
			for (var x:int = cx-r; x <= cx+r; x++) {
				for (var y:int = cy-r; y <= cy+r; y++) {
					if ((x-cx)*(x-cx) + (y-cy)*(y-cy) > r*r) continue;
					var fieldId:int = getFieldId(x, y);
					if (map[fieldId] != undefined) delete map[fieldId];
				} 
			}
		}
		
		public static function isMapReady(cx:int, cy:int, r:int) : Boolean {
			for (var x:int = cx-r; x <= cx+r; x++) {
				for (var y:int = cy-r; y <= cy+r; y++) {
					if ((x-cx)*(x-cx) + (y-cy)*(y-cy) > r*r) continue;
					if (getLevel(getFieldId(x, y)) == -1) return false;
				} 
			}
			return true;
		}
		
		public static function getRectangle(cx:int, cy:int, r:int) : Rectangle {
			return new Rectangle(cx-r,cy-r,r*2,r*2);
		}		
		public static function getLevel(fieldId:int) : int {
			if (map[fieldId] == undefined || map[fieldId] == null) {
				cacheMap(fieldId);
				return -1;
			}
			return map[fieldId] % 16;
		}
		
		public static function getType(fieldId:int) : int {
			if (map[fieldId] == undefined || map[fieldId] == null) {
				cacheMap(fieldId);
				return -1;
			}
			return map[fieldId] / 16;	
		}

		public static function updateInfo(fieldId:int) : void {
			if (map[fieldId] != undefined) {
				delete map[fieldId];
				setPixel(fieldId, colorBACKGROUND);
			}
			cacheMap(fieldId);
		}
			
		public static function updateDetailInfo(fieldId:int) : void {
			if (detail[fieldId] != undefined) {
				delete detail[fieldId];
			}
			cacheDetail(fieldId);
		}
		
		public static function getDetailInfo(fieldId:int) : MapCastleBean {
			if (detail[fieldId] == undefined) {
				cacheDetail(fieldId);
				return null;
			}
			return detail[fieldId];
		}

		public static function getX(fieldId:int) : int {		
			return fieldId % WIDTH;
		}
		
		public static function getY(fieldId:int) : int {		
			return fieldId / WIDTH;
		}
		
		public static function getFieldId(x:int, y:int) : int {
			if (x >= WIDTH) x -= WIDTH;
			if (x < 0) x += WIDTH;
			if (y >= HEIGHT) y -= HEIGHT;
			if (y < 0) y += HEIGHT;
			
			return y*WIDTH + x;
		}
		
		public static function fieldDistance(field1:int, field2:int) : Number {
			var x1:int = getX(field1), y1:int = getY(field1);
			var x2:int = getX(field2), y2:int = getY(field2);
			var dx:int = Math.abs(x1-x2); dx = Math.min(dx, WIDTH - dx);
			var dy:int = Math.abs(y1-y2); dy = Math.min(dy, HEIGHT - dy);
			return Math.sqrt(dx*dx + dy*dy);
		}

		private static var lastCacheMapTime:Date = null;
		private static function cacheMap(fieldId:int) : void {
			// make sure there is at most 1 cacheMap call every 3 seconds
			if (lastCacheMapTime != null && new Date().getTime() - lastCacheMapTime.getTime() < 2000) return;
			lastCacheMapTime = new Date();
			
			var x:int = getX(fieldId);
			var y:int = getY(fieldId);
			var startx:int = int(x/WSIZE) * WSIZE;
			var starty:int = int(y/WSIZE) * WSIZE;
			trace("Get map at " + startx + "," + starty + ", size: " + WSIZE);
			ActionFactory.getInstance().getCommonCommands().mapInfoSimple(startx, starty, startx+WSIZE-1, starty+WSIZE-1, handleMapInfoSimpleResponse);
		}
		
		private static function handleMapInfoSimpleResponse(response:MapInfoSimpleResponse) : void {
			lastCacheMapTime = null;
			if (response.ok != 1) {
				trace("Unable to obtain map: " + response.msg);
				return;
			}

			if (response.mapStr == null) {
				trace("INVALID MAP RESPONSE RECEIVED -- NO MAP AVAILABLE!!!");
				return;
			}
			
			castles[getFieldId(response.x1, response.y1)] = response.castlesArray;			
			var mapwidth:int = response.x2 - response.x1 + 1;
			for (var y:int = response.y1; y <= response.y2; y++) {
				for (var x:int = response.x1; x <= response.x2; x++) {
					var strPos:int = 2 * ((y-response.y1) * mapwidth + (x-response.x1));
					var fieldId:int = getFieldId(x,y);
					map[fieldId] = int("0x" + response.mapStr.substr(strPos, 2));
					setPixel(fieldId, 0xFFFFFF);					
				}
			}
			setCastlePixels(response.castlesArray);
		}
		
		private static function setCastlePixels(arr:ArrayCollection) : void {
			var col:uint;
			if (arr == null) return;
			for each (var castle:MapCastleBean in arr) {
				col = 0xFFFFFF;
				var params:Object = new MapCastleBean;
				
				params = castle;
				
				
				 
				if (castle.npc) {
					var level:int = getLevel(castle.id);
					col = colorNPC;
					if (level == 5)	col = colorNPC5;
					if (level == 10) col = colorNPC10;
				}
				else if (castle.userName == playerName) {
						col = colorPLAYER;
				}
				else if (castle.relation == AllianceConstants.ENEMY_ALLIANCE) {
						col = colorENEMY_ALLIANCE;
				}
				else if (castle.relation == AllianceConstants.FRIEND_ALLIANCE) {
						col = colorFRIEND_ALLIANCE;
				}
				else if (castle.relation == AllianceConstants.SAME_ALLIANCE) {
						col = colorSAME_ALLIANCE;
				}
				else if (castle.relation == AllianceConstants.MIDDLE_ALLIANCE) {
						col = colorMIDDLE_ALLIANCE;
				}
				setPixel(castle.id,col)
			}
	
		
		}
		public static function setPixel(fieldId:int, color:uint=0x000000) : void {
			if (mapImage == null || mapImage.bitmapData == null) return;		
			var x:int = getX(fieldId);
			var y:int = getY(fieldId);
			
			if (!(map[fieldId] == undefined || map[fieldId] == null)) {
				if (getType(fieldId) ==  10)
				{
					color = colorFlat;
					if (getLevel(fieldId) == 5) {
						color = colorFlat5;	
					} else if (getLevel(fieldId) == 10) {
						color = colorFlat10;
					} 
					
				}
			}
		    mapImage.bitmapData.setPixel(x, y, color);
		}
		
		private static function cacheDetail(fieldId:int) : void {
			if (pendingFieldId.length > 100) return;
			pendingFieldId.push(fieldId);
			
			if (timer == null) {
				timer = new Timer(1500);
				timer.addEventListener(TimerEvent.TIMER, doFetchDetail);
				timer.start();
			}
		}

		private static function doFetchDetail(event:TimerEvent) : void {
			if (pendingFieldId.length == 0) return;
			var fieldId:int = pendingFieldId.pop();
			if (detail[fieldId] == undefined) {
				trace("Get detail info at " + getX(fieldId) + "," + getY(fieldId));
				ActionFactory.getInstance().getFieldCommand().getOtherFieldInfo(fieldId, handleGetFieldInfoResponse);
			}
		}

		private static function handleGetFieldInfoResponse(response:OtherFieldInfoResponse) : void {
			if (response.ok != 1) {
				trace("Unable to obtain field info: " + response.msg);
				return;
			}
			detail[response.bean.id] = response.bean;
			
			if (response.bean.userName == playerName && getType(response.bean.id) != 11)
			{
				setPixel(response.bean.id,0xf5ff96);
			}
		}
		
		public static function fieldIdToString(fieldId:int) : String {
			var x:int = getX(fieldId);
			var y:int = getY(fieldId);
			var level:int = getLevel(fieldId);
			var type:int = getType(fieldId);
			var typeStr:String = (type == -1) ? "" : fieldNames[type];
			var levelStr:String = (level == -1) ? "" : "" + level;
			return typeStr + " " + levelStr + "(" + x + "," + y + ")";
		}
		
		public static function fieldIdToCoordString(fieldId:int) : String {
			var x:int = getX(fieldId);
			var y:int = getY(fieldId);
			return "(" + x + "," + y + ")";
		}
		
		// search known castle by name or alliance
		public static function searchCastles(str:String) : Array {
			var result:Array = new Array();
			str = str.toLowerCase();
			for each (var arr:ArrayCollection in castles) {
				for each (var castle:MapCastleBean in arr) {
					if ((castle.allianceName != null && castle.allianceName.toLowerCase() == str) ||
						(castle.name != null && castle.name.toLowerCase() == str) ||
						(castle.userName != null && castle.userName.toLowerCase() == str)) 
					{
							result.push(castle);
					}
				}
			}
			return result;
		}
		
		// search known castle by name or alliance
		public static function searchEnemyCastles(str:String) : Array {
			var result:Array = new Array();
			str = str.toLowerCase();
			for each (var arr:ArrayCollection in castles) {
				for each (var castle:MapCastleBean in arr) {
					if (castle.relation == AllianceConstants.ENEMY_ALLIANCE) {
						result.push(castle);
					}
				}
			}
			return result;
		}

		public static function allCastles(nwCorner:int, seCorner:int) : Array {
			var x1:int = getX(nwCorner);
			var y1:int = getY(nwCorner);
			var x2:int = getX(seCorner);
			var y2:int = getY(seCorner);
			
			var result:Array = new Array();
			for each (var arr:ArrayCollection in castles) {
				for each (var castle:MapCastleBean in arr) {
					if (castle.npc) continue;
					var x:int = getX(castle.id);
					var y:int = getY(castle.id);
					if ((x-x1)*(x-x2) <= 0 && (y-y1)*(y-y2) <= 0) result.push(castle);
				}
			}
			return result;
		}

		public static function mapCastles(cx:int, cy:int, r:int) : Array {
			var x1:int = cx-r;
			var y1:int = cy-r;
			var x2:int = cx+r;
			var y2:int = cy+r;
				
			var result:Array = new Array();
			for each (var arr:ArrayCollection in castles) {
				for each (var castle:MapCastleBean in arr) {
					//if (castle.npc) continue;
					var x:int = getX(castle.id);
					var y:int = getY(castle.id);
					if ((x-x1)*(x-x2) <= 0 && (y-y1)*(y-y2) <= 0) result[castle.id] = castle;
				}
			}
			return result;
		}
		
		public static function coordStringToFieldId(coords:String) : int {			
			var first:int;
			var second:int;
			coords = coords.replace(".", ",");
			var coordArray:Array = coords.split(",");
			
			if (coordArray.length == 2)
			{
				first = int(coordArray[0]);
				second = int(coordArray[1]);
				var teststring:String = "" + first + "," + second
				if (teststring == coords && WIDTH > 0 && first < WIDTH && second < HEIGHT)
				{ 
					return second * WIDTH + first;
				}
			}
			
			// -1 == and invalid coord was passed in.
			return -1;
		}
		
		public static function getFieldType(str:String) : int {
			for (var i:int = 0; i < fieldNames.length; i++) {
				if (fieldNames[i].length == 0) continue;
				if (fieldNames[i].toLowerCase() == str.toLowerCase()) return i;
			}
			return -1;
		}
		
		public static function stateName(state:int) : String {
	        	if (state == 1) return "peace";
	        	else if (state == 2) return "truce";
	        	else if (state == 3) return "beginner";
	        	else if (state == 5) return "holiday";
	        	else if (state == 6) return "dream";
	        	else return "state"+state;
	        }
	        
		public static function saveMapSettings() : void {
			var mapSettings:SharedObject = SharedObject.getLocal("mapSettings");
			
			mapSettings.data.colorBACKGROUND = colorBACKGROUND;
			mapSettings.data.colorENEMY_ALLIANCE = colorENEMY_ALLIANCE;
			mapSettings.data.colorFRIEND_ALLIANCE = colorFRIEND_ALLIANCE;
			mapSettings.data.colorMIDDLE_ALLIANCE = colorMIDDLE_ALLIANCE;
			mapSettings.data.colorSAME_ALLIANCE = colorSAME_ALLIANCE;
			mapSettings.data.colorUNKOWNFIELD = colorUNKOWNFIELD;
			mapSettings.data.colorNPC10 = colorNPC10;
			mapSettings.data.colorNPC5 = colorNPC5;
			mapSettings.data.colorNPC = colorNPC;
			mapSettings.data.colorPLAYER = colorPLAYER;
			mapSettings.data.colorFlat = colorFlat;
			mapSettings.data.colorFlat5 = colorFlat5;
			mapSettings.data.colorFlat10 = colorFlat10;
			mapSettings.flush();
			
			refreshBitmap();
		}
		
		public static function refreshBitmap() : void {
			for each (var arr:ArrayCollection in castles) {
				setCastlePixels(arr);
			}
		}	        
	        
	}
}