package Screens
{
	import Utilities.CustomSound;
	
	import fl.motion.AdjustColor;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.KeyboardEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	
	import flashx.textLayout.formats.BackgroundColor;

	public class ScreenOptions extends Screen
	{
		private var _aCurrentOption:int;
		private var _aColorFilter:AdjustColor = new AdjustColor();
		private var _aColorMatrix:ColorMatrixFilter;
		private var _aMatrix:Array = [];
		private var _aMovieClip:Sprite = new Sprite();
		private var _aBrightness:int = 0;
		private var _aContrast:int = 0;
		private var _aTransform:SoundTransform = new SoundTransform();
		
		private var _aSoundBar:MCSonido = new MCSonido();
		private var _aBrightnessBar:MCBrillo = new MCBrillo();
		private var _aContrastBar:MCContraste = new MCContraste();
		private var _aCursor:CursorHandler = new CursorHandler();
		private var _aFullScreen:MCFullScreen = new MCFullScreen();
		private var _aCheckFS:MCCheckBox = new MCCheckBox();
		private var _aCheckExist:Boolean;
		
		private var _aSoundFrame:int = 10;
		private var _aBrightnessFrame:int = 10;
		private var _aContrastFrame:int = 10;
		private var _aFSFrame:int = 1;
		
		private var _aSoundCursor:CustomSound;
		private var _aSelectSound:CustomSound;
		
		public function ScreenOptions()
		{
			aGraph = new MCOpcionesBk();
			_aCurrentOption = 1;
			_aSoundCursor = new CustomSound(Main.oAssetsManager.mGetSound(1));
			_aSelectSound = new CustomSound(Main.oAssetsManager.mGetSound(7));
		}
		
		public override function mScreenInitialize():void
		{
			super.mScreenInitialize();
			Screen.oMapTileContainer.addChild(aGraph);
			aGraph.gotoAndStop(_aCurrentOption);
			Screen.oMapTileContainer.addChild(_aSoundBar);
			_aSoundBar.gotoAndStop(_aSoundFrame);
			_aSoundBar.x = 500;
			_aSoundBar.y = 600;
			Screen.oMapTileContainer.addChild(_aBrightnessBar);
			_aBrightnessBar.gotoAndStop(_aBrightnessFrame);
			_aBrightnessBar.x = 500;
			_aBrightnessBar.y = 200;
			Screen.oMapTileContainer.addChild(_aContrastBar);
			_aContrastBar.gotoAndStop(_aContrastFrame);
			_aContrastBar.x = 500;
			_aContrastBar.y = 400;
			Screen.oMapTileContainer.addChild(_aCursor);
			_aCursor.x = 300;
			_aCursor.y = 180;
			Screen.oMapTileContainer.addChild(_aFullScreen);
			_aFullScreen.x = 500;
			_aFullScreen.y = 1000;
			Screen.oMapTileContainer.addChild(_aCheckFS);
			_aCheckFS.x = 880;
			_aCheckFS.y = 1000;
			_aCheckFS.gotoAndStop(_aFSFrame);
			_aCheckExist = false;
			Main.mainStage.focus = Main.mainStage;
			Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evHandleOptions);
		}
		
		protected function evHandleOptions(event:KeyboardEvent):void
		{
			
			switch(event.keyCode)
			{
				case Keyboard.UP:
				{
					_aSoundCursor.mPlay();
					if (_aCurrentOption == 1) 
					{
						_aCurrentOption = 6;
						_aCursor.y = 1180;
					}
					else 
					{	
						_aCurrentOption -=1;
						_aCursor.y -= 200;
					}
					aGraph.gotoAndStop(_aCurrentOption);
					break;
				}
				case Keyboard.DOWN:
				{
					_aSoundCursor.mPlay();
					if (_aCurrentOption == 6) 
					{
						_aCurrentOption = 1;
						_aCursor.y = 180;
					}
					else 
					{	
						_aCurrentOption +=1;
						_aCursor.y += 200;
					}
					aGraph.gotoAndStop(_aCurrentOption);
					break;
				}
				
				
				case Keyboard.LEFT:
				{
					
					if (_aCurrentOption == 1) 
					{
						if (_aBrightness > -100) 
						{
							mChangeBrightness(false);
						}else if (_aBrightness < -100)
						{	_aBrightness = -99;
							_aBrightnessFrame = 0;
						}
					}
					
					if (_aCurrentOption == 2) 
					{
						if (_aContrast > -100) 
						{
							mChangeContrast(false);
						}else if (_aContrast < -100)
							{_aContrast = -99;
							_aContrastFrame = 0;}
					}
					
					if (_aCurrentOption == 3) 
					{
						mChangeSound(false);
						if (_aSoundFrame < 0) 
							_aSoundFrame = 0;
					}
					break;
				}
				case Keyboard.RIGHT:
				{
					if (_aCurrentOption == 1) 
					{
						if (_aBrightness < 100) 
						{
							mChangeBrightness(true);
						}
						else if (_aBrightness > 100)
									{_aBrightness = 99;
									 _aBrightnessFrame = 20;}
					}
					
					if (_aCurrentOption == 2) 
					{
						if (_aContrast < 100) 
						{
							mChangeContrast(true);
						}
						else if (_aContrast > 100)
						{_aContrast = 99;
							_aContrastFrame = 20;}
					}
					
					
					if (_aCurrentOption == 3) 
					{
						mChangeSound(true);
						if (_aSoundFrame > 20) 
							_aSoundFrame = 20;
					}
						
					break;
				}
				case Keyboard.ENTER:
				case Keyboard.A:
				{
					if (_aCurrentOption == 5) 
					{
						if (_aCheckExist) 
						{
							Main.mainStage.displayState = StageDisplayState.NORMAL; 
							_aFSFrame = 1;
							_aCheckFS.gotoAndStop(_aFSFrame);
							_aCheckExist = false;
						}
						else {
							Main.mainStage.displayState = StageDisplayState.FULL_SCREEN; 
							_aFSFrame = 2;
							_aCheckFS.gotoAndStop(_aFSFrame);
							_aCheckExist = true;
						}
					}
					
					if (_aCurrentOption == 6) 
					{
						_aSelectSound.mPlay();
						aGotoScreen = "ScreenMenu";
					}
					break;
				}
					break;
			}	
		}
		
		private function mChangeBrightness(pAction:Boolean):void
		{
			_aSelectSound.mPlay();
			if (pAction) 
			{
				_aBrightnessFrame += 1;
				_aBrightness += 10;
			}else
			{
				_aBrightnessFrame -= 1;
				_aBrightness -= 10;
			}
			_aBrightnessBar.gotoAndStop(_aBrightnessFrame);
			_aColorFilter.hue = 0;
			_aColorFilter.saturation = 0;
			_aColorFilter.brightness = _aBrightness;
			_aColorFilter.contrast = _aContrast;
			_aMatrix = _aColorFilter.CalculateFinalFlatArray();
			_aColorMatrix = new ColorMatrixFilter(_aMatrix);
			mApplyColorTransform();
		}
		
		private function mChangeContrast(pAction:Boolean):void
		{
			_aSelectSound.mPlay();
			if (pAction) 
			{
				_aContrastFrame += 1;
				_aContrast += 10;
			}else
			{
				_aContrastFrame -= 1;
				_aContrast -= 10;
			}
			_aContrastBar.gotoAndStop(_aContrastFrame);
			_aColorFilter.hue = 0;
			_aColorFilter.saturation = 0;
			_aColorFilter.brightness = _aBrightness;
			_aColorFilter.contrast = _aContrast;
			_aMatrix = _aColorFilter.CalculateFinalFlatArray();
			_aColorMatrix = new ColorMatrixFilter(_aMatrix);
			mApplyColorTransform();
		}
		
		private function mChangeSound(pAction:Boolean):void
		{
			if (pAction) 
			{
				_aSoundFrame += 1;
				_aTransform.volume += 0.1;
			}else
			{
				_aSoundFrame -= 1;
				_aTransform.volume -= 0.1;
			}
			_aSoundBar.gotoAndStop(_aSoundFrame);
			SoundMixer.soundTransform = _aTransform;
		}
		
		private function mApplyColorTransform():void
		{
			Screen.oMapTileContainer.filters = [_aColorMatrix];
			Screen.oRangeContainer.filters = [_aColorMatrix];
			Screen.oPointerContainer.filters = [_aColorMatrix];
			Screen.oCharacterContainer.filters = [_aColorMatrix];
			Screen.oAnimationContainer.filters = [_aColorMatrix];
			Screen.oHUDContainer.filters = [_aColorMatrix];
			Screen.oFilter.filters = [_aColorMatrix];
			Screen.oConsoleContainer.filters = [_aColorMatrix];
			Screen.oColorTransformationContainer.filters = [_aColorMatrix];
		}
		
		public override function mScreenRefresh():void
		{
			
		}
		
		public override function mScreenDestroy():void
		{
			Screen.oMapTileContainer.removeChild(aGraph);
			Screen.oMapTileContainer.removeChild(_aSoundBar);
			Screen.oMapTileContainer.removeChild(_aBrightnessBar);
			Screen.oMapTileContainer.removeChild(_aContrastBar);
			Screen.oMapTileContainer.removeChild(_aCursor);
			Main.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evHandleOptions);
		}
	}
}