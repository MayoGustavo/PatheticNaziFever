package Characters
{
	public class Weapon
	{
		private var _aDamage:int;
		
		public function Weapon(pDamage:int)
		{
			this._aDamage = pDamage;
		}
		
		/** Obtiene el Daño del Arma.
		 * */		
		public function mGetDamage():int
		{
			return _aDamage;
		}
		
		/** Setea el Daño del Arma.
		 * */	
		public function mSetDamage(pDamage:int):void
		{
			this._aDamage = pDamage;
		}
	}
}