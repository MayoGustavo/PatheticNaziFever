package Utilities
{
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.setTimeout;
	
	public class LanConnector
	{
		/*public var callbacksMessage:Vector.<Function> = new Vector.<Function>();
		public var callbacksConnected:Vector.<Function> = new Vector.<Function>();*/
		public var callbacksFunctions:Vector.<Function> = new Vector.<Function>();
		
		private var _connector:Socket;
		private var _lastMessage:String;
		public var showResponse:Boolean = true;
		public var frameRate:int;
		
		public function LanConnector(frameRate:int)
		{
			this.frameRate = frameRate;
		}
		
		public function connectTo($ip:String, $port:int):void
		{
			_connector = new Socket($ip, $port);
			_connector.addEventListener(ProgressEvent.SOCKET_DATA, evDataReceived);
		}
		
		public function changeMyID($newID:String):void
		{
			var tmpCallback:Function = function():void{
				_connector.writeUTFBytes("changeMyID " + $newID);
				_connector.flush();
			}
			
			setTimeout(tmpCallback, 1000 / frameRate);
		}
		
		private function evDataReceived($e:ProgressEvent):void
		{
			_lastMessage = _connector.readUTFBytes(_connector.bytesAvailable);
			
			if(showResponse)
				trace(_lastMessage);
			
			
			if(_lastMessage.indexOf("<welcome_message>") != 0)
			{
				evNewMessage(_lastMessage);
			}else{
				evConnected(_lastMessage.split("<welcome_message>")[1]);
			}
		}
		
		public function sendMessageTo($targetID:String, $message:String):void
		{
			var tmpCallback:Function = function():void{
				_connector.writeUTFBytes("sendTo " + $targetID + " " + $message);
				_connector.flush();
			}
			setTimeout(tmpCallback, 1000 / frameRate);
		}
		
		public function getAllUsersIDs():void
		{
			var tmpCallback:Function = function():void{
				_connector.writeUTFBytes("getAllUsersIDs");
				_connector.flush();
			}
			setTimeout(tmpCallback, 1000 / frameRate);
		}
		
		protected function evNewMessage($message:String):void
		{
			for(var i:int=0; i<callbacksFunctions.length; i++)
			{
				callbacksFunctions[i]( $message );
			}
		}
		
		protected function evConnected($message:String):void
		{
			for(var i:int=0; i<callbacksFunctions.length; i++)
			{
				trace("Conectado");
				callbacksFunctions[i]( $message );
			}
		}
	}
	
}
