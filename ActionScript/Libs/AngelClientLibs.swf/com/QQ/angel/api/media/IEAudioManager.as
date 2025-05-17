package com.QQ.angel.api.media
{
   import flash.display.InteractiveObject;
   
   public interface IEAudioManager
   {
      
      function setPath(param1:String) : void;
      
      function playEAudio(param1:int, param2:int = 0) : void;
      
      function stopAllEAudio() : void;
      
      function stopEAudio(param1:int) : void;
      
      function registerEAudio(param1:InteractiveObject, param2:int = 0, param3:int = 1) : void;
      
      function unregisterEAudio(param1:InteractiveObject) : void;
      
      function unregisterAll() : void;
   }
}

