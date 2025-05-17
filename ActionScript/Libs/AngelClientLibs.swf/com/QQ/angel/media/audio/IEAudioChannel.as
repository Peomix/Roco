package com.QQ.angel.media.audio
{
   import com.QQ.angel.api.IAngelSysAPIAware;
   
   public interface IEAudioChannel extends IAngelSysAPIAware
   {
      
      function setPath(param1:String, param2:Boolean = true) : void;
      
      function getPath() : String;
      
      function setVolume(param1:int) : void;
      
      function getVolume() : int;
      
      function playAt(param1:int) : void;
      
      function stopAt(param1:int) : void;
      
      function stopAll() : void;
      
      function dispose() : void;
      
      function clear() : void;
   }
}

