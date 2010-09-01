package autoevony.common
{
	public class ScriptError extends Error
	{
		public function ScriptError(message:String, errId:int)
		{
			super(message, errId);
		}

	}
}