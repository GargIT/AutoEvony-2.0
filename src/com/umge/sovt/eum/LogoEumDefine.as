package com.umge.sovt.eum
{
    import mx.collections.*;

    public class LogoEumDefine extends Object
    {
        private var femalePlayerLogo:ArrayCollection;
        private var malePlayerLogo:ArrayCollection;
        private static var instance:LogoEumDefine = new LogoEumDefine;

        public function LogoEumDefine()
        {
            malePlayerLogo = new ArrayCollection();
            femalePlayerLogo = new ArrayCollection();
            this.malePlayerLogo.addItem("images/icon/player/faceA8.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA1.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA2.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA3.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA4.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA5.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA6.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA7.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA9.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA10.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA11.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA12.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA13.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA14.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA15.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA16.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA17.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA18.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA19.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA20.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA21.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA22.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA23.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA24.jpg");
            this.malePlayerLogo.addItem("images/icon/player/faceA25.jpg");
            this.femalePlayerLogo.addItem("images/icon/player/faceB1.jpg");
            this.femalePlayerLogo.addItem("images/icon/player/faceB2.jpg");
            this.femalePlayerLogo.addItem("images/icon/player/faceB3.jpg");
            this.femalePlayerLogo.addItem("images/icon/player/faceB4.jpg");
            this.femalePlayerLogo.addItem("images/icon/player/faceB5.jpg");
            this.femalePlayerLogo.addItem("images/icon/player/faceB6.jpg");
            this.femalePlayerLogo.addItem("images/icon/player/faceB7.jpg");
            this.femalePlayerLogo.addItem("images/icon/player/faceB8.jpg");
            this.femalePlayerLogo.addItem("images/icon/player/faceB9.jpg");
            return;
        }// end function

        public static function getFemalePlayerLogoArray() : ArrayCollection
        {
            return instance.femalePlayerLogo;
        }// end function

        public static function getMalePlayerLogoArray() : ArrayCollection
        {
            return instance.malePlayerLogo;
        }// end function

    }
}
