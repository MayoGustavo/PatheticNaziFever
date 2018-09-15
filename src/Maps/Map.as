package Maps
{
	import Characters.Soldier;
	
	import Utilities.Animation;
	import Utilities.CustomSound;
	import Screens.Screen;
	
	import adobe.utils.CustomActions;
	
	import flash.media.Sound;
	import flash.net.URLRequest;

	public class Map
	{
		private var _aGuideMap:Array = new Array();
		private var _aRealMap:Array = new Array();			
		public var _aRowNumber:int = 14;
		public var _aColumnNumber:int = 22;
		public var oBattleAnimation:Animation;
		public var _oPhaseAnimation:Animation;
		public var _oWinBAnimation:Animation;
		public var _oWinRAnimation:Animation;
		public var aVectorCharacter:Vector.<Soldier>;
		public var aMapSound:CustomSound;
		public var aVictorySound:CustomSound;
		public var aErrorSound:CustomSound;
		
		public function Map(pGuideMap:Array)
		{
			this._aGuideMap = pGuideMap;
			oBattleAnimation = new Animation(MCAnimationBattle);
			_oPhaseAnimation = new Animation(MCChangePhase);
			_oWinBAnimation = new Animation(MCBlueWin);
			_oWinRAnimation = new Animation(MCRedWin);
			this.aMapSound = new CustomSound(Main.oAssetsManager.mGetSound(6));
			this.aVictorySound = new CustomSound(Main.oAssetsManager.mGetSound(8));
			this.aErrorSound = new CustomSound(Main.oAssetsManager.mGetSound(3));
		}
		
		/** Comprueba la pocision de un Personaje.
		 *  @param pRowNumber Fila de la Matriz.
		 *  @param pColumnNumber Columna de la Matriz.
		 *  @param pIndex Indice del personaje que se mueve.
		 * */
		public function mGetCharacterPositions(pRowNumber:int, pColumnNumber:int, pIndex:int, pTeam:String):Boolean
		{
			for (var i:int = 0; i < aVectorCharacter.length; i++) 
			{	
				if((aVectorCharacter[i].mGetCharacterAt(pRowNumber, pColumnNumber)) && (i != pIndex) && (aVectorCharacter[i].aTeam != pTeam))
				{
					return true
				}
			}
			return false;
		}
		
		/** Comprueba la pocision de un Personaje.
		 *  @param pRowNumber Fila de la Matriz.
		 *  @param pColumnNumber Columna de la Matriz.
		 * */
		public function mGetCharacterPosition(pRowNumber:int, pColumnNumber:int, pIndex:int):Boolean
		{
			for (var i:int = 0; i < aVectorCharacter.length; i++) 
			{	
				if ((aVectorCharacter[i].mGetCharacterAt(pRowNumber, pColumnNumber)) && (i != pIndex))
				{
					return true
				}
			}
			return false;
		}
		
		
		/** Obtiene el Team al que pertenece un Personaje.
		 *  @param pRowNumber Fila de la Matriz.
		 *  @param pColumnNumber Columna de la Matriz.
		 * */
		public function mGetCharacterTeam(pRowNumber:int, pColumnNumber:int):String
		{
			for (var i:int = 0; i < aVectorCharacter.length; i++) 
			{	
				if(aVectorCharacter[i].mGetCharacterAt(pRowNumber, pColumnNumber))
				{
					return aVectorCharacter[i].aTeam;
				}
			}
			return "";
		}
		
		/** Obtiene el indice del Personaje en el Vector.
		 *  @param pRowNumber Fila de la Matriz.
		 *  @param pColumnNumber Columna de la Matriz.
		 * */
		public function mGetCharacterIndex(pRowNumber:int, pColumnNumber:int):int
		{
			for (var i:int = 0; i < aVectorCharacter.length; i++) 
			{	
				if(aVectorCharacter[i].mGetCharacterAt(pRowNumber, pColumnNumber))
				{
					return i;
				}
			}
			return -1;
		}
		
		/** Obtiene el Objeto Mapa Real.
		 * */
		public function mGetRealMap():Array
		{
			return _aRealMap;
		}
		
		/** Obtiene el Objeto Mapa Guia.
		 * */
		public function mGetGuideMap():Array
		{
			return _aGuideMap;
		}
		
		/** Devuelve el valor Booleano que representa la propiedad de un Tile caminable 
		 *  @param pRowNumber Fila de la Matriz.
		 *  @param pColumnNumber Columna de la Matriz.
		 * */
		public function mGetWalkAble(pRowNumber:int, pColumnNumber:int):Boolean
		{
			return _aRealMap[pRowNumber][pColumnNumber].aWalkAble;
		}
		
		/** Crea un Mapa Real basado en un Mapa Guia.
		 * */
		public function mCreateMap():void
		{
			for (var Row:int = 0; Row < _aRowNumber; Row++) 
			{
				_aRealMap[Row] = new Array();
				for (var Column:int = 0; Column < _aColumnNumber; Column++) 
				{
					_aRealMap[Row][Column] = new Tile(_aGuideMap[Row][Column],
						_aGuideMap[Row][Column] == 01 ||
						_aGuideMap[Row][Column] == 02 ||
						_aGuideMap[Row][Column] == 73 ||
						_aGuideMap[Row][Column] == 76 ||
						_aGuideMap[Row][Column] == 05 ||
						_aGuideMap[Row][Column] == 06 ||
						_aGuideMap[Row][Column] == 07 ||
						_aGuideMap[Row][Column] == 08 ||
						_aGuideMap[Row][Column] == 09 ||
						_aGuideMap[Row][Column] == 10 ||
						_aGuideMap[Row][Column] == 11 ||
						_aGuideMap[Row][Column] == 12 ||
						_aGuideMap[Row][Column] == 13 ||
						_aGuideMap[Row][Column] == 14 ||
						_aGuideMap[Row][Column] == 15 ||
						_aGuideMap[Row][Column] == 16 ||
						_aGuideMap[Row][Column] == 17 ||
						_aGuideMap[Row][Column] == 18 ||
						_aGuideMap[Row][Column] == 19 ||
						_aGuideMap[Row][Column] == 20 ||
						_aGuideMap[Row][Column] == 21 ||
						_aGuideMap[Row][Column] == 22 ||
						_aGuideMap[Row][Column] == 23 ||
						_aGuideMap[Row][Column] == 24 ||
						_aGuideMap[Row][Column] == 25 );
					Screen.oMapTileContainer.addChild(_aRealMap[Row][Column].aGraph);
					_aRealMap[Row][Column].aGraph.x = Column * _aRealMap[Row][Column].aGraph.width;
					_aRealMap[Row][Column].aGraph.y = Row * _aRealMap[Row][Column].aGraph.height;
				}
			}
		}
		
		/** Destruye el Mapa Real, dejando el escenario libre para la carga de un nuevo Mapa Guia.
		 * */
		public function mDestroyMap():void
		{
			for (var Row:int = 0; Row < _aRowNumber; Row++) 
			{
				for (var Column:int = 0; Column < _aColumnNumber; Column++) 
				{
					Screen.oMapTileContainer.removeChild(_aRealMap[Row][Column].aGraph);
				}
			}
			_aRealMap = new Array();
		}
		
	}
}