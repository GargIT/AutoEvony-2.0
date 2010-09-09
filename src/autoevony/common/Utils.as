package autoevony.common
{
	import com.umge.sovt.common.beans.FortificationsBean;
	import com.umge.sovt.common.beans.TroopBean;
	
	public class Utils
	{
		private static var serverTimeAdjust:Number = 0;
		public static function getServerLagTime() : Number { return serverTimeAdjust; }
		public static function setServerTime(serverTime:Number) : void {
			serverTimeAdjust = serverTime - new Date().getTime();
		}
		// similar to setServerTime, but the time source is only a guess
		// time drifting is a big issue if we wish to let the bot to run for a long time
		//   and to deal with cases when computer time is corrected while the bot is running
		public static function setEstimatedServerTime(serverTime:Number) : void {
			var tmpServerTimeAdjust:Number = serverTime - new Date().getTime();
			// cap the change at 5s
			if (tmpServerTimeAdjust > 5000 + serverTimeAdjust) tmpServerTimeAdjust = 5000 + serverTimeAdjust;
			if (tmpServerTimeAdjust < -5000 + serverTimeAdjust) tmpServerTimeAdjust = -5000 + serverTimeAdjust;
			serverTimeAdjust = 0.9 * serverTimeAdjust + 0.1 * tmpServerTimeAdjust;
		}
		public static function getServerTime() : Number {
			return new Date().getTime() + serverTimeAdjust;
		}
		
		public static function trim(str:String):String {
		    for ( var i:int = 0; str.charCodeAt(i) < 33; i++);
		    for ( var j:int = str.length-1; str.charCodeAt(j) < 33; j--); 
		    return str.substring(i, j+1);
		}
		public static function searchAndReplace(holder:String, searchfor:String, replacement:String) : String {
			var temparray:Array = holder.split(searchfor);
			var holder:String = temparray.join(replacement);
			return (holder);
		}
		
		public static function isNumeric(num:String):Boolean
		{
		    return !isNaN(parseFloat(num));
		}		
		
		public static function rand(min:int, max:int) : int {
			return min + Math.random() * (max - min);
		}
		
		public static function format2(num:int) : String {
			if (num < 10) return "0" + num;
			return "" + num;
		}
		
		public static function getStringBetween(text:String, start:String, end:String) : String {
			var startInd:int = text.indexOf(start);
			if (startInd == -1) return null;
			startInd += start.length;
			var endInd:int = text.indexOf(end, startInd);
			if (endInd == -1) return null;
			var between:String = text.substring(startInd, endInd);
			return between;
		}
		
		public static function formatTime(num:int) : String {
			var days:int = int(num / 3600 / 24);
			var hours:int = int(num / 3600) % 24;
			var minutes:int = int(num / 60) % 60;
			var seconds:int = num % 60;
			if (days > 0) return days + "d:" + hours + "h:" + format2(minutes) + "m:" + format2(seconds);
			if (hours > 0) return hours + "h:" + format2(minutes) + "m:" + format2(seconds);
			return format2(minutes) + "m:" + format2(seconds);			
		}
		
		public static function randOrder(size:int) : Array {
			var arr:Array = new Array(size);
			var i:int;
			for (i = 0; i < size; i++) arr[i] = i;
			for (i = size-1; i >= 1; i--) {
				var j:int = Math.floor(Math.random() * i);
				var temp:int = arr[j];
				arr[j] = arr[i];
				arr[i] = temp;
			}
			return arr;
		}

		// return a round number for amount, roundAmount(3452) = 3000, roundAmount(9281) = 9000.
		// return a round number for amount, roundAmount(3452,2) = 3400, roundAmount(9281) = 9200.
		public static function roundAmount(amount:Number , digits:int = 1) : int {
			var eps:Number = 1e-8;		// to counter numerical error
			if (amount <= 0) return 0;
			if (amount < 1000) return 1000;
			var logValue:Number = Math.log(amount) / Math.LN10 + eps;
			var intValue:int = Math.floor(logValue);
			return int(Math.pow(10, logValue-intValue+digits-1)) * Math.pow(10, intValue-digits+1);
		}

		public static function formatNum(num:Number) : String {
			if (num < 0) return "-" + formatNum(-num);
			if (num < 1000) return "" + int(num);
			if (num < 10000) return "" + int(num/10) / 100 + "k";
			if (num < 1000000) return "" + int(num/10) / 100 + "k";
			if (num < 10000000) return "" + int(num/10000) / 100 + "m";
			if (num < 1000000000) return "" + int(num/10000) / 100 + "m";
			return "" + int(num/1000000) + "m";
		}
						
		public static function formatUrl(text:String, url:String) : String {
			return "<u><font color='#4377F9'><a href='event:"+ url + "'>" + text + "</a></font></u>";			
		}

		public static function getTroops(troops:String) : TroopBean
		{
			var troopObj:TroopBean = new TroopBean();
			var troopArray:Array = troops.split(",");

			if (troopArray.length < 1)
			{
				// logVerbose("getTroops - Problem with troops: [" + troops + "]");
				return null;
			}

			for each (var troopItem:String in troopArray)
			{
				var t:Array = troopItem.split(":");
				if (t.length < 1)
				{
					// logVerbose("getTroops - Problem with troop item: [" + troopItem + "]");
					return null;
				}

				switch (t[0].toString().toLowerCase())
				{
					case "wo":
					case "worker":
						troopObj.peasants = int(t[1]);
						break;
					case "w":
					case "warr":
						troopObj.militia = int(t[1]);
						break;
					case "s":
					case "scout":
						troopObj.scouter = int(t[1]);
						break;
					case "p":
					case "pike":
						troopObj.pikemen = int(t[1]);
						break;
					case "sw":
					case "sword":
						troopObj.swordsmen = int(t[1]);
						break;
					case "a":
					case "arch":
						troopObj.archer = int(t[1]);
						break;
					case "c":
					case "cav":
						troopObj.lightCavalry = int(t[1]);
						break;
					case "cata" :
						troopObj.heavyCavalry = int(t[1]);
						break;
					case "t":
					case "tran":
					case "transport":
						troopObj.carriage = int(t[1]);
						break;
					case "b":
					case "balli":
						troopObj.ballista = int(t[1]);
						break;
					case "r":
					case "ram":
						troopObj.batteringRam = int(t[1]);
						break;
					case "cp":
					case "pult":
						troopObj.catapult = int(t[1]);
						break;
					default :
						// logVerbose("getTroops - " + t[0].toString() + " is not a valid troop type"); 
						return null;
				}
			}

			return troopObj;
		}

		public static function getFortifications(troops:String) : FortificationsBean {
			var troopObj:FortificationsBean = new FortificationsBean();
			var troopArray:Array = troops.split(",");

            if (troopArray.length < 1)
            {
                    return null;
            }

            for each (var troopItem:String in troopArray)
            {
                var t:Array = troopItem.split(":");
                if (t.length < 1)
                {
                        return null;
                }

                switch (t[0].toString().toLowerCase())
                {
                    case "tra":
                    case "trap":
                        troopObj.trap = int(t[1]);
                        break;
                    case "ab":
                    case "abatis":
                        troopObj.abatis = int(t[1]);
                        break;
                    case "at":
                    case "archertower":
                        troopObj.arrowTower = int(t[1]);
                        break;
                    case "r":
                    case "rollinglog":
                        troopObj.rollingLogs = int(t[1]);
						break;
                    case "tre":
                    case "rock":
                    case "trebuchet":
                        troopObj.rockfall = int(t[1]);
                        break;
                    default :
                        return null;
            	}
            }

            return troopObj;
        }
        
		public static function getEstimateResources(resources:String) : EstimateResource
		{
			if (resources == "none") return new EstimateResource();
			
			var resourceObj:EstimateResource = new EstimateResource();
			var resourceArray:Array = resources.split(",");
			var resourceType:String = "";

			if (resourceArray.length < 1 || resources.length == 0)
			{
				return null;
			}

			for each (var resourceItem:String in resourceArray)
			{
				var r:Array = resourceItem.split(":");

				// errors in the resource string must be strict and return null if any problems occur
				if (r.length < 1)
				{
					return null;
				}

				resourceType = r[0].toString().toLocaleLowerCase();

				if (resourceType.substr(0,1) == "f")
					resourceType = "food";
				else if (resourceType.substr(0,1) == "g")
					resourceType = "gold";
				else if (resourceType.substr(0,1) == "i")
					resourceType = "iron";
				else if (resourceType.substr(0,1) == "s")
					resourceType = "stone";
				else if (resourceType.substr(0,1) == "w")
					resourceType = "wood";
				else
					return null;

				resourceObj[resourceType] = Number(r[1]);
			}

			return resourceObj;
		}
		
		public static function getSortableDateString(param1:Number) : String
        {
            var _loc_2:* = new Date(param1);
            var year:* = _loc_2.getFullYear();
            var day:* = _loc_2.getDate();
            var month:* = _loc_2.getMonth();
            var hours:* = _loc_2.getHours();
            var minutes:* = _loc_2.getMinutes();
            var secondes:* = _loc_2.getSeconds();
            var datestring:* = new String();
            
            datestring = datestring + year;
            datestring = datestring + "-";
            if ((month + 1) < 10)
            {
                datestring = datestring + "0";
            }
            datestring = datestring + (month + 1);
            datestring = datestring + "-";
            if (day < 10)
            {
                datestring = datestring + "0";
            }
            datestring = datestring + day;
            datestring = datestring + " ";
            if (hours < 10)
            {
                datestring = datestring + "0";
            }
            datestring = datestring + hours;
            datestring = datestring + ":";
            if (minutes < 10)
            {
                datestring = datestring + "0";
            }
            datestring = datestring + minutes;
            datestring = datestring + ":";
            if (secondes < 10)
            {
                datestring = datestring + "0";
            }
            datestring = datestring + secondes;
            return datestring;
        }
        
	}
}