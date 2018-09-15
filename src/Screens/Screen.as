package Screens
{
	import Characters.GreenBeret;
	import Characters.Gunner;
	import Characters.Sniper;
	import Characters.Soldier;
	
	import Maps.Map;
	import Maps.Pointer;
	import Maps.Tile;
	
	import Utilities.Console;
	import Utilities.Utils;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class Screen
	{
		//Consola
		public static var oConsole:Console = new Console();
		//Contenedores
		public static var oConsoleContainer:Sprite = new Sprite();
		public static var oCharacterContainer:Sprite = new Sprite();
		public static var oRangeContainer:Sprite = new Sprite();
		public static var oPointerContainer:Sprite = new Sprite();
		public static var oMapTileContainer:Sprite = new Sprite();
		public static var oHUDContainer:Sprite = new Sprite();
		public static var oAnimationContainer:Sprite = new Sprite();
		public static var oColorTransformationContainer:Sprite = new Sprite();
		public static var oFilter:MCFilter = new MCFilter();
		
		/** Representa la parte visual de la pantalla. */
		public var aGraph:MovieClip;
		
		/** Representa hacia dónde va a ir esta pantalla. */
		public var aGotoScreen:String = null;
		public static var aMenuFlag:Boolean;
		public static var aRestartFlag:Boolean;
		public static var aMenuSound:Boolean = false;
		
		public var oMap:Map;
		public var oCharacter:Vector.<Soldier>;
		public var oPointer:Pointer;
		
		public function Screen()
		{
			
		}
		
		/** Se ejecuta cuando se inicializa la pantalla. */
		public function mScreenInitialize():void
		{
			oConsole.mRegisterCommand(mGetHelp, "help");
			oConsole.mRegisterCommand(mChangeMap, "changeMap");
			oConsole.mRegisterCommand(mChangePhase, "changePhase");
			oConsole.mRegisterCommand(mChangeTileMap, "changeTileMap");
			oConsole.mRegisterCommand(mTeamWin, "teamWin");
			oConsole.mRegisterCommand(mResetGame, "resetGame");
			oConsole.mRegisterCommand(mChangeDamage, "changeDamage");
			oConsole.mRegisterCommand(mWalkAgain, "walkAgain");
			oConsole.mRegisterCommand(mAddSoldier, "addSoldier");
			oConsole.mRegisterCommand(mRemoveSoldier, "removeSoldier");
			oConsole.mRegisterCommand(mChangeSoldierPosition, "changeSoldierPosition");
			
			Main.mainStage.addChild(oMapTileContainer);
			Main.mainStage.addChild(oRangeContainer);
			Main.mainStage.addChild(oPointerContainer);
			Main.mainStage.addChild(oCharacterContainer);
			Main.mainStage.addChild(oAnimationContainer);
			Main.mainStage.addChild(oHUDContainer);
			Main.mainStage.addChild(oFilter);
			Main.mainStage.addChild(oConsoleContainer);
			Main.mainStage.addChild(oColorTransformationContainer);
		}
		
		
		/** Se ejecuta como si fuera un ENTER_FRAME. */
		public function mScreenRefresh():void
		{
			
		}
		
		/** Se ejecuta cuando se va a salir de la pantalla. */
		public function mScreenDestroy():void
		{
			
		}
		
		// Funciones almacenadas en el Diccionario de la Consola. 
		
		private function mGetHelp(pFirstCommand:String):void
		{
			var myText:String = "Available Commands:" +
				"\n" +
				"changeMap 'Mapa'					Cambia al mapa definido en la variable 'Mapa', en donde 'Mapa' puede ser 1,2,3 o 4." +
				"\n" +
				"changePhase 						Finaliza la fase de movimiento del equipo actual." +
				"\n" +
				"changeTileMap 'x' 'y' 'Tile'		Modifica un Tile del escenario, en donde 'x' representa un numero entre 0 y 14 para la Columna, 'y' un numero entre 0 y 21 para la pocision de la Fila y 'Tile' un numero entre 1 y 87." +
				"\n" +
				"teamWin 'Team'						Gana el equipo definido en el modificador 'Team', los valores son A o R." +
				"\n" +
				"resetGame							Reinicia el juego entero." +
				"\n" +
				"changeDamage 'Team' 'Tipo' 'Daño'	Modifica el daño de un tipo de Soldado, en donde 'Team' puede ser A o R, 'Tipo' puede ser Gunner, Beret o Sniper y 'Daño' un valor numerico." +
				"\n" +
				"walkAgain 							Permite al equipo actual volver a mover a todos sus soldados." +
				"\n" +
				"addSoldier 'Team' 'Tipo' 'x' 'y'	Agrega un soldado, en donde 'Team' puede ser A o R, 'Tipo' puede ser Gunner, Beret o Sniper, 'x' representa un numero entre 0 y 14 para la Columna e 'y' un numero entre 0 y 21 para la pocision de la Fila." +
				"\n" +
				"removeSoldier 'Pos'				Elimina un soldado, en donde Pos es el valor numerico de la pocision del soldado en el vector." +
				"\n" +
				"changeSoldierPosition 'Pos' 'x''y' Modifica la pocision de un soldado en el mapa, en donde Pos es el valor numerico de la pocision del soldado en el vector, 'x' representa un numero entre 0 y 14 para la Columna e 'y' un numero entre 0 y 21 para la pocision de la Fila." +
				"\n" +
				"\n";
			oConsole.aInputText.appendText(myText);
			oConsole.mSetCursorLast();
		}
		
		private function mChangeMap(pFirstCommand:String, pSeccondCommand:String):void
		{
			if (pSeccondCommand == "1" || pSeccondCommand == "2"  || pSeccondCommand == "3"  || pSeccondCommand == "4" ) 
				{ aGotoScreen = "ScreenLevel0" + pSeccondCommand; }	
			else
			{var myText:String = "\n" +
				"El atributo de cambio de mapa debe estar entre 1 y 4" +
				"\n";
				oConsole.aInputText.appendText(myText);
				oConsole.mSetCursorLast();
			}
		}
		
		private function mChangePhase(pFirstCommand:String):void
		{
			for each (var vSoldier:Soldier in oCharacter) 
			{
				if (vSoldier.aTeam == oPointer._aActualTeam) 
				{
					vSoldier.aCharaWalk = false;
				}
			}
			oPointer.mCheckTeamTurn();
		}
		
		private function mChangeTileMap(pFirstCommand:String, pSeccondCommand:String, pThirdCommand:String, pFourthCommand:String):void
		{
			var vX:Number = Number(pSeccondCommand);
			var vY:Number = Number(pThirdCommand);
			var vTile:Number = Number(pFourthCommand);
			
			if ((vX > 0 && vX < 22) && (vY > 0 && vY < 15) && (vY > 0 && vY < 79))
			{
				oMapTileContainer.removeChild(oMap.mGetRealMap()[vX][vY].aGraph);
				oMap.mGetRealMap()[vX][vY] = new Tile(vTile, vTile == 01 || vTile == 02 || vTile == 40 || vTile == 46 || vTile == 53 || vTile == 49 || vTile == 62 || vTile == 28 || vTile == 30);
				oMapTileContainer.addChild(oMap.mGetRealMap()[vX][vY].aGraph);
				oMap.mGetRealMap()[vX][vY].aGraph.x = vY * 96;
				oMap.mGetRealMap()[vX][vY].aGraph.y = vX * 96;
			}else
			{var myText:String = "\n" +
				"El valor de X debe estar entre 1 y 22" +
				"El valor de Y debe estar entre 1 y 14" +
				"El valor de Tile debe estar entre 1 y 78" +
				"\n";
				oConsole.aInputText.appendText(myText);
				oConsole.mSetCursorLast();
			}
		}	
		
		private function mTeamWin(pFirstCommand:String, pSeccondCommand:String):void
		{
			if (pSeccondCommand == "A"){
				oPointer._aTotalRed = 0;
				oPointer.mCheckVictory();
			}
			else if (pSeccondCommand == "R") {
				oPointer._aTotalBlue = 0
				oPointer.mCheckVictory();
			}
			else
			{
				var myText:String = "\n" +
					"El atributo de Equipo es incorrecto" +
					"\n";
				oConsole.aInputText.appendText(myText);
				oConsole.mSetCursorLast();
			}
		}
		
		
		private function mResetGame(pFirstCommand:String):void
		{ 
			aGotoScreen = "ScreenLogo";
		}
		
		
		private function mChangeDamage(pFirstCommand:String, pSeccondCommand:String, pThirdCommand:String, pFourthCommand:String):void
		{
			var pFlag:Boolean = false;
			for (var i:int = 0; i < oCharacter.length; i++) 
			{
				if (oCharacter[i].aTeam == pSeccondCommand && oCharacter[i].aType == pThirdCommand)
				{ oCharacter[i].aWeapon.mSetDamage(int(pFourthCommand));
					pFlag= true;
				}
			}
			if (pFlag == false)
			{
				var myText:String = "\n" +
					"El atributo de Equipo debe ser A o R" +
					"El atributo de Tipo debe ser Gunner, Beret o Sniper" +
					"\n";
				oConsole.aInputText.appendText(myText);
				oConsole.mSetCursorLast();
			}
		}
		
		
		private function mWalkAgain(pFirstCommand:String):void
		{
			for each (var vSoldier:Soldier in oCharacter)
			{
				if (vSoldier.aTeam == oPointer._aActualTeam)
				{
					vSoldier.aCharaWalk = true;
					Utilities.Utils.mRemoveGrayMC(vSoldier.aGraph);
				}
			}
		}
		
		private function mAddSoldier(pFirstCommand:String, pSeccondCommand:String, pThirdCommand:String, pFourthCommand:String, FifhtCommand:String):void
		{
			if (pThirdCommand == "Gunner" || pThirdCommand == "Beret" || pThirdCommand == "Sniper") 
			{
				switch(pThirdCommand)
				{
					case "Gunner":
					{
						if (pSeccondCommand == "A") 
							oCharacter.push(new Gunner(MCGunnerA, oMap,5,4,1,"A",true, "Gunner"));
						else oCharacter.push(new Gunner(MCGunnerN, oMap,5,4,1,"R",false, "Gunner"));
							
						break;
					}
					case "Beret":
					{
						if (pSeccondCommand == "A") 
							oCharacter.push(new GreenBeret(MCBeretA, oMap,5,5,1,"A",true, "Beret"));
						else oCharacter.push(new GreenBeret(MCBeretN, oMap,5,5,1,"R",false, "Beret"));
							
						break;
					}
					case "Sniper":
					{
						if (pSeccondCommand == "A") 
							oCharacter.push(new Sniper(MCSniperA, oMap,5,3,1,"A",true, "Sniper"));
						else oCharacter.push(new Sniper(MCSniperN, oMap,5,3,1,"R",false, "Sniper"));
							
						break;
					}
						
					default:
					{
						break;
					}
						
					
				}
				if (pSeccondCommand == "Blue") 
					oPointer._aTotalBlue += 1;
				else oPointer._aTotalRed += 1;
				
				var vX:Number = Number(pFourthCommand);
				var vY:Number = Number(FifhtCommand);
				oCharacter[oCharacter.length - 1].mCharaSpawn(vX * 96, vY * 96);
			}
			else
			{var myText:String = "\n" +
				"El atributo de equipo debe ser A o R" +
				"El atributo de Tipo debe ser Gunner, Beret o Sniper" +
				"\n";
				oConsole.aInputText.appendText(myText);
				oConsole.mSetCursorLast();}
		}	
		
		private function mRemoveSoldier(pFirstCommand:String, pSeccondCommand:String):void
		{
			var vPos:Number = Number(pSeccondCommand);
			
			if (vPos <= oCharacter.length-1 && vPos >= 0) 
			{
				for (var i:int =oCharacter.length-1 ; i > -1; i--) 
				{
					if (i == vPos) 
					{
						if (oCharacter[i].aTeam == "A") 
							oPointer._aTotalBlue -= 1;
						else oPointer._aTotalRed -= 1;
						
						oCharacter[i].mCharacterRemove();
						oCharacter.splice(i,1);
					}
				}
			}
			else
			{var myText:String = "\n" +
				"El atributo de pocision es invalido" +
				"\n";
				oConsole.aInputText.appendText(myText);
				oConsole.mSetCursorLast();}
		}
		
		private function mChangeSoldierPosition(pFirstCommand:String, pSeccondCommand:String, pThirdCommand:String, pFourthCommand:String):void
		{
			var vPos:Number = Number(pSeccondCommand);
			var vX:Number = Number(pThirdCommand);
			var vY:Number = Number(pFourthCommand);
			
			if (vPos <= oCharacter.length-1 && vPos >= 0) 
			{
				oCharacter[vPos].aGraph.x = vX * 96;
				oCharacter[vPos].aGraph.y = vY * 96;
			}
			else
			{var myText:String = "\n" +
				"El atributo de pocision es invalido" +
				"\n";
				oConsole.aInputText.appendText(myText);
				oConsole.mSetCursorLast();}
		}		
		
		
	}
}