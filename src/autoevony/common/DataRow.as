package autoevony.common
{
	import mx.collections.ArrayCollection;
	
	public class DataRow
	{
		public var col1:Object, col2:Object, col3:Object, col4:Object, col5:Object, col6:Object, col7:Object, col8:Object, col9:Object, col10:Object, col11:Object, col12:Object;
		public var label:Object;
		public var bgColor:Object;

		private function same(d:DataRow) : Boolean {
			if (col1 != d.col1) return false;
			if (col2 != d.col2) return false;
			if (col3 != d.col3) return false;
			if (col4 != d.col4) return false;
			if (col5 != d.col5) return false;
			if (col6 != d.col6) return false;
			if (col7 != d.col7) return false;
			if (col8 != d.col8) return false;
			if (col9 != d.col9) return false;
			if (col10 != d.col10) return false;
			if (col11 != d.col11) return false;
			if (col12 != d.col12) return false;
			if (label != d.label) return false;
			if (bgColor != d.bgColor) return false;
			return true;
		}
		
		public static function copyRowArray(source:ArrayCollection, dest:ArrayCollection) : void {
			if (dest.sort != null) {
				source.sort = dest.sort;
				source.refresh();
			}
			var ind:int;
			for (ind = dest.length - 1; ind >= source.length; ind--) {
				dest.removeItemAt(ind);
			}

			for (ind = 0; ind < Math.min(dest.length, source.length); ind++) {
				if (!dest[ind].same(source[ind])) dest.setItemAt(source[ind], ind);
			}
			
			for (ind = dest.length; ind < source.length; ind++) {
				dest.addItem(source[ind]);
			}
			dest.refresh();
		}
		
		public function DataRow() {
			
		}
	}
}