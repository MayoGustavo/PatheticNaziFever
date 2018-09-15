package Characters
{
	import Maps.Map;
	
	public class GreenBeret extends Soldier
	{
		public const ANIM_IDLE:String = "Idle";
		public const ANIM_DP:String = "Draw";
		public const ANIM_R:String = "Run";
		public const ANIM_HP:String = "Hide";
		
		/**Constructor.
		 * 		@param pGraph Grafica.
		 *  	@param pMap Mapa Actual.
		 * *  	@param pLife Vida del Personaje.
		 * *  	@param pSpeed Casilleros que puede mover.
		 * *  	@param pAccPoint Precision.
		 * *  	@param pTeam Faccion.
		 * *  	@param pWalk Puede caminar o no.
		 * */
		public function GreenBeret(pGraph:Class, pMap:Map, pLife:int, pSpeed:int, pAccPoint:int, pTeam:String, pWalk:Boolean, pType:String)
		{
			super(pGraph, pMap, pLife, pSpeed, pAccPoint, pTeam, pWalk, pType);
			aGraph.gotoAndStop(ANIM_IDLE);
			aWeapon = new Weapon(5);
			_aWalkRange = new Ranges(1);
			_aAttackRange = new Ranges(2);
		}
		
		public override function mAnimationWalk():void
		{
			aGraph.gotoAndStop(ANIM_R);
		}
		
		public override function mAnimationIdle():void
		{
			aGraph.gotoAndStop(ANIM_IDLE);
		}
		
		public override function mAnimationDrawWeapon():void
		{
			aGraph.gotoAndStop(ANIM_DP);
		}
		
		public override function mAnimationHideWeapon():void
		{
			aGraph.gotoAndStop(ANIM_HP);
		}
		
		/**Funcion que detecta si el Personaje esta disponible para atacar a un rival.
		 * 		@param pColumn Columna desde donde se chequea.
		 *  	@param pRow Fila desde donde se chequea.
		 * *  	@param Indice del Personaje actual.
		 * */
		public override function mChekAttackRange(pColumn:int, pRow:int, pPointer:int):Boolean
		{
			aAttackArray = [ ];
			
			if (aActualMap.mGetCharacterPositions(pColumn+1, pRow, pPointer, aTeam)||
				aActualMap.mGetCharacterPositions(pColumn-1, pRow, pPointer, aTeam)||
				aActualMap.mGetCharacterPositions(pColumn, pRow+1, pPointer, aTeam)||
				aActualMap.mGetCharacterPositions(pColumn, pRow-1, pPointer, aTeam))
			{
				if (aActualMap.mGetCharacterPositions(pColumn+1, pRow, pPointer, aTeam)) 
					aAttackArray.push(aActualMap.mGetCharacterIndex(pColumn+1, pRow));
				
				if (aActualMap.mGetCharacterPositions(pColumn-1, pRow, pPointer, aTeam)) 
					aAttackArray.push(aActualMap.mGetCharacterIndex(pColumn-1, pRow));
						
				if (aActualMap.mGetCharacterPositions(pColumn, pRow+1, pPointer, aTeam))
					aAttackArray.push(aActualMap.mGetCharacterIndex(pColumn, pRow+1));
						
				if (aActualMap.mGetCharacterPositions(pColumn, pRow-1, pPointer, aTeam)) 
					aAttackArray.push(aActualMap.mGetCharacterIndex(pColumn, pRow-1));
				
				this._aAttackRange.mShowRange(pRow,pColumn);
				mAnimationDrawWeapon();
				return true;
			}
			return false;
		}
	}
}