package Maps
{
	import Screens.Screen;
	
	import Utilities.CustomSound;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class ActionMenu extends EventDispatcher
	{
		private const _eventMove:String = "MOVECHARACTER";
		private const _eventAttack:String = "ATTACKCHARACTER";
		private const _eventCancel:String = "CANCELACTION";
		
		private var _aGraphic:MovieClip;
		private var _aExists:Boolean;
		private var _aCurrentOption:int;
		private var _aCursorSound:CustomSound;
		private var _aSelectSound:CustomSound;
		
		public function ActionMenu()
		{
			_aGraphic = new MCAccionMenu();
			_aCurrentOption = 1;
			_aGraphic.gotoAndStop(_aCurrentOption);
			_aCursorSound = new CustomSound(Main.oAssetsManager.mGetSound(1));
			_aSelectSound = new CustomSound(Main.oAssetsManager.mGetSound(7));
		}
		
		public function mCreateActionMenu():void
		{
			_aExists = true;
			Screen.oHUDContainer.addChild(_aGraphic);
			_aCurrentOption = 1;
			_aGraphic.gotoAndStop(_aCurrentOption);
			_aGraphic.x = Main.mainStage.width / 2 - _aGraphic.width / 2;
			_aGraphic.y = Main.mainStage.height / 2 - _aGraphic.height / 2;
			Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evMenuActionHandler);
		}
		
		protected function evMenuActionHandler(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.UP: //Cancelar
				{
					_aCursorSound.mPlay();
					_aCurrentOption = 4;
					_aGraphic.gotoAndStop(_aCurrentOption);
					break;
				}
				case Keyboard.LEFT: //Mover
				{
					_aCursorSound.mPlay();
					_aCurrentOption = 2;
					_aGraphic.gotoAndStop(_aCurrentOption);
					break;
				}
				case Keyboard.RIGHT: //Atacar
				{
					_aCursorSound.mPlay();
					_aCurrentOption = 3;
					_aGraphic.gotoAndStop(_aCurrentOption);
					break;
				}
				case Keyboard.A: //Aceptar
				{
					trace(_aCurrentOption);
					_aSelectSound.mPlay();
					switch(_aCurrentOption)
					{
						case 2: //Mover
						{
							mDeleteActionMenu();
							dispatchEvent(new Event(_eventMove));
							break;
						}
						case 3: //Atacar
						{
							mDeleteActionMenu();
							dispatchEvent(new Event(_eventAttack));
							break;
						}
						case 4: //Cancelar
						{
							mDeleteActionMenu();
							dispatchEvent(new Event(_eventCancel));
							break;
						}
					}
					break;
				}
					
			}
		}
		
		public function mDeleteActionMenu():void
		{
			if (_aExists) 
			{
				_aExists = false;
				Screen.oHUDContainer.removeChild(_aGraphic);
				Main.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evMenuActionHandler);
			}
		}
	}
}