package autoevony.common
{
	import com.umge.sovt.eum.GetDataXML;
	
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	public class Items
	{
		private static var dataXML:GetDataXML = new GetDataXML();
		private static var externalItemNames:Array = null;
		
		public function Items()
		{
		}
		private static function initExternalItemNames() : void {
			var xml:XMLDocument = dataXML.getXMLDoc("ItemEumDefine");
			var countSameItemNames:Array = new Array();

			externalItemNames = new Array();
			for each(var node:XMLNode in xml.firstChild.nextSibling.childNodes) {
				if (node.attributes.id == undefined || node.attributes.name == undefined) continue;
				var name:String = Utils.trim(node.attributes.name);
				if (countSameItemNames[name] == undefined) {
					countSameItemNames[name] = 0;
				} else {
					countSameItemNames[name]++;
					name = name + countSameItemNames[name]; 	// create a different name
				}
				externalItemNames[Utils.trim(node.attributes.id)] = name;
			}
		}
		public static function getItemName(str:String) : String {
			if (externalItemNames == null) initExternalItemNames();
			if (externalItemNames[str] == undefined) {
				return str;
			} else {
				return externalItemNames[str];
			}
		}

		public static function getItemId(str:String) : String {
			if (externalItemNames == null) initExternalItemNames();
			for (var id:String in externalItemNames) {
				if (externalItemNames[id].toLowerCase() == str.toLowerCase()) return id;
			}
			return null;
		}		
	}
}