package Utilities
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import flashx.textLayout.utils.CharacterUtil;
	
	public class AssetsManager extends EventDispatcher
	{
		public var aArrayImages:Vector.<Loader> = new Vector.<Loader>();
		public var aArraySounds:Vector.<Sound> = new Vector.<Sound>();
		public var aArrayTexts:Vector.<URLLoader> = new Vector.<URLLoader>();
		public var aArraySWF:Vector.<Loader> = new Vector.<Loader>();
		
		private var _urlFileList:URLRequest;
		private var _loaderFileList:URLLoader;
		
		private var vNumberAssetsTotal:int;
		private var vNumberAssetsParcial:int;
		
		public function AssetsManager(pUrlExternalFile:String)
		{
			_urlFileList = new URLRequest(pUrlExternalFile);
			_loaderFileList = new URLLoader();
			
			_loaderFileList.load(_urlFileList);
			_loaderFileList.addEventListener(Event.COMPLETE, evAssetsListComplete);
		}
		
		private function evAssetsListComplete(e:Event):void
		{
			trace(_loaderFileList.data);
			var vRowLink:Array = _loaderFileList.data.split("\n");
			
			vNumberAssetsTotal = vRowLink.length;
			
			for(var i:int=0; i<vRowLink.length; i++)
			{
				var vType:String = vRowLink[i].split("/")[0];
				var vSingleChar:String = vRowLink[i];
				
				//Esto es para que no corte el último caracter.
				if(i < vRowLink.length - 1)
				{
					//Cortamos el último caracter.
					vSingleChar = vSingleChar.replace(vSingleChar.charAt(vSingleChar.length-1), "");
					vRowLink[i] = vSingleChar;
				}
				
				switch(vType)
				{
					case "Images":
						aArrayImages.push( new Loader() );
						aArrayImages[aArrayImages.length-1].load( new URLRequest(vRowLink[i]) );
						aArrayImages[aArrayImages.length-1].contentLoaderInfo.addEventListener(Event.COMPLETE, evOneAssetComplete);
						aArrayImages[aArrayImages.length-1].contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, evError);
						break;
					
					case "Sounds":
						aArraySounds.push( new Sound() );
						aArraySounds[aArraySounds.length-1].load( new URLRequest(vRowLink[i]) );
						aArraySounds[aArraySounds.length-1].addEventListener(Event.COMPLETE, evOneAssetComplete);
						break;
					
					case "Text":
						aArrayTexts.push( new URLLoader() );
						aArrayTexts[aArrayTexts.length-1].load( new URLRequest(vRowLink[i]) );
						aArrayTexts[aArrayTexts.length-1].addEventListener(Event.COMPLETE, evOneAssetComplete);
						break;
					
					case "SWF":
						aArraySWF.push( new Loader() );
						aArraySWF[aArraySWF.length-1].load(new URLRequest(vRowLink[i]));
						aArraySWF[aArraySWF.length-1].contentLoaderInfo.addEventListener(Event.COMPLETE, evOneAssetComplete);
						break;
				}
			}
		}
		
		private function evError(e:IOErrorEvent):void
		{
			throw new Error("Server Error");
		}
		
		private function evOneAssetComplete(e:Event):void
		{
			trace("Asset Loaded");
			vNumberAssetsParcial++;
			if(vNumberAssetsParcial == vNumberAssetsTotal)
			{
				dispatchEvent( new Event("allAssetsLoaded") );
			}
		}
		
		public function mGetImage(pIndex:int):Loader
		{
			return aArrayImages[pIndex];
		}
		
		public function mGetSound(pIndex:int):Sound
		{
			return aArraySounds[pIndex];
		}
		
		public function mGetMovieClip(pMcName:String):MovieClip
		{
			for (var i:int = 0; i < aArraySWF.length; i++) 
			{
				try
				{
					var vMcClass:Class = aArraySWF[i].contentLoaderInfo.applicationDomain.getDefinition(pMcName) as Class;
					var vMcReturn:MovieClip = new vMcClass();
				}catch(e1:ReferenceError)
				{
					trace("No se encuentra el MovieClip especificado, en su lugar se cargara un MovieClip predeterminado " + pMcName);
					vMcClass = aArraySWF[i].contentLoaderInfo.applicationDomain.getDefinition("MCError") as Class;
					vMcReturn = new vMcClass();
				}catch(e2:Error)
				{
					trace("Error Generico");
				}
				
				return vMcReturn;
			}
			
			return null;
		}
	}
}