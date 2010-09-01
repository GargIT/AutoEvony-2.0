package com.umge.sovt.common
{
    import flash.ui.*;
    import mx.managers.*;

    public class MouseManager extends Object
    {
        private static var isBusy:Boolean = false;

        public function MouseManager()
        {
            return;
        }// end function

        public static function setNormal() : void
        {
            if (isBusy)
            {
                try
                {
                    isBusy = false;
                    CursorManager.removeBusyCursor();
                }// end try
                catch (e:Error)
                {
                    Mouse.show();
                }// end if
            }// end catch
            return;
        }// end function

        public static function setBusy() : void
        {
            if (!isBusy)
            {
                try
                {
                    isBusy = true;
                    CursorManager.setBusyCursor();
                }// end try
                catch (e:Error)
                {
                    Mouse.show();
                }// end if
            }// end catch
            return;
        }// end function

    }
}
