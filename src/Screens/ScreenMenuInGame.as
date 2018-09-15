package Screens
{
	import Utilities.CustomSound;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class ScreenMenuInGame extends EventDispatcher
	{
		private var aGraph:MovieClip;
		private var _aCursor:CursorHandler;
		private var _aCurrentOption:int;
		private var _OpenMenuSound:CustomSound = new CustomSound(Main.oAssetsManager.mGetSound(5));
		private var _aCursorSound:CustomSound = new CustomSound(Main.oAssetsManager.mGetSound(1));
		private var _aSelectSound:CustomSound = new CustomSound(Main.oAssetsManager.mGetSound(7));
		
		public function ScreenMenuInGame()
		{
			aGraph = new MCMenuIngame();
		}
		
		public function mScreenInitialize():void
		{
			_aCursor = new CursorHandler();
			Screen.oHUDContainer.addChild(aGraph);
			aGraph.x = Main.mainStage.width / 2 - aGraph.width / 2;
			aGraph.y = Main.mainStage.height / 2 - aGraph.height / 2;
			Screen.oHUDContainer.addChild(_aCursor);
			_aCursor.x = aGraph.x + 20;
			_aCursor.y = aGraph.y + 20;
			_OpenMenuSound.mPlay();
			_aCurrentOption = 1;
			Main.mainStage.focus = Main.mainStage;
			Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evHandlerMenu);
		}
		
		protected function evHandlerMenu(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.UP:
				{
					_aCursorSound.mPlay();
					if (_aCurrentOption == 1) 
					{
						_aCurrentOption = 5;
						_aCursor.y = 956;
					}
					else 
					{	
						_aCurrentOption -=1;
						_aCursor.y -= 170;
					}
					break;
				}
				case Keyboard.DOWN:
				{
					_aCursorSound.mPlay();
					if (_aCurrentOption == 5) 
					{
						_aCurrentOption = 1;
						_aCursor.y = aGraph.y + 20;
						trace(aGraph.y + 20);
					}
					else 
					{	
						_aCurrentOption +=1;
						_aCursor.y += 170;
					}
					break;
				}
				case Keyboard.A:
				case Keyboard.ENTER:
				{
					_aSelectSound.mPlay();
					switch(_aCurrentOption)
					{
						case 1:
						{
							mScreenDestroy();
							dispatchEvent(new Event("RESTART"));
							break;
						}
							
						case 2:
						{	
							mScreenDestroy();
							dispatchEvent(new Event("MENU"));
							break;
						}
						
						case 3:
						{	
							mScreenDestroy();
							dispatchEvent(new Event("SAVE"));
							break;
						}
							
						case 4:
						{	
							mScreenDestroy();
							dispatchEvent(new Event("LOAD"));
							break;
						}
							
						case 5:
						{	
							mScreenDestroy();
							dispatchEvent(new Event("RETURN"));
							break;
						}
					}
				}
					break;
			}
		}
		
		public function mScreenDestroy():void
		{
			Screen.oHUDContainer.removeChild(aGraph);
			Screen.oHUDContainer.removeChild(_aCursor);
			Main.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evHandlerMenu);
		}
	}
}