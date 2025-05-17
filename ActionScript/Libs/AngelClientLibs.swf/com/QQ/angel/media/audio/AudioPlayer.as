package com.QQ.angel.media.audio
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.media.IAudioPlayer;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class AudioPlayer implements IAngelSysAPIAware, IAudioPlayer
   {
      
      private var _sysApi:IAngelSysAPI;
      
      private var _channels:Dictionary;
      
      private var _volume:int;
      
      public function AudioPlayer()
      {
         super();
         this._sysApi = null;
         this._channels = new Dictionary();
         this._volume = 100;
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this._sysApi = param1;
      }
      
      public function setPath(param1:String, param2:Boolean = true) : void
      {
      }
      
      public function getPath() : String
      {
         return null;
      }
      
      public function getLength() : int
      {
         return 0;
      }
      
      public function setVolume(param1:int) : void
      {
         this._volume = param1;
         this.applyVolumeToAllChannels();
      }
      
      public function getVolume() : int
      {
         return this._volume;
      }
      
      public function getPosition() : int
      {
         return 0;
      }
      
      public function stop() : void
      {
         var _loc1_:AudioChannel = null;
         for each(_loc1_ in this._channels)
         {
            _loc1_.stop();
         }
      }
      
      public function pause() : void
      {
         var _loc1_:AudioChannel = null;
         for each(_loc1_ in this._channels)
         {
            _loc1_.pause();
         }
      }
      
      public function play(param1:int = -1) : void
      {
         var _loc2_:AudioChannel = null;
         for each(_loc2_ in this._channels)
         {
            _loc2_.play();
         }
      }
      
      public function dispose() : void
      {
         this.disposeAllChannels();
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return false;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return false;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return false;
      }
      
      public function setPaths(param1:Array, param2:Boolean = true) : void
      {
         var _loc5_:AudioChannel = null;
         var _loc6_:String = null;
         var _loc9_:String = null;
         if(this._sysApi == null || param1 == null)
         {
            return;
         }
         var _loc3_:Dictionary = new Dictionary();
         var _loc4_:int = int(param1.length);
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         while(_loc8_ < _loc4_)
         {
            _loc6_ = param1[_loc8_];
            if(_loc6_ != null)
            {
               if(this._channels[_loc6_] == null)
               {
                  _loc5_ = new AudioChannel();
                  _loc5_.setAngelSysAPI(this._sysApi);
                  _loc5_.setVolume(this._volume);
                  _loc5_.setPath(_loc6_,param2);
                  _loc3_[_loc6_] = _loc5_;
               }
               else
               {
                  _loc5_ = this._channels[_loc6_];
                  _loc5_.setVolume(this._volume);
                  _loc3_[_loc6_] = this._channels[_loc6_];
               }
            }
            _loc8_++;
         }
         for(_loc9_ in this._channels)
         {
            if(_loc3_[_loc9_] == null)
            {
               this._channels[_loc9_].dispose();
               delete this._channels[_loc9_];
            }
         }
         this._channels = _loc3_;
      }
      
      public function getPaths() : Array
      {
         var _loc2_:AudioChannel = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this._channels)
         {
            _loc1_.push(_loc2_.getPath());
         }
         return _loc1_;
      }
      
      private function applyVolumeToAllChannels() : void
      {
         var _loc1_:AudioChannel = null;
         for each(_loc1_ in this._channels)
         {
            _loc1_.setVolume(this._volume);
         }
      }
      
      private function disposeAllChannels() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in this._channels)
         {
            if(this._channels[_loc1_] is AudioChannel)
            {
               this._channels[_loc1_].dispose();
               delete this._channels[_loc1_];
            }
         }
      }
   }
}

