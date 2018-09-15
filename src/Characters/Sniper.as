package Characters
{
	import Maps.Map;
	
	public class Sniper extends Soldier
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
		public function Sniper(pGraph:Class, pMap:Map, pLife:int, pSpeed:int, pAccPoint:int, pTeam:String, pWalk:Boolean, pType:String)
		{
			super(pGraph, pMap, pLife, pSpeed, pAccPoint, pTeam, pWalk, pType);
			aGraph.gotoAndStop(ANIM_IDLE);
			aWeapon = new Weapon(3);
			_aWalkRange = new Ranges(5);
			_aAttackRange = new Ranges(6);
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
			var flag:Boolean = false;
			for (var i:int = 5; i < 8; i++) 
			{
				if (aActualMap.mGetCharacterPositions(pColumn+i, pRow, pPointer, aTeam)||
					aActualMap.mGetCharacterPositions(pColumn-i, pRow, pPointer, aTeam)||
					aActualMap.mGetCharacterPositions(pColumn, pRow+i, pPointer, aTeam)||
					aActualMap.mGetCharacterPositions(pColumn, pRow-i, pPointer, aTeam)
					)
				{
					if (aActualMap.mGetCharacterPositions(pColumn+i, pRow, pPointer, aTeam)) 
						aAttackArray.push(aActualMap.mGetCharacterIndex(pColumn+i, pRow));
					
					if (aActualMap.mGetCharacterPositions(pColumn-i, pRow, pPointer, aTeam)) 
						aAttackArray.push(aActualMap.mGetCharacterIndex(pColumn-i, pRow));
					
					if (aActualMap.mGetCharacterPositions(pColumn, pRow+i, pPointer, aTeam))
						aAttackArray.push(aActualMap.mGetCharacterIndex(pColumn, pRow+i));
					
					if (aActualMap.mGetCharacterPositions(pColumn, pRow-i, pPointer, aTeam)) 
						aAttackArray.push(aActualMap.mGetCharacterIndex(pColumn, pRow-i));
					
					this._aAttackRange.mShowRange(pRow,pColumn);
					mAnimationDrawWeapon();
					flag = true;
				}
			}
			if (flag) 
				return true;
			else return false;
		}
	}
}