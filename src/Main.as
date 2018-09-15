package
{
	import Screens.ScreenHowToPlay;
	import Screens.ScreenIntroLevel01;
	import Screens.ScreenIntroLevel02;
	import Screens.ScreenIntroLevel03;
	import Screens.ScreenIntroLevel04;
	import Screens.ScreenIntroStageSelection;
	import Screens.ScreenIntroduction;
	import Screens.ScreenLevel01;
	import Screens.ScreenLevel02;
	import Screens.ScreenLevel03;
	import Screens.ScreenLevel04;
	import Screens.ScreenLogo;
	import Screens.ScreenMenu;
	import Screens.ScreenOptions;
	import Screens.ScreenStageSelection;
	
	import Utilities.AssetsManager;
	import Utilities.ScreenManager;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.ui.Mouse;
	
	[SWF(height ='1334', width = '2112')]
	public class Main extends Sprite
	{
		//Escenario Estatico
		public static var mainStage:Stage;
		//Asset Manager
		public static var oAssetsManager:AssetsManager = new AssetsManager("ExternalFiles.txt");
		//Screen Manager
		public var oScreenManager:ScreenManager;
		
		//Main
		public function Main()
		{
			mainStage = stage;
			Mouse.hide();
			oAssetsManager.addEventListener("allAssetsLoaded", evStartGame);
		}
		
		public function evStartGame(e:Event):void
		{
			oScreenManager = new ScreenManager();
			oScreenManager.mScreenRegister("ScreenLogo", ScreenLogo);
			oScreenManager.mScreenRegister("ScreenIntroduction", ScreenIntroduction);
			oScreenManager.mScreenRegister("ScreenHowToPlay", ScreenHowToPlay);
			oScreenManager.mScreenRegister("ScreenOptions", ScreenOptions);
			oScreenManager.mScreenRegister("ScreenMenu", ScreenMenu);
			oScreenManager.mScreenRegister("ScreenIntroStageSelection", ScreenIntroStageSelection);
			oScreenManager.mScreenRegister("ScreenStageSelection", ScreenStageSelection);
			oScreenManager.mScreenRegister("ScreenIntroLevel01", ScreenIntroLevel01);
			oScreenManager.mScreenRegister("ScreenIntroLevel02", ScreenIntroLevel02);
			oScreenManager.mScreenRegister("ScreenIntroLevel03", ScreenIntroLevel03);
			oScreenManager.mScreenRegister("ScreenIntroLevel04", ScreenIntroLevel04);
			oScreenManager.mScreenRegister("ScreenLevel01", ScreenLevel01);
			oScreenManager.mScreenRegister("ScreenLevel02", ScreenLevel02);
			oScreenManager.mScreenRegister("ScreenLevel03", ScreenLevel03);
			oScreenManager.mScreenRegister("ScreenLevel04", ScreenLevel04);
			oScreenManager.mScreenLoad("ScreenLogo");
		}
	}
}