package Utilities
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	
	public class SaveManager1 extends EventDispatcher
	{
		private var _aDataToBeSaved:SharedObject;
		//Guardar datos de la Cookie
		public var aDataToBeLoaded:Dictionary;
		
		public function SaveManager1(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function mDoSave(myData:Dictionary):void
		{
			//Obtiene una Cookie y la almacena en _saver
			_aDataToBeSaved = SharedObject.getLocal("MyFuckingGame");
			//data es un Object, crea la variable MySave y asigna valor myDAta
			_aDataToBeSaved.data.MySave = myData;
			//Guarda datos inmediatamente
			_aDataToBeSaved.flush(); 
		}
		
		public function mDoLoad():void
		{
			_aDataToBeSaved = SharedObject.getLocal("MyFuckingGame");
			aDataToBeLoaded = _aDataToBeSaved.data.MySave;
			
			dispatchEvent(new Event("DATA_LOADED"));
		}
	}
}