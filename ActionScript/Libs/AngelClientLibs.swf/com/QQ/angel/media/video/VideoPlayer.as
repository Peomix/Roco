package com.QQ.angel.media.video
{
   import com.QQ.angel.api.media.IVideoPlayer;
   import flash.events.Event;
   
   public class VideoPlayer implements IVideoPlayer
   {
      
      public function VideoPlayer()
      {
         super();
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
      }
      
      public function getVolume() : int
      {
         return 0;
      }
      
      public function getPosition() : int
      {
         return 0;
      }
      
      public function stop() : void
      {
      }
      
      public function pause() : void
      {
      }
      
      public function play(param1:int = -1) : void
      {
      }
      
      public function dispose() : void
      {
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
   }
}

