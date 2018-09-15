package Screens
{
	import Utilities.CustomSound;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class ScreenStageSelection extends Screen
	{
		private var _aCurrentOption:int;
		private var _aCursorSound:CustomSound;
		private var _aSelectSound:CustomSound;
		private var _aBackgroundMusic:CustomSound;
		
		public function ScreenStageSelection()
		{
			super();
			aGraph = new MCStageMenu();
			_aCursorSound = new CustomSound(Main.oAssetsManager.mGetSound(1));
			_aSelectSound = new CustomSound(Main.oAssetsManager.mGetSound(7));
			_aBackgroundMusic = new CustomSound(Main.oAssetsManager.mGetSound(2));
		}
		
		public override function mScreenInitialize():void
		{
			Screen.oMapTileContainer.addChild(aGraph);
			_aCurrentOption = 1;
			aGraph.gotoAndStop(_aCurrentOption);
			Main.mainStage.focus = Main.mainStage;
			_aBackgroundMusic.mPlayRepeat();
			Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evHandleMenu);
		}
		
		protected function evHandleMenu(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.RIGHT:
				{
					_aCursorSound.mPlay();
					if (_aCurrentOption == 1) 
					{
						_aCurrentOption = 4;
						aGraph.gotoAndStop(_aCurrentOption);
					}
					else 
					{	
						_aCurrentOption -=1;
						aGraph.gotoAndStop(_aCurrentOption);
					}
					break;
				}
				case Keyboard.LEFT:
				{
					_aCursorSound.mPlay();
					if (_aCurrentOption == 4) 
					{
						_aCurrentOption = 1;
						aGraph.gotoAndStop(_aCurrentOption);
					}
					else 
					{	
						_aCurrentOption +=1;
						aGraph.gotoAndStop(_aCurrentOption);
					}
					break;
				}
				case Keyboard.A:
				case Keyboard.ENTER:
				{
					_aSelectSound.mPlay();
					var vSelectedLevel:String = "ScreenIntroLevel0" + String(_aCurrentOption);
					aGotoScreen = vSelectedLevel;
					break;
				}
				
				case Keyboard.S:
				{
					aGotoScreen = "ScreenMenu";
					break;
				}
			}	
		}
		
		
		public override function mScreenDestroy():void
		{
			Screen.oMapTileContainer.removeChild(aGraph);
			_aBackgroundMusic.mStop();
			Main.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evHandleMenu);
		}
	}
}