package autoevony.player
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	// allow processes to reserve 28 seconds slot
	// return canSend for the first 18 seconds of the allotted time
	
	public class MasterTimer
	{
		private static var masterTimer:MasterTimer = new MasterTimer();
		
		private var timer:Timer;
		private var numSlots:int = 0;
		private var counter:int = 0;
		private var slotSize:int = 28;
		private var sendSlotSize:int = 18;
		private var focus:int = -1;
		
		function MasterTimer() {
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}
		
		public static function getInstance() : MasterTimer { 
			return masterTimer;
		}
		
		public function reserveSlot() : int {
			return numSlots++;
		}

		public function canSend(slot:int) : Boolean {
			if (focus != -1) return (focus == slot);
			
			if (slotSize <= 1) return true;
			return int(counter / slotSize) == slot && counter % slotSize < sendSlotSize;
		}

		public function canReceive(slot:int) : Boolean {
			if (focus != -1) return (focus == slot);
			
			if (slotSize <= 1) return true;
			return int(counter / slotSize) == slot;
		}

		private function onTimer(e:TimerEvent) : void {
			if (numSlots == 0) return;
			counter = (counter+1) % (numSlots * slotSize);
		}
		
		public function setFocus(slot:int) : void {
			focus = slot;
		}
	}
}