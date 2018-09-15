package Screens
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.events.KeyboardEvent;
	
	public class ScreenIntroLevel04 extends Screen
	{
		private var _aCurrentFrame:int;
		private var _aText:MovieClip;
		
		public function ScreenIntroLevel04()
		{
			_aCurrentFrame = 5;
			aGraph = new MCStageHistory();
			_aText = new MCTextos();
		}
		
		public override function mScreenInitialize():void
		{
			Screen.oMapTileContainer.addChild(aGraph);
			Screen.oMapTileContainer.addChild(_aText);
			_aText.x = aGraph.width / 2 + 445;
			_aText.y = 203;
			aGraph.gotoAndStop(_aCurrentFrame);
			_aText.gotoAndStop(_aCurrentFrame);
			Main.mainStage.focus = Main.mainStage;
			Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evSkipIntroduction);
		}
		
		public override function mScreenRefresh():void
		{
			
		}
		
		protected function evSkipIntroduction(event:KeyboardEvent):void
		{
			aGotoScreen = "ScreenLevel04";
		}
		
		public override function mScreenDestroy():void
		{
			Screen.oMapTileContainer.removeChild(aGraph);
			Screen.oMapTileContainer.removeChild(_aText);
			Main.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evSkipIntroduction);
		}
	}
}