package com.QQ.angel.media.audio
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.res.ResData;
   
   public class EAudioChannel implements IEAudioChannel
   {
      
      private var _sysApi:IAngelSysAPI;
      
      private var _swfLoader:AudioSWFLoader;
      
      private var _swfConfig:AudioSWFConfig;
      
      private var _cache:AudioCache;
      
      private var _sounds:Array;
      
      private var _resPath:String;
      
      private var _volume:int;
      
      public function EAudioChannel()
      {
         super();
         this._sysApi = null;
         this._swfLoader = new AudioSWFLoader();
         this._swfConfig = new AudioSWFConfig();
         this._cache = new AudioCache();
         this._sounds = null;
         this._resPath = null;
         this._volume = 100;
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
      
      public function setVolume(param1:int) : void
      {
         this._volume = param1;
         this.applyVolume();
      }
      
      public function getVolume() : int
      {
         return this._volume;
      }
      
      public function playAt(param1:int) : void
      {
         if(this._sounds == null || this._sounds[param1] == null)
         {
            return;
         }
         this._sounds[param1].play();
      }
      
      public function stopAt(param1:int) : void
      {
         if(this._sounds == null || this._sounds[param1] == null)
         {
            return;
         }
         this._sounds[param1].stop();
      }
      
      public function stopAll() : void
      {
         if(this._sounds == null)
         {
            return;
         }
         var _loc1_:int = int(this._sounds.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._sounds[_loc2_].stop();
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         this.clear();
         this._swfLoader = null;
         this._swfConfig = null;
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
         this._sounds = this._swfConfig.soundControls;
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

