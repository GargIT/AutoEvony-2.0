package autoevony.common
{
	import flash.xml.*;
	import mx.collections.ArrayCollection;
	
	public class CommandHelp
	{
        private static var scriptCommands:ArrayCollection = new ArrayCollection();
        private static var goalCommands:ArrayCollection = new ArrayCollection();
        	
		public static function getCommands(HelpType:String="Script"):ArrayCollection {
			
			if (HelpType == "Script") return getScriptCommands();
			else if (HelpType == "Goals") return getGoalCommands();

			return scriptCommands;
		}
		
		public static function getScriptCommands():ArrayCollection {
			if (scriptCommands != null && scriptCommands.length != 0) return scriptCommands;
			
			var _loc_1:* = GetDataXML_XMLScriptCommands;
			
			var xmlDescriptionOfClass:XML = new XML(new _loc_1);
			trace(xmlDescriptionOfClass.toString());
			var nonstaticMethodsXML:XMLList = xmlDescriptionOfClass.method;
		
			var obj:Object = new Object;

			for each (var methodXML:XML in nonstaticMethodsXML) {
				obj = new Object;
				obj.label = methodXML.@name
				obj.desciption = methodXML.@desciption
				obj.example = methodXML.@example
				var parametersXML:XMLList = methodXML.parameter
				var lx:int = 1;
				for each (var parameterXML:XML in parametersXML) {
					obj["parameter" + lx] = parameterXML.@name;
					lx ++;
				}
				
				scriptCommands.addItem(obj);
			}
			return scriptCommands;
		}
		
		public static function getGoalCommands():ArrayCollection {
			if (goalCommands != null && goalCommands.length != 0) return goalCommands;

			var _loc_1:* = GetDataXML_XMLGoalCommands;
			
			var xmlDescriptionOfClass:XML = new XML(new _loc_1);
			trace(xmlDescriptionOfClass.toString());
			var nonstaticMethodsXML:XMLList = xmlDescriptionOfClass.method;
		
			var obj:Object = new Object;

			for each (var methodXML:XML in nonstaticMethodsXML) {
				obj = new Object;
				obj.label = methodXML.@name
				obj.desciption = methodXML.@desciption
				obj.example = methodXML.@example
				var parametersXML:XMLList = methodXML.parameter
				var lx:int = 1;
				for each (var parameterXML:XML in parametersXML) {
					obj["parameter" + lx] = parameterXML.@name;
					lx ++;
				}
				
				goalCommands.addItem(obj);
			}
			return goalCommands;
		}
/* 		public static function getMethods(classOfInterest:Class):ArrayCollection {
			if (CommandInfos != null && CommandInfos.length != 0) return CommandInfos;
			
			var xmlDescriptionOfClass:XML = describeType(classOfInterest);
			trace(xmlDescriptionOfClass.toString());
			var nonstaticMethodsXML:XMLList = xmlDescriptionOfClass.factory.method;
		
			var obj:Object = new Object;

			for each (var methodXML:XML in nonstaticMethodsXML) {
				obj = new Object;
				obj.label = methodXML.@name
				CommandInfos.addItem(obj);
			}
			return CommandInfos;
		} */


	        
	}
}