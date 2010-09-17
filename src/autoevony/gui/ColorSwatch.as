package autoevony.gui
{
    import flash.display.BitmapData;
    import flash.display.GradientType;
    import flash.events.MouseEvent;
    import flash.geom.Matrix;
    import mx.containers.Canvas;
    import mx.core.FlexSprite;
    import mx.core.UIComponent;
    [Event(name="colorSelected", type="flexScript.ColorSelectEvent")]
    public class ColorSwatch extends Canvas
    {
        private var colorPicker:UIComponent = new UIComponent();
        private var colors:Array = [0xFF0000, 0xFFFF00, 0x00FF00, 0x00FFFF,0x0000FF, 0xFF00FF, 0xFF0000];
        private var alphas:Array = [1, 1, 1, 1, 1, 1, 1];
        private var ratios:Array = [0, 42, 84, 126, 168, 210, 255];
        private var spectrum:UIComponent;
        private var picker:UIComponent = new UIComponent();
        private var SwatchSize:Number = 150;
        private var selectedColor:uint;
        private var tmpDta:BitmapData;

        public function ColorSwatch()
        {
            super();
            width = SwatchSize;
            height = SwatchSize;
            spectrum = drawGradientBox(SwatchSize, colors, alphas, ratios, 0);
            picker.addChild(spectrum);
            colors = [0x000000, 0x000000];
            alphas = [1, 0];
            ratios = [0, 255];
            var overlay:FlexSprite = drawGradientBox(SwatchSize, colors, alphas, ratios, deg2rad(-90));
            picker.addChild(overlay);
            addChild(picker);
            picker.addEventListener(MouseEvent.MOUSE_DOWN, onDown, false,0,true);
        }
        private function drawGradientBox(size:uint, col:Array, alp:Array, rat:Array, matRot:Number):UIComponent{
            var ui:UIComponent = new UIComponent();
            var mat:Matrix = new Matrix();
            var fill:String = GradientType.LINEAR;
            mat.createGradientBox(size,size,matRot,0,0);
            ui.graphics.beginGradientFill(fill,col,alp,rat,mat);
            ui.graphics.drawRect(0,0,size,size);
            ui.graphics.endFill();
            return ui;
        }

        private function onDown(e:MouseEvent):void{
            tmpDta = new BitmapData(SwatchSize, SwatchSize);
            tmpDta.draw(picker);
            if(spectrum.hitTestPoint(parent.mouseX,parent.mouseY,true)){
                selectedColor = tmpDta.getPixel(spectrum.mouseX, spectrum.mouseY);
                dispatchEvent(new ColorSelectEvent(ColorSelectEvent.COLOR_SELECTED,true,false,selectedColor));
            }
        }
        private function deg2rad(deg:Number):Number {
            return deg * (Math.PI/180);
        }
    }
}

