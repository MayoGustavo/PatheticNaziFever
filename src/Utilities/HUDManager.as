package Utilities
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import Screens.Screen;

	public class HUDManager
	{
		private var aBackground:MCHud;
		private var aCurrentLife:MCHud;
		private var aTotalLife:MCHud;
		private var aPortrait:MCHud;
		private var aWeaponType:MCHud;
		private var aExist:Boolean;
		
		public function HUDManager()
		{
			aBackground = new MCHud();
			aCurrentLife = new MCHud();
			aTotalLife = new MCHud();
			aPortrait = new MCHud();
			aWeaponType = new MCHud();
			aExist = false;
		}
		
		public function mGetHUDExistanse():Boolean
		{
			if (aExist) 
				return true;
			else
				return false;
		}
		
		public function mBuildHUD(pLife:int, pType:String):void
		{
			mBuildBackground();
			mBuildCurrentLife(pLife);
			mBuildTotalLife();
			mBuildPortrait(pType);
			mBuildWeapon(pType);
			aExist = true;
		}
		
		private function mBuildBackground():void
		{
			aBackground.gotoAndStop(6);
			Screen.oHUDContainer.addChild(aBackground);
			aBackground.x = 96;
			aBackground.y = 96;
		}
		
		private function mBuildCurrentLife(pLife:int):void
		{
			aCurrentLife.gotoAndStop(pLife);
			Screen.oHUDContainer.addChild(aCurrentLife);
			aCurrentLife.x = aBackground.x + aBackground.width / 2 + 30;
			aCurrentLife.y = aBackground.y + 55;
		}
		
		private function mBuildTotalLife():void
		{
			aTotalLife.gotoAndStop(5);
			Screen.oHUDContainer.addChild(aTotalLife);
			aTotalLife.x = aBackground.x + aBackground.width / 2 + 82;
			aTotalLife.y = aBackground.y + 55;
		}
		
		private function mBuildPortrait(pType:String):void
		{
			aPortrait.gotoAndStop(pType);
			Screen.oHUDContainer.addChild(aPortrait);
			aPortrait.x = aBackground.x + 25;
			aPortrait.y = aBackground.y + 30;
		}
		
		private function mBuildWeapon(pType:String):void
		{
			aWeaponType.gotoAndStop(pType+"W");
			Screen.oHUDContainer.addChild(aWeaponType);
			aWeaponType.x = aBackground.x + aBackground.width / 2 + 30;
			aWeaponType.y = aBackground.y + 125;
		}
		
		public function mRemoveHUD():void
		{
			if (aExist) 
			{
				Screen.oHUDContainer.removeChild(aBackground);
				Screen.oHUDContainer.removeChild(aCurrentLife);
				Screen.oHUDContainer.removeChild(aTotalLife);
				Screen.oHUDContainer.removeChild(aPortrait);
				Screen.oHUDContainer.removeChild(aWeaponType);
				aExist = false;
			}
		}
	}
}