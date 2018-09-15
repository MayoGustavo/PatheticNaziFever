package Utilities
{
	import Characters.Soldier;
	
	import Maps.Pointer;
	
	import flash.sampler.NewObjectSample;
	import flash.utils.setTimeout;

	public class LanSender
	{
		public var aConection:LanConnector;
		public var myID:String = "Snake";
		public var oPointerVector:Vector.<Pointer> = new Vector.<Pointer>();
		public var oPointer:Pointer;
		
		public function LanSender(pPointer:Pointer)
		{
			this.oPointer = pPointer;
			aConection = new LanConnector(Main.mainStage.frameRate);
			aConection.connectTo("127.0.0.1", 21);
			aConection.changeMyID( myID );
			aConection.callbacksFunctions.push( evConectado );
			aConection.callbacksFunctions.push( evMensaje );
		}
		
		public function evMensaje(mensaje:String):void
		{
			var textoCortado:Array = mensaje.split("/");
			
			switch(textoCortado[0])
			{
				case "instanciame":
					trace("Instanciado");
					oPointerVector.push(oPointer);
					break;
				
				case "moveme":
					for(var i:int=0; i<oPointerVector.length; i++)
					{
						trace(textoCortado[2]);
						trace(textoCortado[3]);
						oPointerVector[i].aPointerGraph.x = Number(textoCortado[2]);
						oPointerVector[i].aPointerGraph.y = Number(textoCortado[3]);
					}
					break;
				
				case "allIDs":
					if(textoCortado.length > 2)
					{
						for(var i:int=1; i < textoCortado.length; i++)
						{
							if(textoCortado[i] != myID)
							{
								oPointerVector.push(oPointer);
							}
						}
					}
					break;
			}
		}
		
		public function evConectado(mensaje:String):void
		{
			trace("Conectado");
			aConection.sendMessageTo("all", "instanciame/" + myID);
			setTimeout(aConection.getAllUsersIDs, 1000 / Main.mainStage.frameRate);
		}
	}
}