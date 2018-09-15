package Screens
{
	import Utilities.CustomSound;
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	public class ScreenMenu extends Screen
	{
		//public static var _aSoundMenu:CustomSound;
		private var _aCursor:MovieClip;
		private var _aCurrentOption:int;
		private var _aCursorSound:CustomSound;
		private var _aCursorSelect:CustomSound;
		private var _aFlag:Boolean = false;
		
		public function ScreenMenu()
		{
			aGraph = new MCMainMenu();
			_aCursor = new CursorHandler();
			_aCurrentOption = 1;
			_aCursorSound = new CustomSound(Main.oAssetsManager.mGetSound(1));
			_aCursorSelect = new CustomSound(Main.oAssetsManager.mGetSound(7));
			//_aSoundMenu = new CustomSound(Main.oAssetsManager.mGetSound(0));
		}
		
		public override function mScreenInitialize():void
		{
			Screen.oMapTileContainer.addChild(aGraph);
			ScreenIntroduction._aSoundMenu.mPlayRepeat();
			Main.mainStage.focus = Main.mainStage;
		}
		
		protected function evHandleMenu(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.UP:
				{
					if (_aCurrentOption == 1) 
					{
						_aCursor.y += 420;
						_aCurrentOption = 3;
					}
					else 
					{	_aCursor.y -= 210;
						_aCurrentOption -=1;
					}
					_aCursorSound.mPlay();
					break;
				}
				case Keyboard.DOWN:
				{
					if (_aCurrentOption == 3) 
					{
						_aCursor.y -= 420;
						_aCurrentOption = 1;
					}
					else 
					{	_aCursor.y += 210;
						_aCurrentOption +=1;
					}
					_aCursorSound.mPlay();
					break;
				}
				case Keyboard.A:
				case Keyboard.ENTER:
				{
					switch(_aCurrentOption)
					{
						case 1:
						{	aGotoScreen = "ScreenIntroStageSelection";
							_aCursorSelect.mPlay();
							break;
						}
							
						case 2:
						{	aGotoScreen = "ScreenHowToPlay";
							_aCursorSelect.mPlay();
							break;
						}
						
						case 3:
						{	aGotoScreen = "ScreenOptions";
							_aCursorSelect.mPlay();
							break;
						}
					}
				}
					break;
			}	
		}
		
		public override function mScreenRefresh():void
		{
			if (aGraph.currentFrame == 108) 
			{
				Screen.oMapTileContainer.addChild(_aCursor);
				_aCursor.x = 800;
				_aCursor.y = 380;
				Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evHandleMenu);
			}
		}
		
		public override function mScreenDestroy():void
		{
			Screen.oMapTileContainer.removeChild(aGraph);
			Screen.oMapTileContainer.removeChild(_aCursor);
			if (_aCurrentOption == 1) 
			{
				ScreenIntroduction._aSoundMenu.mStop();
			}
			Main.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evHandleMenu);
		}
	}
}

