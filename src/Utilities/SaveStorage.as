package Utilities
{
	import Characters.GreenBeret;
	import Characters.Gunner;
	import Characters.Sniper;
	import Characters.Soldier;
	
	import Maps.Map;
	import Maps.Pointer;
	
	import Screens.Screen;
	
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class SaveStorage
	{
		private var oMap:Map;
		private var oCharacter:Vector.<Soldier>;
		private var oPointer:Pointer;
		private var aMenuFlag:Boolean;
		private var aRestartFlag:Boolean;
		
		//Save Manager
		private var oSaveManager:SaveManager1 = new SaveManager1();
		
		public function SaveStorage(pMap:Map, pCharacter:Vector.<Soldier>, pPointer:Pointer, pMenuFlag:Boolean, pRestartFlag:Boolean)
		{
			this.oMap = pMap;
			this.oCharacter = pCharacter;
			this.oPointer = pPointer;
			this.aMenuFlag = pMenuFlag;
			this.aRestartFlag = pRestartFlag;
		}
		
		public function mSaveGame():void
		{
			var vReferences:Dictionary = new Dictionary();
			
			vReferences["aPointerGraphX"] = oPointer.aPointerGraph.x;
			vReferences["aPointerGraphY"] = oPointer.aPointerGraph.y;
			vReferences["_aRowNumberP"] = oPointer._aRowNumber;
			vReferences["_aColumnNumberP"] = oPointer._aColumnNumber;
			vReferences["aGrabbedCharacter"] = oPointer.aGrabbedCharacter;
			vReferences["_aTotalRed"] = oPointer._aTotalRed;
			vReferences["_aTotalBlue"] = oPointer._aTotalBlue;
			vReferences["_aActualTeam"] = oPointer._aActualTeam;
			vReferences["_aPointerCharaVector"] = oPointer._aPointerCharaVector;
			vReferences["_aPhaseAttack"] = oPointer._aPhaseAttack;
			vReferences["aVictory"] = oPointer.aVictory;
			vReferences["_aFlagPhase"] = oPointer._aFlagPhase;
			
			vReferences["aMenuFlag"] = aMenuFlag;
			vReferences["aRestartFlag"] = aRestartFlag;
			
			vReferences["_aColumnNumber"] = oMap._aColumnNumber;
			vReferences["_aRowNumber"] = oMap._aRowNumber;
			
			vReferences["length"] = oCharacter.length;
			for (var i:int = 0; i < oCharacter.length; i++) 
			{
				vReferences["_aAttackRange"+i+""] = oCharacter[i]._aAttackRange;
				vReferences["_aWalkRange"+i+""] = oCharacter[i]._aWalkRange;
				vReferences["aActualMap"+i+""] = oCharacter[i].aActualMap;
				vReferences["aAttackArray"+i+""] = oCharacter[i].aAttackArray;
				vReferences["aCharaSelected"+i+""] = oCharacter[i].aCharaSelected;
				vReferences["aCharaWalk"+i+""] = oCharacter[i].aCharaWalk;
				vReferences["aColumnChara"+i+""] = oCharacter[i].aColumnChara;
				vReferences["aLife"+i+""] = oCharacter[i].aLife;
				vReferences["aPastCol"+i+""] = oCharacter[i].aPastCol;
				vReferences["aPastRow"+i+""] = oCharacter[i].aPastRow;
				vReferences["aRowChara"+i+""] = oCharacter[i].aRowChara;
				vReferences["aSpeed"+i+""] = oCharacter[i].aSpeed;
				vReferences["aTeam"+i+""] = oCharacter[i].aTeam;
				vReferences["aType"+i+""] = oCharacter[i].aType;
				vReferences["aWeapon"+i+""] = oCharacter[i].aWeapon;
				vReferences["x"+i+""] = oCharacter[i].aGraph.x;
				vReferences["y"+i+""] = oCharacter[i].aGraph.y;
			}
			
			oSaveManager.mDoSave(vReferences);
		}
		
		public function mLoadGame():void
		{
			oSaveManager.addEventListener("DATA_LOADED", evDataLoaded);
			oSaveManager.mDoLoad();
		}
		
		//Carga de Datos Terminada
		public function evDataLoaded(e:Event):void
		{
			Screen.aMenuFlag = oSaveManager.aDataToBeLoaded["aMenuFlag"];
			Screen.aRestartFlag = oSaveManager.aDataToBeLoaded["aRestartFlag"];
			
			oMap._aColumnNumber = oSaveManager.aDataToBeLoaded["_aColumnNumber"];
			oMap._aRowNumber = oSaveManager.aDataToBeLoaded["_aRowNumber"];
			
			for (var i:int =oCharacter.length-1 ; i > -1; i--) 
			{
				oCharacter[i].mCharacterRemove();
				oCharacter.splice(i,1);
			}
			
			for (var i:int = 0; i < oSaveManager.aDataToBeLoaded["length"]; i++) 
			{
				switch(oSaveManager.aDataToBeLoaded["aType"+i+""])
				{
					case "Gunner":
					{
						if (oSaveManager.aDataToBeLoaded["aTeam"+i+""] == "A") 
							oCharacter.push(new Gunner(MCGunnerA, oMap,5,4,1,"A",true, "Gunner"));
						else
							oCharacter.push(new Gunner(MCGunnerN, oMap,5,4,1,"R",false, "Gunner"));
						
						break;
					}
						
					case "Beret":
					{
						if (oSaveManager.aDataToBeLoaded["aTeam"+i+""] == "A") 
							oCharacter.push(new GreenBeret(MCBeretA, oMap,5,5,1,"A",true, "Beret"));
						else
							oCharacter.push(new GreenBeret(MCBeretN, oMap,5,5,1,"R",false, "Beret"));
						
						break;
					}
						
					case "Sniper":
					{
						if (oSaveManager.aDataToBeLoaded["aTeam"+i+""] == "A") 
							oCharacter.push(new Sniper(MCSniperA, oMap,5,3,1,"A",true, "Sniper"));
						else
							oCharacter.push(new Sniper(MCSniperN, oMap,5,3,1,"R",false, "Sniper"));
						
						break;
					}
				}
				
				oCharacter[i]._aAttackRange = oSaveManager.aDataToBeLoaded["_aAttackRange"+i+""];
				oCharacter[i]._aWalkRange = oSaveManager.aDataToBeLoaded["_aWalkRange"+i+""];
				oCharacter[i].aActualMap = oSaveManager.aDataToBeLoaded["aActualMap"+i+""];
				oCharacter[i].aAttackArray = oSaveManager.aDataToBeLoaded["aAttackArray"+i+""];
				oCharacter[i].aCharaSelected = oSaveManager.aDataToBeLoaded["aCharaSelected"+i+""];
				oCharacter[i].aCharaWalk = oSaveManager.aDataToBeLoaded["aCharaWalk"+i+""];
				oCharacter[i].aColumnChara = oSaveManager.aDataToBeLoaded["aColumnChara"+i+""];
				oCharacter[i].aLife = oSaveManager.aDataToBeLoaded["aLife"+i+""];
				oCharacter[i].aPastCol = oSaveManager.aDataToBeLoaded["aPastCol"+i+""];
				oCharacter[i].aPastRow = oSaveManager.aDataToBeLoaded["aPastRow"+i+""];
				oCharacter[i].aRowChara = oSaveManager.aDataToBeLoaded["aRowChara"+i+""];
				oCharacter[i].aSpeed = oSaveManager.aDataToBeLoaded["aSpeed"+i+""];
				oCharacter[i].aTeam = oSaveManager.aDataToBeLoaded["aTeam"+i+""];
				oCharacter[i].aType = oSaveManager.aDataToBeLoaded["aType"+i+""];
				oCharacter[i].aWeapon = oSaveManager.aDataToBeLoaded["aWeapon"+i+""];
				
				oCharacter[i].mCharaSpawn(oSaveManager.aDataToBeLoaded["x"+i+""], oSaveManager.aDataToBeLoaded["y"+i+""]);
				
				if (oSaveManager.aDataToBeLoaded["aCharaWalk"+i+""] == false && oSaveManager.aDataToBeLoaded["aTeam"+i+""] == oSaveManager.aDataToBeLoaded["_aActualTeam"]) 
				{
					Utils.mMakeGrayMC(oCharacter[i].aGraph);
				}
			}
			
			oPointer.aPointerGraph.x = oSaveManager.aDataToBeLoaded["aPointerGraphX"];
			oPointer.aPointerGraph.y = oSaveManager.aDataToBeLoaded["aPointerGraphY"];
			oPointer._aRowNumber = oSaveManager.aDataToBeLoaded["_aRowNumberP"];
			oPointer._aColumnNumber = oSaveManager.aDataToBeLoaded["_aColumnNumberP"];
			oPointer.aGrabbedCharacter = oSaveManager.aDataToBeLoaded["aGrabbedCharacter"];
			oPointer._aTotalRed = oSaveManager.aDataToBeLoaded["_aTotalRed"];
			oPointer._aTotalBlue = oSaveManager.aDataToBeLoaded["_aTotalBlue"];
			oPointer._aActualTeam = oSaveManager.aDataToBeLoaded["_aActualTeam"];
			oPointer._aPointerCharaVector = oSaveManager.aDataToBeLoaded["_aPointerCharaVector"];
			oPointer._aPhaseAttack = oSaveManager.aDataToBeLoaded["_aPhaseAttack"];
			oPointer.aVictory = oSaveManager.aDataToBeLoaded["aVictory"];
			oPointer._aFlagPhase = oSaveManager.aDataToBeLoaded["_aFlagPhase"];
			
		}
	}
}