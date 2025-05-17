package com.QQ.angel.media.audio
{
   import com.QQ.angel.api.IAngelSysAPIAware;
   
   public interface IAudioChannel extends IAngelSysAPIAware
   {
      
      function setPath(param1:String, param2:Boolean = true) : void;
      
      function getPath() : String;
      
      function getLength() : int;
      
      function setVolume(param1:int) : void;
      
      function getVolume() : int;
      
      function getPosition() : int;
      
      function play(param1:int = -1) : void;
      
      function stop() : void;
      
      function pause() : void;
      
      function dispose() : void;
      
      function clear() : void;
   }
}

