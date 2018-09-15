package Screens
{
	import Characters.GreenBeret;
	import Characters.Gunner;
	import Characters.Sniper;
	import Characters.Soldier;
	
	import Maps.Map;
	import Maps.Pointer;
	

	public class ScreenLevel02 extends Screen
	{
		public function ScreenLevel02()
		{
			super();
			
			oMap = new Map
				([ [	69,	76,	78,	78,	78,	76,	75,	75,	76,	75,	75,	76,	75,	75,	76,	76,	75,	76,	76,	75,	38,	53,	],
					[	69,	75,	73,	73,	73,	75,	73,	73,	75,	73,	73,	75,	73,	73,	75,	75,	73,	75,	75,	73,	73,	69,	],
					[	69,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	69,	],
					[	69,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	69,	],
					[	69,	73,	73,	73,	73,	73,	73,	73,	73,	73,	76,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	69,	],
					[	69,	73,	73,	73,	73,	73,	73,	73,	73,	76,	75,	73,	73,	73,	73,	73,	73,	73,	73,	73,	73,	69,	],
					[	69,	73,	73,	73,	73,	11,	73,	71,	73,	75,	76,	73,	73,	73,	09,	73,	73,	73,	73,	73,	73,	69,	],
					[	69,	77,	77,	07,	06,	10,	73,	73,	73,	76,	75,	73,	71,	73,	08,	73,	73,	73,	77,	77,	77,	69,	],
					[	69,	73,	73,	73,	73,	09,	73,	73,	73,	75,	76,	73,	73,	73,	18,	22,	73,	73,	73,	73,	73,	69,	],
					[	69,	73,	73,	77,	77,	08,	07,	06,	73,	78,	75,	73,	73,	73,	73,	09,	77,	77,	73,	73,	73,	69,	],
					[	69,	73,	73,	73,	73,	16,	73,	30,	27,	27,	27,	54,	27,	53,	73,	18,	22,	73,	73,	73,	73,	69,	],
					[	69,	73,	73,	73,	73,	77,	77,	60,	47,	49,	47,	48,	47,	28,	77,	77,	73,	73,	73,	73,	73,	69,	],
					[	69,	01,	03,	73,	73,	73,	07,	06,	07,	06,	49,	07,	06,	07,	06,	73,	73,	73,	73,	04,	02,	69,	],
					[	38,	58,	58,	58,	58,	58,	58,	35,	49,	48,	48,	49,	47,	68,	58,	58,	58,	58,	58,	58,	58,	29,	], ]);
			
			oCharacter = new Vector.<Soldier>;
			oPointer = new Pointer(oMap, oCharacter, 4, 4);
			aMenuFlag = false;
			aRestartFlag = false;
		}
		
		public override function mScreenInitialize():void
		{
			oConsole.mInitializeConsole();
			oMap.aVectorCharacter = oCharacter;
			oMap.mCreateMap();
			Main.mainStage.focus = Main.mainStage;
			
			oCharacter.push(new Gunner(MCGunnerA, oMap,5,4,1,"A",true, "Gunner"));
			oCharacter.push(new GreenBeret(MCBeretA, oMap,5,5,1,"A",true, "Beret"));
			oCharacter.push(new GreenBeret(MCBeretA, oMap,5,5,1,"A",true, "Beret"));
			oCharacter.push(new Sniper(MCSniperA, oMap,5,3,1,"A",true, "Sniper"));
			
			oCharacter.push(new Gunner(MCGunnerN, oMap,5,4,1,"R",false, "Gunner"));
			oCharacter.push(new GreenBeret(MCBeretN, oMap,5,5,1,"R",false, "Beret"));
			oCharacter.push(new GreenBeret(MCBeretN, oMap,5,5,1,"R",false, "Beret"));
			oCharacter.push(new Sniper(MCSniperN, oMap,5,3,1,"R",false, "Sniper"));
			
			oCharacter[0].mCharaSpawn(288, 960);
			oCharacter[1].mCharaSpawn(384, 1152);
			oCharacter[2].mCharaSpawn(672, 1152);
			oCharacter[3].mCharaSpawn(96, 1056);
			
			oCharacter[4].mCharaSpawn(1632, 960);
			oCharacter[5].mCharaSpawn(1248, 1152);
			oCharacter[6].mCharaSpawn(1536, 1152);
			oCharacter[7].mCharaSpawn(1920, 1056);
			
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
				aGotoScreen = "ScreenLevel02";
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