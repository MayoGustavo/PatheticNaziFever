package Utilities
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.getDefinitionByName;
	import Screens.Screen;

	public class Animation extends EventDispatcher
	{
		public var aGraph:MovieClip;
		public var aIsRunning:Boolean;
		private var aSoundChannel:SoundChannel;
		
		public function Animation(pClass:Class)
		{
			this.aGraph = new pClass();
			callClass();
		}
		
		private function callClass():void
		{
			SNDBeretBeretD;
			SNDBeretBeretM;
			SNDBeretGunnerD;
			SNDBeretGunnerM;
			SNDBeretSniperD;
			SNDBeretSniperM;
			SNDGunnerBeretD;
			SNDGunnerBeretM;
			SNDGunnerGunnerD;
			SNDGunnerGunnerM;
			SNDGunnerSniperD;
			SNDGunnerSniperM;
			SNDSniperBeretD;
			SNDSniperBeretM;
			SNDSniperGunnerD;
			SNDSniperGunnerM;
			SNDSniperSniperD;
			SNDSniperSniperM;
		}
		
		public function mShowAnimation():void
		{
			Screen.oAnimationContainer.addChild(aGraph);
			aGraph.gotoAndPlay(1);
			aGraph.x = 1056;
			aGraph.y = 667;
			aIsRunning = true;
			aGraph.addEventListener(Event.ENTER_FRAME, evHandleAnimation);
		}
		
		private function evHandleAnimation(e:Event):void
		{
			if(aGraph.currentFrame == aGraph.totalFrames)
			{
				dispatchEvent(new Event("AnimationOverPointer"));
			}
		}
		
		public function mHideAnimation():void
		{
			Screen.oAnimationContainer.removeChild(aGraph);
			aIsRunning = false;
			aGraph.removeEventListener(Event.ENTER_FRAME, evHandleAnimation);
		}
		
		public function mShowAnimationBattle(pTeam:String, pAtackSoldier:String, pDefendSoldier:String, pStatus:String):void
		{
			Screen.oAnimationContainer.addChild(aGraph);
			aGraph.gotoAndStop(1);
			var vFrameDestinyLabel:String = pTeam+pAtackSoldier+pDefendSoldier+pStatus;
			aGraph.gotoAndStop(vFrameDestinyLabel);
			aGraph.x = 1056;
			aGraph.y = 667;
			aIsRunning = true;
			
			var vSoundDestinyLabel:String = pAtackSoldier+pDefendSoldier+pStatus;
			var cSoundClass:Class = getDefinitionByName("SND"+vSoundDestinyLabel) as Class;
			var aSound:Sound = new cSoundClass();
			aSoundChannel = aSound.play();
			
			aGraph.addEventListener("AnimationOver", evHandleBattleAnimation);
		}
		
		protected function evHandleBattleAnimation(event:Event):void
		{
			dispatchEvent(new Event("AnimationOverPointer"));
		}
		
		public function mHideBattleAnimation():void
		{
			Screen.oAnimationContainer.removeChild(aGraph);
			aIsRunning = false;
			aGraph.removeEventListener("AnimationOver", evHandleBattleAnimation);
		}
		
	}
}