package autoevony.gui
{
	import autoevony.common.Utils;
	
	import flash.display.Sprite;
	
	import mx.controls.DataGrid;

	public class RowColorDataGrid extends DataGrid {
		override protected function drawRowBackground(s:Sprite, rowIndex:int, y:Number, height:Number, color:uint, dataIndex:int):void {
			if(dataProvider != null) {
				var item:Object;
				if(dataIndex < dataProvider.length) {
      				item = dataProvider[dataIndex];
    			}
   
    			if(item && item.bgColor != null && Utils.isNumeric(item.bgColor)) {
      				color = item.bgColor;
    			}
  			}
			
			super.drawRowBackground(s, rowIndex, y, height, color, dataIndex);
		}
	}
}