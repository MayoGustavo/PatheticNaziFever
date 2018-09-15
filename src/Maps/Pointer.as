package Maps
{
	import Characters.Soldier;
	
	import Screens.Screen;
	import Screens.ScreenMenuInGame;
	
	import Utilities.CustomSound;
	import Utilities.HUDManager;
	import Utilities.LanSender;
	import Utilities.SaveManager;
	import Utilities.SaveManager1;
	import Utilities.SaveStorage;
	import Utilities.Utils;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	public class Pointer extends EventDispatcher
	{
		public var aPointerGraph:MCPointer;
		public var _aRowNumber:int;
		public var _aColumnNumber:int;
		public var aGrabbedCharacter:Boolean;
		public var _aTotalRed:int;
		public var _aTotalBlue:int;
		public var _aActualTeam:String;
		public var _aMoveSound:CustomSound;
		public var _aSelectSound:CustomSound;
		public var oGameMenu:ScreenMenuInGame;
		public var _aExistPointer:Boolean;
		public var oActionMenu:ActionMenu;
		//Mapa Actual
		private var _aGuideMap:Map;
		//Personaje
		private var _aVectorCharacter:Vector.<Soldier> = new Vector.<Soldier>;
		public var _aPointerCharaVector: int;
		public var _aPhaseAttack:Boolean = false;
		public var _aFlagPhase:Boolean = false;
		private var _aVictory:Boolean = false;
		public var aVictory:Boolean = false;
		//HUD Manager
		private var _oHUDManager:HUDManager;
		//Save Storage
		private var oSaveStorage:SaveStorage;
		
		//Lan Sender
		//private var oLanSender:LanSender;
		
		//Constantes
		public var vTileSize:int = 96;
		
		public function Pointer(pGuideMap:Map, pCharacter:Vector.<Soldier>, pTotalRed:int, pTotalBlue:int)
		{
			aPointerGraph = new MCPointer();
			oGameMenu = new ScreenMenuInGame();
			oActionMenu = new ActionMenu();
			this._aGuideMap = pGuideMap;
			this._aVectorCharacter = pCharacter;
			this.aGrabbedCharacter = false;
			this._aTotalRed = pTotalRed;
			this._aTotalBlue = pTotalBlue;
			this._oHUDManager = new HUDManager();
			this._aMoveSound = new CustomSound(Main.oAssetsManager.mGetSound(1));
			this._aSelectSound = new CustomSound(Main.oAssetsManager.mGetSound(7));
			_aActualTeam = "A";
			_aRowNumber = 6;
			_aColumnNumber = 10;
			this.oSaveStorage = new SaveStorage(_aGuideMap, _aVectorCharacter, this, Screen.aMenuFlag, Screen.aRestartFlag);
		}
		
		/** Inicializa el puntero en pantalla.
		 * */
		public function mSetPointer():void
		{
			_aExistPointer = true;
			Screen.oPointerContainer.addChild(aPointerGraph);
			aPointerGraph.x = _aColumnNumber * aPointerGraph.width;
			aPointerGraph.y = _aRowNumber * aPointerGraph.width;
			Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyPushed);
		}
		
		/**Destruye el Puntero*/
		public function mDestroyPointer():void
		{
			if (_aExistPointer)
			{
				_aExistPointer = false;
				Screen.oPointerContainer.removeChild(aPointerGraph);
				Main.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evKeyPushed)
			}
		}
		
		
		/** Comprueba cuando todos los jugadores de un Team finalizaron sus movimientos.
		 * */
		public function mCheckTeamTurn ():void
		{
			var vCounter:int=0;
			var vTotalCounter:int=0;
			for (var i:int = 0; i < _aVectorCharacter.length; i++) 
			{
				if (_aVectorCharacter[i].aTeam == _aActualTeam) 
				{
					vTotalCounter++;
					if (_aVectorCharacter[i].aCharaWalk == false)
					{
						vCounter++;
					}
				}	
			}
			
			if ((_aActualTeam == "A") && (vCounter == vTotalCounter))
			{	mChangeTeam(vCounter, _aTotalRed, "R");
				vCounter = 0;
			}
			if ((_aActualTeam == "R") && (vCounter == vTotalCounter))
			{	mChangeTeam(vCounter, _aTotalBlue, "A");
				vCounter = 0;
			}
		}
		
		/** Otorga el control al Team contrario.
		 *  @param pCounter Cantidad de Personajes que no pueden mover.
		 *  @param pTotal Cantidad total de Personajes en el Team.
		 *  @param pTeam Team que toma el control.
		 * */
		public function mChangeTeam(pCounter:int, pTotal:int, pTeam:String):void
		{
			if (pTotal != 0) 
				{
					_aActualTeam = pTeam;
				}
				for (var j:int = 0; j < _aVectorCharacter.length; j++) 
				{
					if (_aVectorCharacter[j].aTeam == _aActualTeam) 
					{
						_aVectorCharacter[j].aCharaWalk = true;
					}
					else { Utils.mRemoveGrayMC(_aVectorCharacter[j].aGraph); }
				}
				if (_aGuideMap.oBattleAnimation.aIsRunning != true) 
					mShowPhaseAnimation();
				else _aFlagPhase = true;
		}
		
		public function mShowPhaseAnimation():void
		{
			_aFlagPhase = false;
			_oHUDManager.mRemoveHUD();
			mDestroyPointer();
			_aGuideMap._oPhaseAnimation.mShowAnimation();
			_aGuideMap._oPhaseAnimation.addEventListener("AnimationOverPointer", evPhaseAnimationOver);
		}
		
		public function mHUDHandler():void
		{
			if (Utils.mGetCharacterAt(_aColumnNumber,_aRowNumber,_aVectorCharacter))
			{
				var vIndex:int = _aGuideMap.mGetCharacterIndex(_aColumnNumber, _aRowNumber);
				var vLife:int = _aVectorCharacter[vIndex].aLife;
				var vType:String = _aVectorCharacter[vIndex].aType;
				_oHUDManager.mBuildHUD(vLife, vType);
			}
			else _oHUDManager.mRemoveHUD();
		}
		
		/** Evento que detecta cuando una tecla es presionada.
		 *  @param evKeyboard Tecla presionada, parametro automatico.
		 * */
		public function evKeyPushed(evKeyboard:KeyboardEvent):void
		{
					switch(evKeyboard.keyCode)
					{
						case Keyboard.F1:
						{
							if (Screen.oConsole._aConsoleExist) 
							{
								Main.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evKeyPushed);
								Screen.oConsole.addEventListener("CLOSEDCONSOLE", evCloseConsoleHandler);
							}
						}
							break;
						case Keyboard.DOWN:
							if (_aRowNumber < 14) 
							{
								aPointerGraph.y += aPointerGraph.height;
								_aRowNumber++;
								_aMoveSound.mPlay();
								mHUDHandler();
							}
							break;
						case Keyboard.UP:
							if (_aRowNumber > 0)
							{
								aPointerGraph.y -= aPointerGraph.height;
								_aRowNumber--;
								_aMoveSound.mPlay();
								mHUDHandler();
							}
							break;
						case Keyboard.LEFT:
							if (_aColumnNumber > 0)
							{
								aPointerGraph.x -= aPointerGraph.width;
								_aColumnNumber--;
								_aMoveSound.mPlay();
								mHUDHandler();
							}
							break;
						case Keyboard.RIGHT:
							if (_aColumnNumber <20) 
							{
								aPointerGraph.x += aPointerGraph.width;
								_aColumnNumber++;
								_aMoveSound.mPlay();
								mHUDHandler();
							}
							break;
						case Keyboard.S:
							if (_aPhaseAttack)
							{
								_aPhaseAttack = false;
								_aVectorCharacter[_aPointerCharaVector]._aAttackRange.mHideRange();
								_aVectorCharacter[_aPointerCharaVector].mAnimationIdle();
								mCheckTeamTurn();
							}
							break;
						case Keyboard.ENTER:
							{
								mGenerateGameMenu();
							}
							break;
						case Keyboard.A:
							if ((_aGuideMap.mGetCharacterTeam(_aColumnNumber,_aRowNumber) == _aActualTeam) || (_aPhaseAttack == true))
							{
								_aSelectSound.mPlay();
								if (_aPhaseAttack)
								{
									var vFlagAttack:Boolean = false;
									for each (var vIndexSoldierRecieveDamage:int in _aVectorCharacter[_aPointerCharaVector].aAttackArray) 
									{
										if (_aGuideMap.mGetCharacterIndex(_aColumnNumber , _aRowNumber) == vIndexSoldierRecieveDamage)
											
											vFlagAttack = true;
									}
									
									if (vFlagAttack)
									{
										//Soldado que ataca.
										var vAttackTeam:String = _aVectorCharacter[_aPointerCharaVector].aTeam;
										var vAttackSoldier:String = _aVectorCharacter[_aPointerCharaVector].aType;
										_aVectorCharacter[_aPointerCharaVector].mAnimationIdle();
										var vDamage:int = _aVectorCharacter[_aPointerCharaVector].mGetMeleeWeapon().mGetDamage();
										_aVectorCharacter[_aPointerCharaVector]._aAttackRange.mHideRange();
										//Soldado que recibe daño. Cambia puntero.
										_aPointerCharaVector = _aGuideMap.mGetCharacterIndex(_aColumnNumber,_aRowNumber);
										_aVectorCharacter[_aPointerCharaVector].mReceiveDamage(vDamage);
										var vDefendSoldier:String = _aVectorCharacter[_aPointerCharaVector].aType;
										//Muestra animacion combate
										mDestroyPointer();
										_aGuideMap.aMapSound.mStop();
										//_aGuideMap.aBattleSound.mPlay();
										if (_aVectorCharacter[_aPointerCharaVector].aLife <= 0) 
										{
											_aGuideMap.oBattleAnimation.mShowAnimationBattle(vAttackTeam,vAttackSoldier,vDefendSoldier,"M");
											if (this._aActualTeam == "R")
												_aTotalBlue--;
											else
												_aTotalRed--;
											_aVectorCharacter[_aPointerCharaVector].mCharacterRemove();
											_aVectorCharacter.splice(_aPointerCharaVector,1);
										}else
										{_aGuideMap.oBattleAnimation.mShowAnimationBattle(vAttackTeam,vAttackSoldier,vDefendSoldier,"D");}
										_aGuideMap.oBattleAnimation.addEventListener("AnimationOverPointer", evBattleAnimationOver);
										_aPhaseAttack = false;
										mHUDHandler();
										mCheckTeamTurn();
									}
								}
								else{
									_aPointerCharaVector = _aGuideMap.mGetCharacterIndex(_aColumnNumber,_aRowNumber);
									if (_aVectorCharacter[_aPointerCharaVector].mGetCharacterAt(_aColumnNumber, _aRowNumber) && _aVectorCharacter[_aPointerCharaVector].aCharaWalk == true)
									{
										mDestroyPointer();
										oActionMenu.mCreateActionMenu();
										oActionMenu.addEventListener("MOVECHARACTER", evSetMotionHandler);
										oActionMenu.addEventListener("ATTACKCHARACTER", evAttackHandler);
										oActionMenu.addEventListener("CANCELACTION", evCancelHandler);
									}
								}}
							break;
				}
				
		}
		
		protected function evCloseConsoleHandler(event:Event):void
		{
			Screen.oConsole.removeEventListener("CLOSEDCONSOLE", evCloseConsoleHandler);
			Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyPushed);
		}
		
		protected function evCancelHandler(event:Event):void
		{
			mRemoveMenuActionHandlers();
			mSetPointer();
		}
		
		protected function evAttackHandler(event:Event):void
		{
			mRemoveMenuActionHandlers();
			_aVectorCharacter[_aPointerCharaVector].aCharaSelected = false;
			_aVectorCharacter[_aPointerCharaVector].aCharaWalk = false;
			Utils.mMakeGrayMC(_aVectorCharacter[_aPointerCharaVector].aGraph);
			mAttackDetection();
		}
		
		protected function evSetMotionHandler(event:Event):void
		{
			mRemoveMenuActionHandlers();
			mSetMotion();
		}
		
		private function mRemoveMenuActionHandlers():void
		{
			oActionMenu.removeEventListener("MOVECHARACTER", evSetMotionHandler);
			oActionMenu.removeEventListener("ATTACKCHARACTER", evAttackHandler);
			oActionMenu.removeEventListener("CANCELACTION", evCancelHandler);
		}
		
		private function mSetMotion():void
		{
			if (_aVectorCharacter[_aPointerCharaVector].mGetCharacterAt(_aColumnNumber, _aRowNumber) && _aVectorCharacter[_aPointerCharaVector].aCharaWalk == true)
			{
				aGrabbedCharacter = true;
				_aVectorCharacter[_aPointerCharaVector].aPastRow = _aRowNumber;
				_aVectorCharacter[_aPointerCharaVector].aPastCol = _aColumnNumber;
				mDestroyPointer();
				_aVectorCharacter[_aPointerCharaVector].addEventListener("RELEASE", evCharaRelease);
				_aVectorCharacter[_aPointerCharaVector].mCharaWalk();
			}
		}
		
		private function mGenerateGameMenu():void
		{
			Main.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evKeyPushed);
			oGameMenu.mScreenInitialize();
			oGameMenu.addEventListener("RESTART", evRestartHandler);
			oGameMenu.addEventListener("MENU", evMenuHandler);
			oGameMenu.addEventListener("SAVE", evSaveHandler);
			oGameMenu.addEventListener("LOAD", evLoadHandler);
			oGameMenu.addEventListener("RETURN", evReturnHandler);
		}
		
		protected function evRestartHandler(event:Event):void
		{
			mRemoveGameMenuHandlers();
			Screen.aRestartFlag = true;
			_oHUDManager.mRemoveHUD();
		}
		
		protected function evMenuHandler(event:Event):void
		{
			mRemoveGameMenuHandlers();
			Screen.aMenuFlag = true;
			_oHUDManager.mRemoveHUD();
		}
		
		protected function evSaveHandler(event:Event):void
		{
			mRemoveGameMenuHandlers();
			oSaveStorage.mSaveGame();
			Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyPushed);
		}
		
		protected function evLoadHandler(event:Event):void
		{
			mRemoveGameMenuHandlers();
			_oHUDManager.mRemoveHUD();
			oSaveStorage.mLoadGame();
			Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyPushed);
		}
		
		protected function evReturnHandler(event:Event):void
		{
			mRemoveGameMenuHandlers();
			Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyPushed);
		}
		
		private function mRemoveGameMenuHandlers():void
		{
			oGameMenu.removeEventListener("RESTART", evRestartHandler);
			oGameMenu.removeEventListener("MENU", evMenuHandler);
			oGameMenu.removeEventListener("SAVE", evSaveHandler);
			oGameMenu.removeEventListener("LOAD", evLoadHandler);
			oGameMenu.removeEventListener("RETURN", evReturnHandler);
		}
		
		//Animacion Terminada
		protected function evBattleAnimationOver(e:Event):void
		{
			_aGuideMap.oBattleAnimation.removeEventListener("AnimationOverPointer", evBattleAnimationOver);
			_aGuideMap.oBattleAnimation.mHideBattleAnimation();
			mSetPointer();
			_aGuideMap.aMapSound.mPlayRepeat();
			mCheckVictory();
			if (_aFlagPhase == true && _aVictory == false)
				mShowPhaseAnimation();
		}
		
		protected function evPhaseAnimationOver(e:Event):void
		{
			_aGuideMap._oPhaseAnimation.removeEventListener("AnimationOverPointer", evPhaseAnimationOver);
			_aGuideMap._oPhaseAnimation.mHideAnimation();
			mSetPointer();
		}
		
		protected function evWinBAnimationOver(event:Event):void
		{
			_aGuideMap._oWinBAnimation.removeEventListener("AnimationOverPointer", evWinBAnimationOver);
			_aGuideMap._oWinBAnimation.mHideAnimation();
			_oHUDManager.mRemoveHUD();
			aVictory = true;
		}
		
		protected function evWinRAnimationOver(event:Event):void
		{
			_aGuideMap._oWinRAnimation.removeEventListener("AnimationOverPointer", evWinRAnimationOver);
			_aGuideMap._oWinRAnimation.mHideAnimation();
			_oHUDManager.mRemoveHUD();
			aVictory = true;
		}
		
		
		
		private function mAttackDetection():void
		{
			_aColumnNumber = _aVectorCharacter[_aPointerCharaVector].aGraph.x / vTileSize;
			_aRowNumber = _aVectorCharacter[_aPointerCharaVector].aGraph.y / vTileSize;
			mSetPointer();
			if (!mCheckVictory())
			{
				if (!_aVectorCharacter[_aPointerCharaVector].aCharaWalk)
				{
					if (_aVectorCharacter[_aPointerCharaVector].mChekAttackRange(_aColumnNumber, _aRowNumber, _aPointerCharaVector) == true) 
						_aPhaseAttack = true;
					else mCheckTeamTurn();
				}
			}
		}
		
		/**Metodo que devuelve el valor donde Spawnea el Puntero despues de mover un Personaje y Comprueba la posibilidad de Ataque.
		 * 
		 * */
		public function evCharaRelease(e:KeyboardEvent):void
		{
			_aVectorCharacter[_aPointerCharaVector].removeEventListener("RELEASE", evCharaRelease);
			_aSelectSound.mPlay();
			mAttackDetection();
		}
		
		
		public function mCheckVictory():Boolean
		{
			if (
				( (_aGuideMap.mGetGuideMap()[_aRowNumber][_aColumnNumber] == 01) && (this._aActualTeam == "R") )
				
				|| ((_aGuideMap.mGetGuideMap()[_aRowNumber][_aColumnNumber] == 02) && (this._aActualTeam == "A"))
				|| (_aTotalBlue == 0)
				|| (_aTotalRed == 0)
			) 
			{
				mDestroyPointer();
				_aVictory = true;
				if (_aActualTeam == "A")
				{	_aGuideMap._oWinBAnimation.mShowAnimation();
					_aGuideMap._oWinBAnimation.addEventListener("AnimationOverPointer", evWinBAnimationOver);
					_aGuideMap.aMapSound.mStop();
					_aGuideMap.aVictorySound.mPlay();
				}
				else
				{
					_aGuideMap._oWinRAnimation.mShowAnimation();
					_aGuideMap._oWinRAnimation.addEventListener("AnimationOverPointer", evWinRAnimationOver);
					_aGuideMap.aMapSound.mStop();
					_aGuideMap.aVictorySound.mPlay();
				}
				return true;
			}
			return false;	
		}
	}
}