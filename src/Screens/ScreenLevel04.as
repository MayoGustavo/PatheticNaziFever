package Screens
{
	import Characters.GreenBeret;
	import Characters.Gunner;
	import Characters.Sniper;
	import Characters.Soldier;
	
	import Maps.Map;
	import Maps.Pointer;

	public class ScreenLevel04 extends Screen
	{
		public function ScreenLevel04()
		{
			super();
			
			oMap = new Map
				([ [	76,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	76,	],
					[	75,	77,	77,	77,	77,	77,	77,	77,	77,	77,	77,	77,	73,	73,	73,	73,	71,	73,	71,	73,	76,	75,	],
					[	76,	75,	73,	77,	77,	77,	77,	77,	77,	77,	77,	77,	73,	73,	73,	73,	73,	71,	73,	71,	75,	76,	],
					[	75,	76,	73,	75,	77,	77,	77,	77,	77,	77,	77,	77,	73,	73,	76,	75,	73,	73,	73,	73,	76,	75,	],
					[	76,	75,	73,	73,	75,	77,	77,	77,	77,	77,	77,	77,	73,	73,	75,	76,	73,	73,	71,	73,	75,	76,	],
					[	75,	76,	73,	76,	73,	75,	77,	77,	77,	77,	77,	77,	73,	73,	76,	75,	73,	73,	73,	73,	76,	75,	],
					[	76,	75,	73,	75,	76,	73,	75,	77,	77,	77,	77,	77,	73,	73,	75,	76,	73,	71,	73,	71,	75,	76,	],
					[	75,	76,	73,	73,	75,	76,	73,	75,	77,	77,	77,	77,	73,	73,	76,	75,	73,	73,	73,	73,	76,	75,	],
					[	76,	75,	73,	73,	71,	75,	76,	73,	75,	77,	77,	77,	73,	73,	75,	76,	73,	73,	71,	73,	75,	76,	],
					[	75,	76,	71,	73,	73,	73,	75,	76,	73,	75,	77,	77,	73,	73,	76,	75,	73,	73,	73,	73,	76,	75,	],
					[	76,	75,	73,	73,	71,	73,	73,	75,	76,	73,	75,	77,	73,	73,	75,	76,	73,	71,	73,	73,	75,	76,	],
					[	75,	76,	71,	73,	73,	73,	71,	73,	75,	73,	73,	75,	73,	73,	76,	75,	73,	73,	71,	73,	04,	75,	],
					[	76,	75,	01,	03,	76,	76,	76,	76,	76,	77,	76,	76,	76,	76,	75,	76,	76,	76,	76,	76,	02,	75,	],
					[	75,	73,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	73,	75,	75,	75,	75,	75,	75,	75,	], ]);
			
			oCharacter = new Vector.<Soldier>;
			oPointer = new Pointer(oMap, oCharacter, 6, 6);
		}
		
		
		public override function mScreenInitialize():void
		{
			oConsole.mInitializeConsole();
			oMap.aVectorCharacter = oCharacter;
			oMap.mCreateMap();
			Main.mainStage.focus = Main.mainStage;
			
			oCharacter.push(new Gunner(MCGunnerA, oMap,5,4,1,"A",true, "Gunner"));
			oCharacter.push(new Gunner(MCGunnerA, oMap,5,4,1,"A",true, "Gunner"));
			oCharacter.push(new Sniper(MCSniperA, oMap,5,3,1,"A",true, "Sniper"));
			oCharacter.push(new Sniper(MCSniperA, oMap,5,3,1,"A",true, "Sniper"));
			oCharacter.push(new Sniper(MCSniperA, oMap,5,3,1,"A",true, "Sniper"));
			oCharacter.push(new Sniper(MCSniperA, oMap,5,3,1,"A",true, "Sniper"));
			
			oCharacter.push(new Gunner(MCGunnerN, oMap,5,4,1,"R",false, "Gunner"));
			oCharacter.push(new Gunner(MCGunnerN, oMap,5,4,1,"R",false, "Gunner"));
			oCharacter.push(new Sniper(MCSniperN, oMap,5,3,1,"R",false, "Sniper"));
			oCharacter.push(new Sniper(MCSniperN, oMap,5,3,1,"R",false, "Sniper"));
			oCharacter.push(new Sniper(MCSniperN, oMap,5,3,1,"R",false, "Sniper"));
			oCharacter.push(new Sniper(MCSniperN, oMap,5,3,1,"R",false, "Sniper"));
			
			oCharacter[0].mCharaSpawn(672, 1152);
			oCharacter[1].mCharaSpawn(480, 1056);
			oCharacter[2].mCharaSpawn(384, 1152);
			oCharacter[3].mCharaSpawn(480, 960);
			oCharacter[4].mCharaSpawn(288, 1056);
			oCharacter[5].mCharaSpawn(288, 864);

			oCharacter[6].mCharaSpawn(1440, 960);
			oCharacter[7].mCharaSpawn(1728, 1152);
			oCharacter[8].mCharaSpawn(1440, 1152);
			oCharacter[9].mCharaSpawn(1824, 1152);
			oCharacter[10].mCharaSpawn(1728, 864);
			oCharacter[11].mCharaSpawn(1728, 960);
			
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
				aGotoScreen = "ScreenLevel04";
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