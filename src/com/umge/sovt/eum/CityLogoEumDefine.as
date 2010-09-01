package com.umge.sovt.eum
{
    import mx.collections.*;

    public class CityLogoEumDefine extends Object
    {
        private var cityLogo:ArrayCollection;
        private static var instance:CityLogoEumDefine = new CityLogoEumDefine;

        public function CityLogoEumDefine()
        {
            cityLogo = new ArrayCollection();
            this.cityLogo.addItem("images/icon/cityLogo/citylogo_01.png");
            this.cityLogo.addItem("images/icon/cityLogo/citylogo_02.png");
            this.cityLogo.addItem("images/icon/cityLogo/citylogo_03.png");
            this.cityLogo.addItem("images/icon/cityLogo/citylogo_04.png");
            return;
        }// end function

        public static function getCityLogoArray() : ArrayCollection
        {
            return instance.cityLogo;
        }// end function

    }
}
