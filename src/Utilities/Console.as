package Utilities
{
	import Screens.Screen;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;

	public class Console extends EventDispatcher
	{
		public var aInputText:TextField = new TextField();
		public var aIsOpened:Boolean = false;
		public var _aConsoleExist:Boolean;
		/* Diccionario: Es como un vector pero el indice permite una clave o palabra. */
		public var aMyCommands:Dictionary = new Dictionary();
		
		public function Console()
		{
			
		}
		
		/**Inicializa la Consola. 
		 * */
		public function mInitializeConsole():void
		{
			aInputText = new TextField();
			var myText:String = "Pathetic Nazi Forever version 0.74\n" +
								"Copyright 2013 Vanilla Studios, published under GNU GPL.\n" +
								"---\n" +
								"CONFIG:Loading primary settings from config file bin-debug\ExternalFiles.txt. \n" +
								"Pathetic Nazi Forever.conf" +
								"MIDI:Opened device:win32\n" +
								"Type 'help' in order to know the internal commands" +
								"\n" +
								"\n";
			var format:TextFormat = new TextFormat(); 
			format.font = "Arial"; 
			format.color = 0x00FF00; 
			format.size = 20;
			aInputText.defaultTextFormat = format;
			aInputText.width = Main.mainStage.width; 
			aInputText.height = Main.mainStage.height * 1/3 + 100; 
			aInputText.multiline = true; 
			aInputText.wordWrap = true; 
			aInputText.background = true;
			aInputText.backgroundColor = 0x000000;
			aInputText.border = true; 
			aInputText.type = TextFieldType.INPUT;
			
			aInputText.text = myText;
			
			mSetCursorLast();
			
			
			Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evOpenCloseConsole);
		}
		
		/** Situaliza el cursor en la ultima linea de escritura. 
		 * */
		public function mSetCursorLast():void
		{
			Main.mainStage.focus = aInputText;
			aInputText.setSelection(aInputText.text.length,aInputText.text.length);
		}
		
		/** Evento que detecta la apertura y cierre de la Consola 
		 * */
		public function evOpenCloseConsole(KeyEvent:KeyboardEvent):void
		{
			if (KeyEvent.keyCode == Keyboard.F1)
			{
				if (aIsOpened)
				{
					mCloseConsole();
					dispatchEvent(new Event("CLOSEDCONSOLE"));
				}else{
					mOpenConsole();
				}
			}else if(KeyEvent.keyCode == Keyboard.ENTER)
			{
				mExecuteCommand();
			}
			
		}
		
		/**Borra el contenido de la Consola 
		 * */
		public function mDestroyTextConsole():void
		{
			aInputText = null;
		}
		
		/** Abrir Consola 
		 * */
		public function mOpenConsole():void
		{
			mInitializeConsole();
			aIsOpened = true;
			_aConsoleExist = true;
			Screen.oConsoleContainer.addChild(aInputText);
		}
		
		/** Cerrar Consola 
		 * */
		public function mCloseConsole():void
		{
			if (_aConsoleExist) 
			{
				_aConsoleExist = false;
				Screen.oConsoleContainer.removeChild(aInputText);
				aIsOpened = false;
				mDestroyTextConsole();
			}
		}
		
		/** Funcion para registrar un comando en el Diccionario de Comandos.
		 * 
		 * @param command Nombre de la funcion que ejecuta el comando Registrado.
		 * @param name Nombre mediante el cual se ejecuta la llamada a la funcion para ejecutar el Comando. */
		public function mRegisterCommand(command:Function, name:String):void
		{
			aMyCommands[name] = command;
		}
		
		/** Ejecuta el Comando 
		 * */
		public function mExecuteCommand():void
		{
			var vLastCommand:String = aInputText.getLineText(aInputText.numLines-1);
			var vTextField:TextField = new TextField();
			vTextField.text = vLastCommand;
			var vCommandArray:Array = vTextField.text.split(" ");
			var vCommandString:String = vCommandArray[0];
				
			if (aMyCommands[vCommandString] == null) 
				{
					aInputText.appendText("\n<El comando ingresado es incorrecto>");
					mSetCursorLast();
				}
				else 
				{
					var vCommandFunction:Function = aMyCommands[vCommandString];
					vCommandFunction.apply(aMyCommands[vCommandString],vCommandArray);
				}
				
			}
		
		
	}
}