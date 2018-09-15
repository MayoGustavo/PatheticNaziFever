package Utilities
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.Dictionary;
	
	public class SaveManager extends EventDispatcher
	{
		private var _aDataToBeSaved:FileReference = new FileReference();
		public var aDataToBeLoaded:Dictionary = new Dictionary();
		
		public function SaveManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function mDoSave(myData:Dictionary):void
		{
			var textToSave:String = "";
			for (var data:* in myData)
			{
				textToSave += data + "=" + myData[data] + ";";
			}
			trace(textToSave);
			_aDataToBeSaved.save(textToSave, "GTFO.dat");
		}
		
		public function mDoLoad():void
		{
			var types:Array = [new FileFilter("Texto", "*.txt"), new FileFilter("Datos", "*.dat")]
			_aDataToBeSaved.browse(types);
			_aDataToBeSaved.addEventListener(Event.SELECT, evFileOpened);
		}
		
		/** Se ejecuta cuando selecciono un archivo y le doy abrir. O doble clic al archivo */
		private function evFileOpened(e:Event):void
		{
			_aDataToBeSaved.removeEventListener(Event.SELECT, evFileOpened);
			_aDataToBeSaved.load();
			_aDataToBeSaved.addEventListener(Event.COMPLETE, evFileComplete);
		}
		
		private function evFileComplete(e:Event):void
		{
			_aDataToBeSaved.removeEventListener(Event.COMPLETE, evFileComplete);
			var textResult:String = _aDataToBeSaved.data.toString();
			var textSplitted:Array = textResult.split(";");
			
			for (var i:int = 0; i < textSplitted.length; i++) 
			{
				var name:String = textSplitted[i].split("=")[0];
				var value:String = textSplitted[i].split("=")[1];
				aDataToBeLoaded[name] = Number(value);
			}
			dispatchEvent(new Event("DATA_LOADED"));
		}
	}
}