package Utilities
{
	import Characters.Soldier;
	
	import flash.display.MovieClip;
	import flash.filters.ColorMatrixFilter;
	
	public class Utils
	{
		public function Utils()
		{
		}
		
		static public function mMakeGrayMC(pMovieClip:MovieClip):void
		{
			// Make Grey
			var r:Number=0.212671;
			var g:Number=0.715160;
			var b:Number=0.072169;
			
			var matrix:Array = [];
			matrix = matrix.concat([r, g, b, 0, 0]);// red
			matrix = matrix.concat([r, g, b, 0, 0]);// green
			matrix = matrix.concat([r, g, b, 0, 0]);// blue
			matrix = matrix.concat([0, 0, 0, 1, 0]);// alpha
			pMovieClip.filters = [new ColorMatrixFilter(matrix)];
		}
		
		static public function mRemoveGrayMC(pMovieClip:MovieClip):void
		{
			// Return to normal
			pMovieClip.filters = [new ColorMatrixFilter()];
		}
		
		
		/**Detecta si un Personaje se encuentra en esta pocision.
		 * 		@param pXPosition Pocision en X del Puntero.
		 *  	@param pYPosition Pocision en Y del Puntero.
		 * */
		public static function mGetCharacterAt(pXPosition:int, pYPosition:int, pVector:Vector.<Soldier>):Boolean
		{
			for each (var vChar:Soldier in pVector) 
			{
				if (pXPosition * 96 == vChar.aGraph.x && pYPosition * 96 == vChar.aGraph.y) 
				{
					return true;
				}
			}
			return false;
		}
	}
}