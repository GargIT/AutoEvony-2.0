package autoevony.scripts
{
	import autoevony.common.ScriptError;
	import autoevony.common.TechType;
	import autoevony.common.Utils;
	import autoevony.event.CityStateCompleteEvent;
	import autoevony.event.CityStateResponseEvent;
	import autoevony.event.ScriptLogEvent;
	import autoevony.net.Connection;
	
	import com.umge.sovt.common.beans.AvailableResearchListBean;
	import com.umge.sovt.common.beans.BuildingBean;
	import com.umge.sovt.common.beans.CastleBean;
	import com.umge.sovt.common.constants.ErrorCode;
	import com.umge.sovt.common.module.CommandResponse;
	import com.umge.sovt.common.module.tech.ResearchResponse;
	import com.umge.sovt.common.server.events.BuildComplate;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.clearTimeout;
	import flash.utils.getQualifiedClassName;
	import flash.utils.setTimeout;

	public class Script extends EventDispatcher
	{
		private var m_script:Array = new Array();
		private var m_city:CityState;
		private var m_curCommandIndex:int = 0;
		private var m_intervalCommand:uint = 0;
		private var m_loopArray:Array = new Array();
		private var m_labelPos:Dictionary = new Dictionary();
		private var m_sleeping:Boolean = false;
		private var m_stopped:Boolean = false;
		private var m_running:Boolean = false;
		private var m_commandComplete:Boolean = false;
		private var m_scriptTimeOut:Timer = new Timer(5000, 1);
		private var m_scriptTimer:Timer = new Timer(1000, 0);
		private var m_stack:Array = new Array;
		
		public static const STOP:String = "ScriptStopEventType";
		public static const NEWLINE:String = "ScriptNewLineEventType";

		public function Script(city:CityState)
		{
			this.m_city = city;

			m_scriptTimeOut.addEventListener(TimerEvent.TIMER_COMPLETE, scriptTimeOut_Complete);
			m_scriptTimer.addEventListener(TimerEvent.TIMER, runScript);

			if (!this.m_city.hasEventListener(CityStateCompleteEvent.TYPE))
			{
				this.m_city.addEventListener(CityStateCompleteEvent.TYPE, handleCityCompleteEvent);
			}
			if (!this.m_city.hasEventListener(CityStateResponseEvent.TYPE))
			{
				this.m_city.addEventListener(CityStateResponseEvent.TYPE, handleCityResponseEvent);
			}
		}

/*************** public functions ***************/

		/**
		 * Sets on what time current command should finish
		 */
		public function expectFinishTime(d:Date) : void
		{
			logMessage("Estimated finish time: " + d.toLocaleString());
		}
		
		public function logError(message:String) : void
		{
			dispatchEvent(new ScriptLogEvent("<font color='#ff0000'>(" + m_city.castle.name + ") - " + message, ScriptLogEvent.ERROR + "</font>"));
		}

		public function logMessage(message:String, color:String = "#000000" ) : void
		{
			dispatchEvent(new ScriptLogEvent("<font color='#ff0000'>(" + m_city.castle.name + ")</font> - <font color='"+ color + "'>" + message + "</font>"));
		}

		public function logBuildAction(action:String, d:Date, b:BuildingBean, c:CastleBean) : void
		{
			logMessage("Performing " + action + " on level " + b.level + " " + b.name);
			expectFinishTime(d);
		}

		public function logResearchAction(action:String, d:Date, t:AvailableResearchListBean, c:CastleBean) : void
		{
			logMessage("Performing " + action + " on level " + t.level + " " + TechType.toString(t.typeId));
			expectFinishTime(d);
		}

		public function getCurrentCommand() : ScriptCommand
		{
			return m_script[m_curCommandIndex] as ScriptCommand;
		}
		
		public function getCurrentCommandIndex() : int
		{
			return m_curCommandIndex;
		}

		public function findLabel(labelName:Object) : int
		{
			var curIndex:int = 0
			var curCommand:ScriptCommand;
			if (labelName == null)
				return -1;

			if (int(labelName) > 0)
			{
				return m_curCommandIndex - (int(labelName) + 1);
			}

			if (labelName in m_labelPos)
				return m_labelPos[labelName];
			while (curIndex < m_script.length)
			{
				curCommand = m_script[curIndex];
				if (curCommand.func == label && curCommand.params[0] == labelName)
					break;
				curIndex+=1;
			}
			return curIndex;
		}
		
		public function logout(params:Array) : void
		{
			var timeOut:String = "now"
			var timeIn:String = "";
			
			if (params.length > 0)
			{
				timeOut = params[0];
			}
			if (params.length > 1)
			{
				timeIn = params[1];
			}
			
			if (timeOut.substr(0,3).toLowerCase() == "now")
			{
				logoutRun();
			}
			else
			{
				timedCommand(new ScriptCommand("logout", logoutRun, null), timeOut);
			}
			
			if (timeIn.length > 0)
			{
				timedCommand(new ScriptCommand("login", loginRun, null), timeIn);	
			}
		}

		/**
		 * Called when a command has been completed, handles errors if any
		 */
		public function notifyCommandFinish(successful:Boolean, err:ScriptError=null) :void
		{
			var result:Boolean = true;

			// if script was forced to stop, return
			if(m_stopped)
			{
				return;
			}

			if(!successful)
			{
				result = handleScriptError(err);
			}

			m_commandComplete = result;
			m_running = !result;
		}

		public function repeat(loopCount:int) : void
		{
			loop(loopCount, 1);
		}

		public function set SetScriptCommands(scriptText:String) : void
		{
			m_script = new Array();

			var lines:Array = scriptText.split(/\r|\n/);
			for(var i:String in lines)
			{
				if(i.length == 0)
					continue;

				// Primitive (full-line) comment support
				if((lines[i].length >= 2) && ("//" == lines[i].substr(0,2)))
					continue;
					
				lines[i] = lines[i].toString().split("//")[0].toString()
				var parts:Array = lines[i].toString().split(/\s+/);
				// remove empty parts
				while(parts.indexOf("") != -1)
					parts.splice(parts.indexOf(""), 1);

				if(parts.length == 0)
					continue;

				var funcName:String = parts[0].toString().toLowerCase();
				checkCommandSyntax(funcName, parts.slice(1));
				switch (parts[0].toString().toLowerCase())
				{
					case "loop":
					case "repeat":
					case "ifgoto":
					case "goto":
					case "label":
					case "print":
					case "sleep":
					case "gosub":
					case "ifgosub":
					case "gosubreturn":
					case "logout":
						this.m_script.push(new ScriptCommand(funcName, this[funcName], parts.slice(1)));
						break;
					default:
						this.m_script.push(new ScriptCommand(funcName, m_city[funcName], parts.slice(1)));
						break;
				}
			}
		}

		public function sleep(time:Object) : void
		{
			m_scriptTimer.stop();
			m_sleeping = true;
			var finishTime:Date;
			var timeInt:int = 0;

			if (time.indexOf(":") > 0)
			{
				if (time.toString().substr(0,1) == "@")
				{
					timeInt = m_city.parseTime(time.toString().replace("@:",""), true);
				}
				else if (time.toString().substr(0,3) == "rnd")
				{
					timeInt = m_city.randomTime(time.toString().replace("rnd:",""));
					trace(time + "(" + timeInt + ")");
				}
				else
				{
					timeInt = m_city.parseTime(time.toString());
				}
			}
			else
			{
				timeInt = int(time);
			}

			timeInt *= 1000;

			finishTime = new Date();
		 	finishTime.setTime(Utils.getServerTime() + timeInt);
		 	logMessage("Sleeping for " + timeInt/1000 + " seconds until " + finishTime.toLocaleTimeString());
			m_intervalCommand = setTimeout(
				function () : void
				{
					m_scriptTimer.start();
					m_sleeping = false;
					notifyCommandFinish(true);
				},
				timeInt);
		}

		public function start(startLine:int = 0) : void {
			if(m_running)
				return;
			if (startLine <= m_script.length && startLine > 0)
			{
				m_curCommandIndex = startLine-1;
			}
			m_stopped = false;
			m_stack = new Array();
			m_scriptTimer.start();
		}

		public function stop() : void {
			m_running = false;
			m_stopped = true;
			clearTimeout(m_intervalCommand);
			m_sleeping = false;
			m_curCommandIndex = 0;
			m_labelPos = new Dictionary();
			m_loopArray = new Array();
			m_scriptTimeOut.reset();
			m_scriptTimer.reset();
			m_city.stopBackgroundProcesses();
			dispatchEvent(new Event(STOP));
		}

/******************** private functions ********************/

		private function checkCommandSyntax(fName:String, params:Array) : void
		{
			try
			{
				if(m_city[fName] != undefined)
				{
					return;
				}

				var func:Object = this;

				if (func[fName] != undefined)
				{
					return;
				}
			}
			catch (e:Error)
			{
				// if made it this far then the command is invalid.
				throw new ArgumentError("Invalid command: " + fName + ".  Aborting script");
			}
		}

		private function handleCityCompleteEvent(c:CityStateCompleteEvent) : void
		{
			var result:Boolean = true;
			var error:ScriptError = null;

			if (c.response is CommandResponse)
			{
				if (c.response.ok != 1)
				{
					result = false;
					error = new ScriptError(c.response.errorMsg, c.response.ok);
				}
			}
			else if (c.response is ScriptError)
			{
				result = false;
				error = c.response as ScriptError;
			}
			else if(typeof(c.response) == "boolean")
			{
				result = c.response;
			}
			else
			{
				result = false;
				error = new ScriptError("'Command Failed' response received", -9999);
			}

			notifyCommandFinish(result, error);
		}

		private function handleCityResponseEvent(r:CityStateResponseEvent) : void
		{
			if (r.response is BuildComplate)
			{
				var b:BuildComplate = r.response as BuildComplate;

				// show estimated finish time
				this.logBuildAction(
					r.message,
					m_city.calcProcessEndDate(b.buildingBean.startTime, b.buildingBean.endTime),
					b.buildingBean,
					m_city.castle);
			}
			if (r.response is ResearchResponse)
			{
				var res:ResearchResponse = r.response as ResearchResponse;
				this.logResearchAction(
					r.message,
					m_city.calcProcessEndDate(res.tech.startTime, res.tech.endTime),
					res.tech,
					m_city.castle);
			}
			else if (r.response is CommandResponse)
			{
				this.logMessage(r.response.ok + ": " + r.response.msg, r.textcolor);
			}
			else if (r.response is String)
			{
				this.logMessage(r.response + " " + r.message, r.textcolor)
			}
		}

		/**
		 * All ScriptError objects sent back from CityState are processed
		 * here.  The various error codes from ResponseDispatcher are handled
		 * here and logged.  Use the switch statement on errorID
		 * to determine how the error should be handled.
		 * err : ScriptError object containing error to be handled
		 * return : If false, then error means command was not finished and
		 *		needs more time.  If this is the case a log message must be generated
		 *		which contains the estimated finish time of the command.
		 *		If true then the command is finished.
		 */
		private function handleScriptError(err:ScriptError) : Boolean
		{
			var runAgain:Boolean = false;
			var complete:Boolean = false;
			var handled:Boolean = false;
			var waitTime:int = 5000;

			if (err == null || err.errorID == 0)
			{
				// invalid error passed in, bug in creator of ScriptError
				logError("Script error occured without a valid error id: " + err.message);
				logError("Stopping script");
				stop();
				return true;
			}

			switch (err.errorID)
			{
				//todo need to redo the error handling instead of creating this giant list of error codes
				case -9999 : // use this as a generic catch all error
				case ErrorCode.ARMY_CANT_SEND_ARMY:
				case ErrorCode.NOT_ENOUGH_TROOP:
				case ErrorCode.HERO_NOT_IN_CASTLE:
				case ErrorCode.PACIFY_NOT_GET_TIME_EXEPTION:
				case ErrorCode.ERROR_BUILDING_POSITION:
				case ErrorCode.BUILD_UNIQUE_BUILDING_EXIST:
				case ErrorCode.INVALID_BUILDING_TYPE:
				case ErrorCode.NO_DEPEND_BUILDING:
				case ErrorCode.RESOURCE_NOT_ENOUGH:
				case ErrorCode.RESOURCE_NOT_ENOUGH_FOR_LOAD:
				case ErrorCode.TECH_RESEARCHING_ALREADY:
				case ErrorCode.NO_DEPEND_TECH:
				case ErrorCode.TECH_REACH_MAX:
				case ErrorCode.NOBILITY_NOT_ENOUGH:
				case ErrorCode.CANT_BATTLE_AFTER_ADV_MOVE:
				case ErrorCode.TOO_MANY_ARMY_FOR_TRAINING_FIELD:
					logMessage(err.message);
					handled = true;
					complete = true;
					break;
				case ErrorCode.TOWNHALL_LEVEL_UNSUPPORT:
				case ErrorCode.INVALID_BUILDING_STATUS:

				// todo fix retry, disabling for now
				/*
					var b:BuildingBean = city.currentActiveBuilding();

					if (b == null)
					{
						logMessage("A building is currently building, but unable to find active building");
						handled = true;
						complete = true;
						break;
					}

					var finishTime:Date = new Date(b.endTime);

					logMessage(b.name + " is still building. Waiting until " + finishTime.toLocaleString());

					// try resetting the building status for retry
					for each (var building:BuildingBean in city.castle.buildingsArray)
					{
						if (building.status != BuildingConstants.STATUS_NORMAL)
						{
							building.status = BuildingConstants.STATUS_NORMAL;
						}
					}

					//runAgain = true;
					handled = true;
					complete = false;
					waitTime = finishTime.getTime() - new Date().getTime();
				*/
					// temp code:
					logMessage("A building is still building.  Skipping.  See issue 235 on project page");
					handled = true;
					complete = true;
					break;
				case ErrorCode.ALREADY_UPGRADING_RESEARCH_IN_ACADEMY:
					//todo make research able to retry.
					logMessage(err.message);
					handled = true;
					complete = true;
					break;
				case ErrorCode.ITEM_RULE_ERROR: // ignore
					handled = true;
					complete = true;
					break;
				default:
					logMessage(err.message);
					handled = true;
					complete = true;
					break;				
			}

			if (runAgain)
			{
				if (waitTime < 0)
				{
					waitTime = 5000;
				}
				logMessage("Retrying in " + Math.ceil(waitTime / 1000) + " seconds...");
				sleep("" + (waitTime / 1000));
				m_curCommandIndex--;
				dispatchEvent(new Event(NEWLINE));
			}

			if (!handled)
			{
				logMessage("An unhandled error has occured (email this log to evobot devs):" + err.errorID + " - " + err.message + "\n" + err.getStackTrace());
				logMessage("Stopping script");
				stop();
			}

			return complete;
		}

		private function ifgosub(params:Array) : void
		{
			if(ifCompare(params)) {
				gosub(params[5]);
				return;
			}
			notifyCommandFinish(true);
		}

		private function ifgoto(params:Array) : void
		{
			if(ifCompare(params)) {
				goto(params[5]);
				return;
			}
			notifyCommandFinish(true);
		}
		
		private function ifCompare(params:Array) : Boolean
		{			
			var param1:Object = getValue(params[1]);
			var operator:String = params[2];
			var param2:Object = getValue(params[3]);
			var dest:String = params[5];
			var eval:Boolean = false;

			switch(operator)
			{
				case ">=":
					eval = (param1 >= param2);
					break;
				case ">":
					eval = (param1 > param2);
					break;
				case "<=":
					eval = (param1 <= param2);
					break;
				case "<":
					eval = (param1 < param2);
					break;
				case "==":
				case "=":
					eval = (param1 == param2);
					break;
				case "!=":
				case "<>":
					eval = (param1 != param2);
					break;
			}
			return eval;
		}
		
		private function gosub(labelString:String) : void
		{
			if(m_stack.length > 50) {
				notifyCommandFinish(false, new ScriptError("Stack overflow in gosub command", -9999));
				return;
			}
			m_stack.push(m_curCommandIndex);
			goto(labelString);
		}
		
		private function gosubreturn() : void
		{	
			if(m_stack.length == 0) {
				logMessage("Found gosubreturn without gosub. Skipping...");
				notifyCommandFinish(true);
				return;
			}
			m_curCommandIndex=m_stack.pop();
			m_curCommandIndex;
			logMessage("Returning to line " + (m_curCommandIndex + 1));
 			notifyCommandFinish(true);
 		}
		private function goto(labelString:String) : void
		{
			m_curCommandIndex=findLabel(labelString);
			logMessage("Going to line " + (m_curCommandIndex + 1));
			notifyCommandFinish(true);
		}

		private function print(params:Array) : void
		{
			var message:String = ""

			for (var i:int = 1; i < params.length; i++)
			{
				message += getValue(params[i]) + " ";
			}
			logMessage(message);
			notifyCommandFinish(true);
		}

		private function getValue(param:String) : Object
		{
			var splitParam:Array = param.split(".");
			var output:Object = null;
			if (splitParam.length == 1)
			{
				if (param == "is_building")
				{
					output = (m_city.currentActiveBuilding() != null);
				}
				/*
				Doesn't exist yet.
				else if (param == "is_researching")
				{
					output = (city.currentTechResearching() != null);
				}
				*/
				else if (param == "true")
					output =  true;
				else if (param == "false")
					output =  false;
				else
				{
					if ( String(int(param)) == param)
					{
						output =  int(param);
					}
					else
					{
						output = param;
					}
				}
			}
			else
			{
				var tempObject:Object = this;
				for (var j:int = 0; j < splitParam.length; j++)
				{
					var name:String = splitParam[j]
					if (name.indexOf("(") > 0)
					{
						var functionName:String = name.substring(0, name.indexOf("("));
						var functionParam:Object = getValue(name.substring(name.indexOf("(")+1, name.indexOf(")")));
						trace(functionName + "(" + functionParam + ")");
						try
						{
							tempObject = tempObject[functionName](functionParam);
						}
						catch(exc:Error)
						{
							logMessage("Invalid Reference: " + param);
						}
					}
					else if (name.indexOf('[') > 0)
					{
						var arrayName:String = name.substring(0, name.indexOf('['));
						var arrayParam:int = int(getValue(name.substring(name.indexOf('[')+1, name.indexOf(']'))));
						trace(arrayName + "[" + arrayParam + "]");
						try
						{
							tempObject = tempObject[arrayName][arrayParam];
						}
						catch(exc:Error)
						{
							logMessage("Invalid Reference: " + param);
						}
					}
					else
					{
						tempObject = tempObject[name];
						if (tempObject == null)
						{
							logMessage("Invalid Reference: " + param);
						}
					}
				}
				output = tempObject;
			}
			trace(param + " = " + output + ":" + getQualifiedClassName(output));
			return output;
		}
		
		private function loginRun() : void
		{
			var connection:Connection = Connection.getInstance();
			if (connection.authenticated)
			{
				logMessage("Already connected.  Call logoff before attempting to login");
				notifyCommandFinish(true);
				return;
			}
			
			connection.reconnectTimer.delay = 30000;
			logMessage("Login - Attempting login");	
			connection.reconnectTimer.start();
			
		}
		
		private function logoutRun() : void
		{
			var connection:Connection = Connection.getInstance();
			connection.reconnectTimer.stop();
			connection.disconnect();
			logMessage("Logout - Disconnected");
		}

		private function loop(loopTimes:int=0, label:Object = null) : void
		{
			var loopData:Array = null;
			for (var i:int = 0; i < m_loopArray.length; i++)
			{
				loopData = m_loopArray[i];
				if (loopData[0] == m_curCommandIndex)
					break;
				loopData = null;
			}
			if (loopData == null)
			{
				loopData = new Array(3);
				loopData[0] = m_curCommandIndex;
				loopData[1] = loopTimes
				loopData[2] = 0;
				m_loopArray.push(loopData);
			}
			else
			{
				if (loopData[1] != 0 && loopData[2] >= loopData[1])
				{
					loopData[2] = 0;
				}
			}
			loopData[2] += 1

			// infinite loop when max is zero, otherwise until loopCounter is greater
			if (loopData[1] == 0 || loopData[2] < loopData[1])
			{
				// reset the commandIndex if still below the loop max
				m_curCommandIndex = findLabel(label);
				dispatchEvent(new Event(NEWLINE));
				if (m_curCommandIndex >= m_script.length)
				{
					logMessage("Missing label: " + label);
				}
				else
				{
					if (label == null || int(label) > 0)
					{
						logMessage("Loop " + loopData[2] + "/" + (loopData[1] == 0 ? "~" : loopData[1]));
					}
					else
					{
						logMessage("Loop to label '" + label.toString() + "' - " +loopData[2] + "/" + (loopData[1] == 0 ? "~" : loopData[1]));
					}
				}
			}
			else
			{
				logMessage("Loop end");
			}

			notifyCommandFinish(true);
		}

		private function label(labelStr:String) : void
		{
			m_labelPos[label] = m_curCommandIndex;
			logMessage("Setting label '" + labelStr + "' on line " + (m_curCommandIndex + 1));
			notifyCommandFinish(true);
		}

		private function runCurrentCommand() : void
		{
			var commandTimer:Timer = new Timer(1000);

			commandTimer.addEventListener("timer", function(event:TimerEvent):void {

				if (m_sleeping)
				{
					return;
				}

				// if script was forced to stop, just don't continue
				if(m_stopped)
				{
					commandTimer.stop();
					return;
				}

				if (!Connection.getInstance().paused && Connection.getInstance().authenticated) {
					commandTimer.stop();
					logMessage("Running line " + (m_curCommandIndex+1));
					var command:ScriptCommand = getCurrentCommand();

					try
					{

						switch (command.func)
						{
							case loop:
								// determine if param 0 is a string
								if (command.params[0] != 0 && int(command.params[0]) == 0)
								{
									// support for params being reversed
									loop(int(command.params[1]), command.params[0]);
								}
								else
								{
									loop(int(command.params[0]), command.params[1]);
								}
								break;
							case ifgosub:
								ifgosub(command.params);
								break;
							case ifgoto:
								ifgoto(command.params);
								break;
							case label:
								label(command.params[0]);
								break;
							case gosub:
								gosub(command.params[0]);
								break;	
							case goto:
								goto(command.params[0]);
								break;
							case gosubreturn:
								gosubreturn();
								break;
							case logout:
                                logout(command.params);
                                break;
							case repeat:
								repeat(int(getCurrentCommand().params[0]));
								break;
							case print:
								print(command.params);
								break;
							case sleep:
								sleep(command.params[0]);
								break;
							default:
								// don't throw ScriptError from CityState
								getCurrentCommand().run(m_city);
								break;
						}
					}
					catch(argError:ArgumentError)
					{
						notifyCommandFinish(false, new ScriptError("Problem with parameters in " + command.funcName + " command", -9999));
					}
					catch(err:Error)
					{
						// an unknown error, abort
						notifyCommandFinish(false, new ScriptError(err.message, err.errorID));
					}
					m_curCommandIndex++;
					dispatchEvent(new Event(NEWLINE));
				}
			});
			commandTimer.start();
		}

		private function runScript(e:TimerEvent): void
		{
			// check if command is not complete, but current command is still running
			if (!m_commandComplete && m_running)
			{
				return;
			}

			if(m_curCommandIndex < m_script.length)
			{
				if (m_stopped)
				{
					return;
				}
				m_running = true;
				m_commandComplete = false;
				runCurrentCommand();
			}
			else
			{
				logMessage("Finished script");
				stop();
			}
		}

		private function scriptTimeOut_Complete(e:TimerEvent) : void
		{
			m_scriptTimeOut.reset();
			if (!m_commandComplete)
			{
				notifyCommandFinish(false, new ScriptError("Script action did not complete before timeout!", -5));
			}
		}
		
		/**
		 * Runs a command at a specific time.
		 * Note this is woefully incomplete.  This is only being
		 * added to handle the login/logoff commands for now.
		 * This function will need a more comprehensive review
		 * and rewrite later on.
		 */
		private function timedCommand(command:ScriptCommand, time:String) : void
		{
			var runTime:Date;
			var timeInt:int = 0;

			if (time.indexOf(":") > 0)
			{
				if (time.toString().substr(0,1) == "@")
				{
					timeInt = m_city.parseTime(time.toString().replace("@:",""), true);
				}
				else
				{
					timeInt = m_city.parseTime(time.toString());
				}
			}
			else
			{
				timeInt = int(time);
			}

			timeInt *= 1000;

			runTime = new Date();
		 	runTime.setTime(runTime.getTime() + timeInt);
		 	logMessage("Setting " + command.funcName + " to run at " + runTime.toLocaleString());
			// todo capture the return and store in an array or something
			// of setTimeout to allow timed commands to be canceled
			setTimeout(
				function () : void
				{
					command.func.apply(this, command.params);
					
				},
				timeInt);
				
			notifyCommandFinish(true);		
		}
	}
}
