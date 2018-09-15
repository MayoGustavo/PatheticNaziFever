package Characters
{
	import Screens.Screen;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class Ranges
	{
		public var vLimitArray: Array = new Array();
		public var aGraph:MovieClip;
		//Constantes
		public var vTileSize:int = 96;
		
		public function Ranges(pType:int)
		{
			aGraph = new MCRange();
			//aGraph = Main.oAssetsManager.mGetMovieClip("MCRange");
			aGraph.gotoAndStop(pType);
		}
		
		public function mShowRange(pRow:int, pColumn:int):void
		{
			Screen.oRangeContainer.addChild(aGraph);
			aGraph.x = pColumn * vTileSize;
			aGraph.y = pRow * vTileSize;
		}
		
		public function mHideRange():void
		{
			Screen.oRangeContainer.removeChild(aGraph);
		}
		
		/**Metodo que generea el Area de Movimiento del Personaje segun sea su Velocidad
		 * @param pSpeed Es la velocidad que toma el el metodo del Personaje para generar el Rombo
		 * 
		 * */
		
		public function mSetterValue (row: int, column: int, value: int):void
		{
			this.vLimitArray[row][column] = value;
		}
		
		public function mGetterValueAt(row: int, column: int):Boolean
		{
			if (row < 0 || column < 0 || row >= vLimitArray.length || column >= vLimitArray.length)
			{
				return false
			}else if (this.vLimitArray[row][column] == 1)
				{
					return true;
				}else
				{
					return false;
				}
		}
		
		/**Metodo que genera el Algoritmo para determina el Area de Movimiento del personaje Con respecto a su Velocidad
		 * y la dibuja en pantalla
		 * 
		 * @param pCharaX otorga la posicion del Charater.X
		 * @param pCharaY otorga la posicion del Charater.Y
		 * @param pSpeed otorga la velocidad que determina el area de movimineto del Personaje
		 * 
		 * */
		public function mLimitWalk (pCharaX:int, pCharaY:int, pSpeed:int):void
		{
			var vArea : int = (pSpeed*2)-2;
			var vMidArea : int = (vArea/2);
			var posX : int = (pCharaX / vTileSize) - pSpeed+1;
			var posY : int = (pCharaY / vTileSize) - pSpeed+1;
			for (var row:int = 0; row <= vMidArea; row++) 
			{
				this.vLimitArray[row] = new Array();
				for (var collum:int = 0; collum <= vArea; collum++) 
				{
					if (collum == vMidArea)
					{
						for (var i:int = -row; i < (row+1); i++)
						{
							mSetterValue(row, collum+i, 1);
							
						}
						if (row == 0) 
						{
							mSetterValue(row, collum+row, 1);							
						}
					}else if(vLimitArray[row][collum] == null)
					{
						mSetterValue(row, collum, 0);							
					}else
					{}
				}
				
			}
			for (row = vArea; row >= vMidArea+1; row--) 
			{
				vLimitArray[row] = new Array();
				collum=0;
				for (collum = 0; collum <= vArea; collum++)  
				{
					if (collum == vMidArea)
					{
						for ( i = (row-vArea); i < ((vArea-row)+1); i++)
						{
							mSetterValue(row, collum+i, 1);							
						}
						if (row == 0) 
						{
							mSetterValue(row, collum+row, 1);							
							
						}
					}else if(vLimitArray[row][collum] == null)
					{
						mSetterValue(row, collum, 0);							
					}else
					{}
				}
				
			}
			
			for (i = 0; i < vLimitArray.length; i++) 
			{
				for (var j: int = 0; j < vLimitArray.length; j++) 
				{
					if (vLimitArray[i][j] == 1)
					{
						//mDrawLimitArea(0x000000,((posX+j)*100),((posY+i)*100), 100, 100);
					}
				}
				
			}
			
			
		}
		
		
		
		/*public function mDestroyLimitArea():void
		{
		for (var i:int = 0; i < vLimitArray.length; i++) 
		{
		for (var j: int = 0; j < vLimitArray.length; j++) 
		{
		if (vLimitArray[i][j] == 1)
		{
		Main.mainStage.removeChild(
		}
		}
		
		}
		}*/
		
		public function mDrawLimitArea(color:int, posX:int, posY:int, ancho:int, alto:int):Sprite
		{
			var dibujo:Sprite = new Sprite();
			
			dibujo.graphics.beginFill(color,0.1);
			dibujo.graphics.drawRect(posX,posY,ancho,alto);
			dibujo.graphics.endFill();
			Main.mainStage.addChild(dibujo);
			
			return dibujo;
		}
		
	}
}