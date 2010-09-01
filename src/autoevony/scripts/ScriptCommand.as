package autoevony.scripts
{
	/**
	* Runs a single command on the provided city object
	*/
	public class ScriptCommand
	{

		public var func:Function;
		public var funcName:String
		public var params:Array;
		public function ScriptCommand(name:String, f:Function, p:Array) : void
		{
			funcName = name;
			func = f;
			params = p;
		}

		public function run(city:CityState) : void {
			func.apply(city, params);
		}
	}
}