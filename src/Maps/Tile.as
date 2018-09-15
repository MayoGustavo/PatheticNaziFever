package Maps
{
	import flash.display.MovieClip;
	import flash.utils.setInterval;

	public class Tile
	{
		public var aGraph:MovieClip;
		public var aWalkAble:Boolean;
		
		/** Objeto Tile.
		 *  @param pType Especifica el tipo de Tile dentro del archivo SWC.
		 *  @param pWalkAble Especifica si este Tile podra ser caminable o no.
		 * */
		public function Tile(pType:int, pWalkAble:Boolean)
		{
				this.aWalkAble = pWalkAble;
				aGraph = new MCTileMap();
				aGraph.gotoAndStop(pType);
		}
	}
}