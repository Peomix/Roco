package com.QQ.angel.media.audio
{
   import com.QQ.angel.api.res.ResData;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.system.ApplicationDomain;
   
   public class AudioSWFConfig
   {
       
      
      private var _resData:ResData;
      
      private var _domain:ApplicationDomain;
      
      private var _config:Object;
      
      public function AudioSWFConfig()
      {
         super();
      }
      
      public static function getRandomSoundInterval() : int
      {
         return Math.floor(Math.random() * 10);
      }
      
      public function load(param1:ResData) : void
      {
         var resData:ResData = param1;
         this.clear();
         try
         {
            this._resData = resData;
            this._domain = this._resData.domain;
            this._config = this._resData.content.soundConfig;
         }
         catch(e:Error)
         {
         }
      }
      
      public function clear() : void
      {
         this._resData = null;
         this._domain = null;
         this._config = null;
      }
      
      public function get soundControls() : Array
      {
         var len:int = 0;
         var soundClass:Class = null;
         var sound:Sound = null;
         var channel:SoundChannel = null;
         var i:int = 0;
         var arr:Array = [];
         try
         {
            len = int(this._config.sounds.length);
            i = 0;
            while(i < len)
            {
               if(this._config.sounds[i] != null)
               {
                  soundClass = this._config.sounds[i] as Class;
                  sound = new soundClass();
                  channel = sound.play();
                  if(channel != null)
                  {
                     channel.stop();
                     arr.push(new SoundControl(sound));
                  }
               }
               i++;
            }
         }
         catch(e:Error)
         {
         }
         return arr;
      }
      
      public function get interval() : int
      {
         var interval:int = 0;
         try
         {
            interval = int(this._config.interval);
            if(interval < 0)
            {
               interval = getRandomSoundInterval();
            }
         }
         catch(e:Error)
         {
         }
         return interval;
      }
      
      public function get loopTimes() : int
      {
         var times:int = 0;
         try
         {
            times = int(this._config.loopTimes);
         }
         catch(e:Error)
         {
         }
         return times;
      }
   }
}
