package autoevony.gui
{
    import flash.events.Event;

    public class ColorSelectEvent extends Event
    {
        public static const COLOR_SELECTED:String = "colorSelected";
        public var pickedColor:uint;
        public function ColorSelectEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, pColor:uint=0xffffff)
        {
            super(type, bubbles, cancelable);
            this.pickedColor = pColor;
        }
        override public function clone():Event{
            return new ColorSelectEvent(type, bubbles, cancelable, pickedColor);
        }
    }
}

