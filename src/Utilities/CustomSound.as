package Utilities
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;

	public class CustomSound
	{
		public var aSound:Sound;
		public var aSoundChannel:SoundChannel;
		public var aUrl:URLRequest;
		private var _aExists:Boolean;
		
		public function CustomSound(pSound:Sound)
		{
			//this.aUrl = new URLRequest(pUrl);
			this.aSound = pSound;
			_aExists = false;
		}
		
		public function mPlay():void
		{
			_aExists = true;
			this.aSoundChannel = aSound.play();
		}
		
		public function mPlayRepeat():void
		{
			if (!_aExists) 
			{
				_aExists = true;
				this.aSoundChannel = aSound.play(0,9999);
			}
		}
		
		public function mStop():void
		{
			if (_aExists) 
			{
				_aExists = false;
				this.aSoundChannel.stop();
			}
		}
	}
}