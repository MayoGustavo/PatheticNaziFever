package Screens
{
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class ScreenHowToPlay extends Screen
	{
		public function ScreenHowToPlay()
		{
			aGraph = new MCHowTo();
		}
		
		public override function mScreenInitialize():void
		{
			Screen.oMapTileContainer.addChild(aGraph);
			Main.mainStage.focus = Main.mainStage;
			Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evGotoMenu);
		}
		
		protected function evGotoMenu(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.S || event.keyCode == Keyboard.A) 
			{
				aGotoScreen = "ScreenMenu";		
			}
		}
		
		public override function mScreenDestroy():void
		{
			Screen.oMapTileContainer.removeChild(aGraph);
			Main.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evGotoMenu);
		}
	}
}