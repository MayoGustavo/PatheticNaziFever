package Screens
{
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	
	public class ScreenLogo extends Screen
	{
		public function ScreenLogo()
		{
			aGraph = new MovieClip();
			aGraph = Main.oAssetsManager.mGetMovieClip("MCLogo");
		}
		
		public override function mScreenInitialize():void
		{
			super.mScreenInitialize();
			Screen.oMapTileContainer.addChild(aGraph);
			Main.mainStage.focus = Main.mainStage;
			Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evSkipIntroduction);
		}
		
		public override function mScreenRefresh():void
		{
			if (aGraph.currentFrame == aGraph.totalFrames) 
			{
				aGotoScreen = "ScreenIntroduction";
			}
		}
		
		protected function evSkipIntroduction(event:KeyboardEvent):void
		{
			aGotoScreen = "ScreenIntroduction";
		}
		
		public override function mScreenDestroy():void
		{
			Screen.oMapTileContainer.removeChild(aGraph);
			Main.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evSkipIntroduction);
		}
	}
}