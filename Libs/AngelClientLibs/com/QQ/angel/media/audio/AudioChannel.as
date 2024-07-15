package com.QQ.angel.media.audio
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.res.ResData;
   
   public class AudioChannel implements IAudioChannel
   {
       
      
      private var _sysApi:IAngelSysAPI;
      
      private var _swfLoader:AudioSWFLoader;
      
      private var _swfConfig:AudioSWFConfig;
      
      private var _timer:AudioTimer;
      
      private var _cache:AudioCache;
      
      private var _sounds:Array;
      
      private var _resPath:String;
      
      private var _volume:int;
      
      private var _playingIndex:int;
      
      private var _autoPlay:Boolean;
      
      private var _loopTimes:int;
      
      private var _command:int;
      
      public function AudioChannel()
      {
         super();
         this._sysApi = null;
         this._swfLoader = new AudioSWFLoader();
         this._swfConfig = new AudioSWFConfig();
         this._timer = new AudioTimer(this.onDelayPlay);
         this._cache = new AudioCache();
         this._sounds = null;
         this._resPath = null;
         this._volume = 100;
         this._playingIndex = 0;
         this._autoPlay = true;
         this._loopTimes = 0;
         this._command = AudioCommands.NOTHING;
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this._sysApi = param1;
         if(this._swfLoader != null)
         {
            this._swfLoader.setAngelSysAPI(this._sysApi);
         }
      }
      
      public function setPath(param1:String, param2:Boolean = true) : void
      {
         if(this._sysApi == null)
         {
            return;
         }
         this.clear();
         this._resPath = param1;
         this._autoPlay = param2;
         var _loc3_:ResData = this._cache.getCache(param1) as ResData;
         if(_loc3_ == null)
         {
            this._swfLoader.load(param1);
            this._swfLoader.onLoaded = this.onSWFResLoaded;
         }
         else
         {
            this.onSWFResLoaded(_loc3_);
         }
      }
      
      public function getPath() : String
      {
         return this._resPath;
      }
      
      public function getLength() : int
      {
         if(this._sounds == null || this._sounds[this._playingIndex] == null)
         {
            return 0;
         }
         return this._sounds[this._playingIndex].length;
      }
      
      public function setVolume(param1:int) : void
      {
         this._volume = param1;
         this.applyVolume();
      }
      
      public function getVolume() : int
      {
         return this._volume;
      }
      
      public function getPosition() : int
      {
         if(this._sounds == null || this._sounds[this._playingIndex] == null)
         {
            return 0;
         }
         return this._sounds[this._playingIndex].position;
      }
      
      public function play(param1:int = -1) : void
      {
         this._command = AudioCommands.PLAY;
         if(this._sounds == null || this._sounds[this._playingIndex] == null)
         {
            return;
         }
         this._timer.reset();
         this._sounds[this._playingIndex].play(param1,this._swfConfig.interval > 0 ? 0 : int.MAX_VALUE);
      }
      
      public function stop() : void
      {
         this._command = AudioCommands.STOP;
         if(this._sounds == null || this._sounds[this._playingIndex] == null)
         {
            return;
         }
         this._sounds[this._playingIndex].stop();
      }
      
      public function pause() : void
      {
         this._command = AudioCommands.PAUSE;
         if(this._sounds == null || this._sounds[this._playingIndex] == null)
         {
            return;
         }
         this._sounds[this._playingIndex].pause();
      }
      
      public function dispose() : void
      {
         this.clear();
         this._swfLoader = null;
         this._swfConfig = null;
         if(this._timer != null)
         {
            this._timer.dispose();
            this._timer = null;
         }
         if(this._cache != null)
         {
            this._cache.dispose();
            this._cache = null;
         }
      }
      
      public function clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:SoundControl = null;
         var _loc3_:int = 0;
         if(this._swfLoader != null)
         {
            this._swfLoader.stop();
         }
         if(this._swfConfig != null)
         {
            this._swfConfig.clear();
         }
         if(this._timer != null)
         {
            this._timer.reset();
         }
         if(this._sounds != null)
         {
            _loc1_ = int(this._sounds.length);
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc2_ = this._sounds[_loc3_] as SoundControl;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
                  _loc2_ = null;
               }
               _loc3_++;
            }
         }
         this._sounds = null;
         this._resPath = null;
         this._command = AudioCommands.NOTHING;
      }
      
      private function onSWFResLoaded(param1:ResData) : void
      {
         if(this._swfConfig == null || param1 == null)
         {
            return;
         }
         this.setup(param1);
      }
      
      private function onSoundComplete(param1:SoundControl) : void
      {
         if(this._sounds == null)
         {
            return;
         }
         this._playingIndex = this._playingIndex < this._sounds.length - 1 ? this._playingIndex + 1 : 0;
         if(this._playingIndex != 0 || this._playingIndex == 0 && this.canLoop())
         {
            if(this._swfConfig.interval > 0)
            {
               this.playAfter(this._swfConfig.interval);
            }
         }
      }
      
      private function canLoop() : Boolean
      {
         if(this._swfConfig == null)
         {
            return false;
         }
         if(this._swfConfig.loopTimes < 0)
         {
            return true;
         }
         if(this._loopTimes < this._swfConfig.loopTimes)
         {
            ++this._loopTimes;
            return true;
         }
         return false;
      }
      
      private function setup(param1:ResData) : void
      {
         var _loc3_:SoundControl = null;
         if(param1 == null)
         {
            return;
         }
         this._cache.add(this._resPath,param1);
         this._swfConfig.load(param1);
         this._timer.reset();
         this._sounds = this._swfConfig.soundControls;
         this._playingIndex = 0;
         this._loopTimes = 0;
         var _loc2_:int = int(this._sounds.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this._sounds[_loc4_] as SoundControl;
            if(_loc3_ != null)
            {
               _loc3_.onComplete = this.onSoundComplete;
            }
            _loc4_++;
         }
         this.applyVolume();
         if(this._sounds.length > 0 && this._autoPlay)
         {
            if(this._command == AudioCommands.NOTHING)
            {
               this.play();
            }
            else
            {
               AudioCommands.execute(this,this._command);
            }
         }
      }
      
      private function playAfter(param1:int) : void
      {
         if(this._timer != null)
         {
            this._timer.delay = param1;
            this._timer.start();
         }
      }
      
      private function playAt(param1:int) : void
      {
         if(this._sounds == null || this._sounds[param1] == null)
         {
            return;
         }
         this._timer.reset();
         this._playingIndex = param1;
         this._sounds[this._playingIndex].play(0,this._swfConfig.interval > 0 ? 0 : int.MAX_VALUE);
      }
      
      private function onDelayPlay() : void
      {
         AudioCommands.execute(this,this._command);
      }
      
      private function applyVolume() : void
      {
         var _loc2_:SoundControl = null;
         if(this._sounds == null)
         {
            return;
         }
         var _loc1_:int = int(this._sounds.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._sounds[_loc3_] as SoundControl;
            if(_loc2_ != null)
            {
               _loc2_.volume = this._volume;
            }
            _loc3_++;
         }
      }
   }
}
