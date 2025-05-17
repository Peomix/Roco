package com.QQ.angel.api.media
{
   public interface IAudioPlayer extends IMediaPlayer
   {
      
      function setPaths(param1:Array, param2:Boolean = true) : void;
      
      function getPaths() : Array;
   }
}

