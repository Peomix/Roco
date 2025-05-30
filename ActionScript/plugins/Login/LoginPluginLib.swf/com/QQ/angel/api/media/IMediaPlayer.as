package com.QQ.angel.api.media
{
   import flash.events.IEventDispatcher;
   
   public interface IMediaPlayer extends IEventDispatcher
   {
      
      function setPath(param1:String, param2:Boolean = true) : void;
      
      function getPath() : String;
      
      function getLength() : int;
      
      function setVolume(param1:int) : void;
      
      function getVolume() : int;
      
      function getPosition() : int;
      
      function stop() : void;
      
      function pause() : void;
      
      function play(param1:int = -1) : void;
      
      function dispose() : void;
   }
}

