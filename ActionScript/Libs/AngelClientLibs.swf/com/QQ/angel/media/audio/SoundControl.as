package com.QQ.angel.media.audio
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class SoundControl
   {
      
      public var onComplete:Function;
      
      private var _sound:Sound;
      
      private var _soundChannel:SoundChannel;
      
      private var _state:int;
      
      private var _volume:int;
      
      public function SoundControl(param1:Sound)
      {
         super();
         this._sound = param1;
         this._soundChannel = null;
         this._state = SoundControlStates.STOPPED;
         this._volume = 100;
      }
      
      public function dispose() : void
      {
         this._sound = null;
         if(this._soundChannel != null)
         {
            this._soundChannel.stop();
            this._soundChannel.removeEventListener(Event.SOUND_COMPLETE,this.onAudioComplete);
            this._soundChannel = null;
         }
      }
      
      public function play(param1:int = -1, param2:int = 0) : void
      {
         if(this._sound == null)
         {
            return;
         }
         if(this._state == SoundControlStates.STOPPED)
         {
            this._soundChannel = this._sound.play(0,param2);
            if(this._soundChannel != null)
            {
               this._soundChannel.addEventListener(Event.SOUND_COMPLETE,this.onAudioComplete);
            }
            this.applyRealVolume();
            this._state = SoundControlStates.PLAYING;
         }
         else if(this._state == SoundControlStates.PAUSED)
         {
            if(param1 != -1)
            {
               this._soundChannel = this._sound.play(param1,param2);
               if(this._soundChannel != null)
               {
                  this._soundChannel.addEventListener(Event.SOUND_COMPLETE,this.onAudioComplete);
               }
               this.applyRealVolume();
            }
            else
            {
               this._soundChannel = this._sound.play(this._soundChannel != null ? this._soundChannel.position : 0,param2);
               if(this._soundChannel != null)
               {
                  this._soundChannel.addEventListener(Event.SOUND_COMPLETE,this.onAudioComplete);
               }
               this.applyRealVolume();
            }
            this._state = SoundControlStates.PLAYING;
         }
      }
      
      public function pause() : void
      {
         var _loc1_:int = 0;
         if(this._soundChannel == null)
         {
            return;
         }
         if(this._state == SoundControlStates.PLAYING)
         {
            _loc1_ = this._soundChannel.position;
            this._soundChannel.stop();
            this._state = SoundControlStates.PAUSED;
         }
      }
      
      public function stop() : void
      {
         if(this._soundChannel == null)
         {
            return;
         }
         this._soundChannel.stop();
         this._state = SoundControlStates.STOPPED;
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function get length() : int
      {
         if(this._sound != null)
         {
            return this._sound.length;
         }
         return -1;
      }
      
      public function get position() : int
      {
         if(this._state != SoundControlStates.STOPPED)
         {
            if(this._soundChannel != null)
            {
               return this._soundChannel.position;
            }
            return -1;
         }
         return 0;
      }
      
      public function get volume() : int
      {
         return this._volume;
      }
      
      public function set volume(param1:int) : void
      {
         this._volume = param1;
         this.applyRealVolume();
      }
      
      private function onAudioComplete(param1:Event) : void
      {
         this._state = SoundControlStates.STOPPED;
         if(this.onComplete != null)
         {
            this.onComplete(this);
         }
      }
      
      private function applyRealVolume() : void
      {
         if(this._soundChannel == null)
         {
            return;
         }
         var _loc1_:SoundTransform = this._soundChannel.soundTransform;
         _loc1_.volume = this._volume / 100;
         this._soundChannel.soundTransform = _loc1_;
      }
   }
}

