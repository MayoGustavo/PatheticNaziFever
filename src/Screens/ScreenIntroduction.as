package Screens
{
	import Utilities.CustomSound;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class ScreenIntroduction extends Screen
	{
		private var _aSoundIntro:CustomSound;
		public static var _aSoundMenu:CustomSound;
		public function ScreenIntroduction()
		{
			aGraph = new MCIntro();
			_aSoundIntro = new CustomSound(Main.oAssetsManager.mGetSound(4));
			_aSoundMenu = new CustomSound(Main.oAssetsManager.mGetSound(0));
		}
		
		public override function mScreenInitialize():void
		{
			Screen.oMapTileContainer.addChild(aGraph);
			_aSoundIntro.mPlay();
			Main.mainStage.focus = Main.mainStage;
			Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evSkipIntroduction);
		}
		
		public override function mScreenRefresh():void
		{
			if (aGraph.currentFrame == aGraph.totalFrames) 
			{
				aGotoScreen = "ScreenMenu";
			}
		}
		
		protected function evSkipIntroduction(event:KeyboardEvent):void
		{
			aGotoScreen = "ScreenMenu";
		}
			
		public override function mScreenDestroy():void
		{
			Screen.oMapTileContainer.removeChild(aGraph);
			_aSoundIntro.mStop();
			Main.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evSkipIntroduction);
		}
		
	}
}