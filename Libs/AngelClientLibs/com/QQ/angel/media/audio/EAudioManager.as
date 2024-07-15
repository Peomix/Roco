package com.QQ.angel.media.audio
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.media.IEAudioManager;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class EAudioManager implements IAngelSysAPIAware, IEAudioManager
   {
       
      
      private var _sysApi:IAngelSysAPI;
      
      private var _channel:EAudioChannel;
      
      private var _volume:int;
      
      private var _dict:Dictionary;
      
      public function EAudioManager()
      {
         super();
         this._sysApi = null;
         this._channel = null;
         this._volume = 100;
         this._dict = new Dictionary();
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this._sysApi = param1;
         this._channel = new EAudioChannel();
         this._channel.setAngelSysAPI(this._sysApi);
         this._channel.setVolume(this._volume);
      }
      
      public function setPath(param1:String) : void
      {
         if(this._channel == null)
         {
            return;
         }
         this._channel.setPath(param1,false);
      }
      
      public function playEAudio(param1:int, param2:int = 0) : void
      {
         if(this._channel == null)
         {
            return;
         }
         this._channel.playAt(param1);
      }
      
      public function stopAllEAudio() : void
      {
         if(this._channel == null)
         {
            return;
         }
         this._channel.stopAll();
      }
      
      public function stopEAudio(param1:int) : void
      {
         if(this._channel == null)
         {
            return;
         }
         this._channel.stopAt(param1);
      }
      
      public function registerEAudio(param1:InteractiveObject, param2:int = 0, param3:int = 1) : void
      {
         if(param1 == null || this._dict == null)
         {
            return;
         }
         if(this._dict[param1] == null)
         {
            this._dict[param1] = new Object();
            this._dict[param1].over = param2;
            this._dict[param1].click = param3;
         }
         if(param2 >= 0)
         {
            param1.addEventListener(MouseEvent.MOUSE_OVER,this.onAddOverSoundEffect);
         }
         if(param3 >= 0)
         {
            param1.addEventListener(MouseEvent.CLICK,this.onAddClickSoundEffect);
         }
      }
      
      public function unregisterEAudio(param1:InteractiveObject) : void
      {
         if(param1 == null || this._dict == null)
         {
            return;
         }
         param1.removeEventListener(MouseEvent.MOUSE_OVER,this.onAddOverSoundEffect);
         param1.removeEventListener(MouseEvent.CLICK,this.onAddClickSoundEffect);
         if(this._dict[param1] != null)
         {
            this._dict[param1] = null;
         }
      }
      
      public function unregisterAll() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this._dict)
         {
            this.unregisterEAudio(_loc1_);
         }
      }
      
      public function dispose() : void
      {
         if(this._channel != null)
         {
            this._channel.dispose();
            this._channel = null;
         }
         this.unregisterAll();
         this._dict = null;
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
      
      private function applyVolumeToAllChannels() : void
      {
         if(this._channel == null)
         {
            return;
         }
         this._channel.setVolume(this._volume);
      }
      
      private function onAddOverSoundEffect(param1:MouseEvent) : void
      {
         if(this._dict == null || this._dict[param1.currentTarget] == null || this._channel == null)
         {
            return;
         }
         this._channel.playAt(this._dict[param1.currentTarget].over);
      }
      
      private function onAddClickSoundEffect(param1:MouseEvent) : void
      {
         if(this._dict == null || this._dict[param1.currentTarget] == null || this._channel == null)
         {
            return;
         }
         this._channel.playAt(this._dict[param1.currentTarget].click);
      }
   }
}
