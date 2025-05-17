package com.QQ.angel.media
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.IMediaSysAPI;
   import com.QQ.angel.api.media.IAudioPlayer;
   import com.QQ.angel.api.media.IEAudioManager;
   import com.QQ.angel.api.media.IVideoPlayer;
   import com.QQ.angel.media.audio.AudioPlayer;
   import com.QQ.angel.media.audio.EAudioManager;
   import com.QQ.angel.media.video.VideoPlayer;
   
   public class MediaSysManager implements IAngelSysAPIAware, IMediaSysAPI
   {
      
      private var _sysApi:IAngelSysAPI;
      
      private var _bgAudioPlayer:AudioPlayer;
      
      private var _effectAudioManager:EAudioManager;
      
      private var _globalVolume:int;
      
      private var _globalMuteVolume:int;
      
      private var _players:Array;
      
      public function MediaSysManager()
      {
         super();
         this._bgAudioPlayer = new AudioPlayer();
         this._effectAudioManager = new EAudioManager();
         this._players = [];
         this._globalVolume = 100;
         this._globalMuteVolume = this._globalVolume;
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this._sysApi = param1;
         this._bgAudioPlayer.setAngelSysAPI(this._sysApi);
         this._effectAudioManager.setAngelSysAPI(this._sysApi);
         var _loc2_:int = 0;
         while(_loc2_ < this._players.length)
         {
            if(this._players[_loc2_] is AudioPlayer)
            {
               this._players[_loc2_].setAngelSysAPI(this._sysApi);
            }
            _loc2_++;
         }
         this.setGlobalVolume(this._globalVolume);
      }
      
      public function createAudioPlayer(... rest) : IAudioPlayer
      {
         var _loc2_:AudioPlayer = new AudioPlayer();
         _loc2_.setAngelSysAPI(this._sysApi);
         _loc2_.setVolume(this._globalVolume);
         this._players.push(_loc2_);
         return _loc2_;
      }
      
      public function createVideoPlayer(... rest) : IVideoPlayer
      {
         return new VideoPlayer();
      }
      
      public function setGlobalVolume(param1:int) : void
      {
         this._globalVolume = param1;
         this._bgAudioPlayer.setVolume(this._globalVolume);
         this._effectAudioManager.setVolume(this._globalVolume);
         var _loc2_:int = 0;
         while(_loc2_ < this._players.length)
         {
            if(this._players[_loc2_] is AudioPlayer)
            {
               this._players[_loc2_].setVolume(this._globalVolume);
            }
            _loc2_++;
         }
      }
      
      public function getGlobalVolume() : int
      {
         return this._globalVolume;
      }
      
      public function getMute() : Boolean
      {
         return this._globalVolume == 0;
      }
      
      public function setMute(param1:Boolean) : void
      {
         if(param1)
         {
            this._globalMuteVolume = this._globalVolume;
            this._globalVolume = 0;
            this.setGlobalVolume(0);
         }
         else
         {
            this._globalVolume = this._globalMuteVolume;
            this.setGlobalVolume(this._globalVolume);
         }
      }
      
      public function getEAudioManager() : IEAudioManager
      {
         return this._effectAudioManager;
      }
      
      public function getBGAudio() : IAudioPlayer
      {
         return this._bgAudioPlayer;
      }
      
      public function dispose() : void
      {
         this._bgAudioPlayer.dispose();
         this._bgAudioPlayer = null;
         this._effectAudioManager.dispose();
         this._effectAudioManager = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._players.length)
         {
            if(this._players[_loc1_] is AudioPlayer)
            {
               this._players[_loc1_].dispose();
            }
            _loc1_++;
         }
         this._players = [];
      }
   }
}

