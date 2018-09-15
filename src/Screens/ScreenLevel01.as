package Screens
{
	import Characters.Gunner;
	import Characters.Soldier;
	
	import Maps.Map;
	import Maps.Pointer;

	public class ScreenLevel01 extends Screen
	{
		public function ScreenLevel01()
		{
			super();
			
			oMap = new Map
				([ [	76,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	76,	],
					[	75,	01,	03,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	75,	],
					[	76,	05,	20,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	78,	73,	73,	73,	73,	73,	73,	73,	76,	],
					[	75,	73,	9,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	75,	],
					[	76,	73,	5,	7,	7,	73,	75,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	76,	],
					[	75,	73,	9,	73,	73,	77,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	75,	],
					[	76,	73,	15,	7,	7,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	77,	73,	73,	73,	73,	76,	],
					[	75,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	07,	07,	22,	73,	73,	73,	73,	75,	],
					[	76,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	09,	73,	73,	73,	73,	76,	],
					[	75,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	77,	09,	73,	73,	73,	73,	75,	],
					[	76,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	06,	21,	06,	13,	06,	04,	76,	],
					[	75,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	75,	75,	77,	73,	78,	73,	73,	15,	07,	02,	75,	],
					[	76,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	76,	],
					[	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	75,	], ]);

			oCharacter = new Vector.<Soldier>;
			oPointer = new Pointer(oMap, oCharacter, 3, 3);
			aMenuFlag = false;
			aRestartFlag = false;
		}
		
		public override function mScreenInitialize():void
		{
			super.mScreenInitialize();
			oConsole.mInitializeConsole();
			oMap.aVectorCharacter = oCharacter;
			oMap.mCreateMap();
			Main.mainStage.focus = Main.mainStage;
			
			oCharacter.push(new Gunner(MCGunnerA, oMap,5,4,1,"A",true, "Gunner"));
			oCharacter.push(new Gunner(MCGunnerA, oMap,5,4,1,"A",true, "Gunner"));
			oCharacter.push(new Gunner(MCGunnerA, oMap,5,4,1,"A",true, "Gunner"));
			
			oCharacter.push(new Gunner(MCGunnerN, oMap,5,4,1,"R",false, "Gunner"));
			oCharacter.push(new Gunner(MCGunnerN, oMap,5,4,1,"R",false, "Gunner"));
			oCharacter.push(new Gunner(MCGunnerN, oMap,5,4,1,"R",false, "Gunner"));
			
			oCharacter[0].mCharaSpawn(288, 288);
			oCharacter[1].mCharaSpawn(384, 192);
			oCharacter[2].mCharaSpawn(96, 192);
			
			oCharacter[3].mCharaSpawn(1728, 1056);
			oCharacter[4].mCharaSpawn(1632, 960);
			oCharacter[5].mCharaSpawn(1440, 1152);
			
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
				aGotoScreen = "ScreenLevel01";
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