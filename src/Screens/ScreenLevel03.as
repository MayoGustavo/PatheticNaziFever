package Screens
{
	import Characters.GreenBeret;
	import Characters.Gunner;
	import Characters.Sniper;
	import Characters.Soldier;
	
	import Maps.Map;
	import Maps.Pointer;
	

	public class ScreenLevel03 extends Screen
	{
		public function ScreenLevel03()
		{
			super();
			oMap = new Map
				([ [ 30, 43, 76, 76, 75, 75, 75, 75, 61, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 76, 58, 53, ],
					[ 69, 01, 75, 75, 45, 54, 54, 53, 69, 76, 76, 73, 77, 77, 73, 73, 73, 73, 73, 75, 02, 69, ],
					[ 69, 05, 03, 73, 69, 73, 73, 07, 73, 75, 75, 71, 73, 73, 73, 77, 77, 73, 73, 04, 10, 69, ],
					[ 69, 05, 17, 73, 69, 09, 59, 62, 73, 73, 73, 73, 73, 77, 73, 73, 71, 77, 06, 08, 17, 69, ],
					[ 69, 23, 73, 73, 56, 23, 54, 54, 62, 73, 77, 73, 77, 73, 73, 73, 73, 73, 73, 23, 73, 69, ],
					[ 69, 23, 73, 73, 38, 09, 58, 58, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 73, 69, ],
					[ 69, 23, 73, 77, 07, 19, 24, 78, 73, 77, 73, 73, 71, 73, 71, 73, 73, 73, 73, 73, 73, 69, ],
					[ 69, 23, 73, 77, 73, 78, 05, 07, 06, 73, 73, 73, 73, 73, 77, 73, 73, 73, 71, 73, 73, 69, ],
					[ 69, 77, 73, 77, 73, 45, 23, 54, 41, 77, 77, 73, 71, 73, 73, 73, 73, 73, 73, 73, 77, 69, ],
					[ 69, 73, 73, 73, 73, 38, 23, 64, 63, 58, 53, 21, 73, 73, 73, 73, 71, 73, 77, 77, 73, 69, ],
					[ 69, 73, 77, 73, 73, 73, 15, 07, 06, 07, 06, 16, 73, 73, 77, 73, 73, 73, 73, 73, 73, 69, ],
					[ 69, 73, 77, 77, 73, 73, 77, 77, 77, 07, 77, 69, 71, 73, 77, 73, 73, 77, 77, 77, 73, 69, ],
					[ 69, 73, 77, 73, 73, 73, 73, 73, 73, 73, 73, 69, 73, 73, 77, 73, 73, 73, 73, 73, 73, 69, ],
					[ 38, 58, 58, 58, 58, 58, 58, 58, 58, 58, 29, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 29, ], ]);
			
			oCharacter = new Vector.<Soldier>;
			oPointer = new Pointer(oMap, oCharacter, 4, 4);
		}
		
		public override function mScreenInitialize():void
		{
			oConsole.mInitializeConsole();
			oMap.aVectorCharacter = oCharacter;
			oMap.mCreateMap();
			Main.mainStage.focus = Main.mainStage;

			oCharacter.push(new Gunner(MCGunnerA, oMap,5,4,1,"A",true, "Gunner"));
			oCharacter.push(new Gunner(MCGunnerA, oMap,5,4,1,"A",true, "Gunner"));
			oCharacter.push(new GreenBeret(MCBeretA, oMap,5,5,1,"A",true, "Beret"));
			oCharacter.push(new Sniper(MCSniperA, oMap,5,3,1,"A",true, "Sniper"));
			
			oCharacter.push(new Gunner(MCGunnerN, oMap,5,4,1,"R",false, "Gunner"));
			oCharacter.push(new Gunner(MCGunnerN, oMap,5,4,1,"R",false, "Gunner"));
			oCharacter.push(new GreenBeret(MCBeretN, oMap,5,5,1,"R",false, "Beret"));
			oCharacter.push(new Sniper(MCSniperN, oMap,5,3,1,"R",false, "Sniper"));
			
			oCharacter[0].mCharaSpawn(288, 192);
			oCharacter[1].mCharaSpawn(96, 192);
			oCharacter[2].mCharaSpawn(192, 288);
			oCharacter[3].mCharaSpawn(96, 480);
			
			oCharacter[4].mCharaSpawn(1920, 192);
			oCharacter[5].mCharaSpawn(1824, 288);
			oCharacter[6].mCharaSpawn(1824, 672);
			oCharacter[7].mCharaSpawn(1920, 1152);
			
			oPointer.mSetPointer();
			oMap.aMapSound.mPlayRepeat();
		}
		
		public override function mScreenRefresh():void
		{
			if (oPointer.aVictory == true) 
			{
				aGotoScreen = "ScreenStageSelection";
				oMap.aVictorySound.mStop();
			}
			
			if (aMenuFlag)
			{
				aMenuFlag = false;
				aGotoScreen = "ScreenMenu";
			}
			
			if (aRestartFlag)
			{
				aRestartFlag = false;
				aGotoScreen = "ScreenLevel03";
			}
		}
		
		public override function mScreenDestroy():void
		{
			super.mScreenDestroy();
			oMap.mDestroyMap();
			oConsole.mCloseConsole();
			for (var i:int =oCharacter.length-1 ; i > -1; i--) 
			{
				oCharacter[i].mCharacterRemove();
				oCharacter.splice(i,1);
			}
			oPointer.mDestroyPointer();
			oMap.aMapSound.mStop();
		}
	}
}