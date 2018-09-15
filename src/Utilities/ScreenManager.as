package Utilities
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	import Screens.Screen;

	public class ScreenManager
	{
		/** Almacena todas las pantallas. */
		public var aScreenStore:Dictionary = new Dictionary();
		
		/** Contiene la pantalla activa. */
		public var aCurrentScreen:Screen;
		
		
		public function ScreenManager()
		{
			Main.mainStage.addEventListener(Event.ENTER_FRAME, evRefreshCurrentScreen);
		}
		
		private function evRefreshCurrentScreen(e:Event):void
		{
			if(aCurrentScreen != null)
			{
				aCurrentScreen.mScreenRefresh();
				
				if(aCurrentScreen.aGotoScreen != null)
				{
					mScreenLoad( aCurrentScreen.aGotoScreen );
				}
			}
		}
		
		/** Registra una pantalla en el diccionario. 
		 * @param pScreenName Nombre del inidice del diccionario.
		 * @param pScreenClass Nombre de la Clase de la pantalla a almacenar.
		 * */
		public function mScreenRegister(pScreenName:String, pScreenClass:Class):void
		{
			aScreenStore[pScreenName] = pScreenClass;
		}
		
		public function mScreenLoad(pScreenName:String):void
		{
			if(aCurrentScreen != null)
			{
				aCurrentScreen.mScreenDestroy();
				aCurrentScreen = null;
			}
			
			var s:Class = aScreenStore[pScreenName];
			aCurrentScreen = new s();
			aCurrentScreen.mScreenInitialize();
		}
	}
}