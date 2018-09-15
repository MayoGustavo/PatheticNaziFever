package Characters
{
	import Maps.Map;
	
	import Screens.Screen;
	import Utilities.Utils;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import flashx.textLayout.formats.WhiteSpaceCollapse;

	public class Soldier extends EventDispatcher
	{
		//Atributos
		public var aGraph:MovieClip;
		public var aLife:int;
		public var aSpeed:int;
		public var aWeapon:Weapon;
		public var aType:String;
		public var aAttackArray:Array;
		//
		public var _aWalkRange:Ranges;
		public var _aAttackRange:Ranges;
		//
		public var aActualMap:Map;
		public var aTeam:String;
		public var aCharaSelected:Boolean;
		public var aCharaWalk:Boolean;
		public var aRowChara:int;
		public var aColumnChara:int;
		public var aPastRow:int;
		public var aPastCol:int;
		
		//Constantes
		public var vTileSize:int = 96;
		
		//Costructor
		public function Soldier(pGraph:Class, pMap:Map, pLife:int, pSpeed:int, pAccPoint:int, pTeam:String, pWalk:Boolean, pType:String)
		{
			this.aActualMap = pMap;
			this.aLife = pLife;
			this.aSpeed = pSpeed;
			this.aTeam = pTeam;
			this.aCharaWalk = pWalk;
			this.aType = pType;
			this.aCharaSelected = false;
			this.aAttackArray = new Array();
			aGraph = new pGraph;
		}
		
		/**Funcion de Spawn de los Personajes en el escenario.
		 * 		@param pXPosition da la posicion en X donde Spawnea el Personaje
		 *  	@param pYPosition da la posicion en Y donde Spawnea el Personaje
		 * */
		public function mCharaSpawn(pXPosition:int, pYPosition:int):void
		{
			Screen.oCharacterContainer.addChild(aGraph);
			aGraph.x = pXPosition;
			aGraph.y = pYPosition;
		}
		
		/**Obtiene el objeto Arma del Personaje.
		 * */
		public function mGetMeleeWeapon():Weapon
		{
			return aWeapon;
		}
		
		/**Detecta si un Personaje se encuentra en esta pocision.
		 * 		@param pXPosition Pocision en X del Puntero.
		 *  	@param pYPosition Pocision en Y del Puntero.
		 * */
		public function mGetCharacterAt(pXPosition:int, pYPosition:int):Boolean
		{
			if (pXPosition * vTileSize == aGraph.x && pYPosition * vTileSize == aGraph.y) 
			{
				return true;
			}
			return false;
		}
		
		/**Remover grafica del Personaje.
		 * */
		public function mCharacterRemove():void
		{
			Screen.oCharacterContainer.removeChild(aGraph);
		}
		
		/**Resta puntos de vida del Personaje.
		 * */
		public function mReceiveDamage(pDamage:int):void
		{
			this.aLife -= pDamage;
		}
		
		/**Funcion que mueve el Character segun su Speed
		 * 	@param pCharacterSpeed: Cantida de casilleros que puede moverse el personaje
		 * 		 
		 * */
		public function mCharaWalk():void
		{
			aCharaSelected = true;
			mAnimationWalk();
			this._aWalkRange.mLimitWalk(aGraph.x, aGraph.y, aSpeed);
			aRowChara = (this._aWalkRange.vLimitArray.length/2);
			aColumnChara = (this._aWalkRange.vLimitArray.length/2);
			_aWalkRange.mShowRange(aGraph.y / 96 , aGraph.x / 96);
			_aAttackRange.mShowRange(aGraph.y / 96 , aGraph.x / 96);
			Main.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evCharaKeyPushed);
		}
		
		/** Comprueba Rango de ataque.
		 * */
		//Metodo para Override, ver clases hijas.
		public function mChekAttackRange(pColumn:int, pRow:int, pPointer:int):Boolean
		{
			return false;
		}
		
		/** Llama animacion de Caminar.
		 * */
		//Metodo para Override, ver clases hijas.
		public function mAnimationWalk():void	{	}
		
		/** Llama animacion de Idle.
		 * */
		//Metodo para Override, ver clases hijas.
		public function mAnimationIdle():void	{	}
		
		/** Llama animacion de Sacar Arma.
		 * */
		//Metodo para Override, ver clases hijas.
		public function mAnimationDrawWeapon():void	{	}
		
		/** Llama animacion de Guardar Arma.
		 * */
		//Metodo para Override, ver clases hijas.
		public function mAnimationHideWeapon():void	{	}
		
		/** Metodo que se activa la Seleccionar un personaje para que este Camine.
		 * */
		private function evCharaKeyPushed(evKeyboard:KeyboardEvent):void
		{
			if (aCharaSelected == true)
			{
				switch(evKeyboard.keyCode)
				{
					case Keyboard.UP:
					{
						if ((this._aWalkRange.mGetterValueAt(aColumnChara, aRowChara-1)))
						{
							//Terreno Caminable o no.
							if (this.aActualMap.mGetWalkAble((aGraph.y / vTileSize)-1,aGraph.x/vTileSize)) 
							{
								this.aGraph.y -= vTileSize;
								aRowChara -= 1
								_aAttackRange.mHideRange();
								_aAttackRange.mShowRange(aGraph.y / 96 , aGraph.x / 96);
							}
						}
					}	
						break;
					case Keyboard.DOWN:
					{
						if ((this._aWalkRange.mGetterValueAt(aColumnChara, aRowChara+1)))
						{
							//Terreno Caminable o no.
							if (aActualMap.mGetWalkAble((aGraph.y / vTileSize)+1,aGraph.x/vTileSize))
							{
								this.aGraph.y += vTileSize;
								aRowChara += 1;
								_aAttackRange.mHideRange();
								_aAttackRange.mShowRange(aGraph.y / 96 , aGraph.x / 96);
							}
						}
					}	
						break;
					case Keyboard.LEFT:
					{
						if ((this._aWalkRange.mGetterValueAt(aColumnChara-1, aRowChara)))
						{
							//Terreno Caminable o no.
							if (aActualMap.mGetWalkAble(aGraph.y / vTileSize,(aGraph.x/vTileSize)-1)) 
							{
								this.aGraph.x -= vTileSize;
								aColumnChara -= 1;
								_aAttackRange.mHideRange();
								_aAttackRange.mShowRange(aGraph.y / 96 , aGraph.x / 96);
							}
						}
					}	
						break;
					case Keyboard.RIGHT:
					{
						if ((this._aWalkRange.mGetterValueAt(aColumnChara+1, aRowChara)))
						{
							//Terreno Caminable o no.
							if (aActualMap.mGetWalkAble(aGraph.y / vTileSize,(aGraph.x/vTileSize)+1))
							{
								this.aGraph.x += vTileSize;
								aColumnChara += 1;
								_aAttackRange.mHideRange();
								_aAttackRange.mShowRange(aGraph.y / 96 , aGraph.x / 96);
							}
						}
					}	
						break;
					case Keyboard.S:
					{
						aRowChara = aPastRow;
						aColumnChara = aPastCol;
						aGraph.x = aColumnChara * 96;
						aGraph.y = aRowChara * 96;
						this.aCharaSelected = false;
						this.aCharaWalk = true;
						mAnimationIdle();
						Main.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evCharaKeyPushed);
						_aWalkRange.mHideRange();
						_aAttackRange.mHideRange();
						dispatchEvent(new KeyboardEvent("RELEASE"));
					}	
						break;
					case Keyboard.A:
					{
						if (aActualMap.mGetCharacterPosition(aGraph.x / 96 , aGraph.y / 96,aActualMap.mGetCharacterIndex(aGraph.x / 96 , aGraph.y / 96)) == false) 
						{
							this.aCharaSelected = false;
							this.aCharaWalk = false;
							Utils.mMakeGrayMC(this.aGraph);
							mAnimationIdle();
							Main.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evCharaKeyPushed);
							_aWalkRange.mHideRange();
							_aAttackRange.mHideRange();
							dispatchEvent(new KeyboardEvent("RELEASE"));
						}
						else
						{aActualMap.aErrorSound.mPlay(); }
					}
						break;
				}
			}
		}
		
		
	}
}