package com.QQ.angel.ui.effect
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol273")]
   public class Effect2Begin extends MovieClip
   {
      
      public function Effect2Begin()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         x = 480;
         y = 180;
         this.stop();
         addFrameScript(totalFrames - 1,this.onEndMV);
      }
      
      protected function onEndMV() : void
      {
         dispatchEvent(new Event("onMVEnd"));
         stop();
      }
   }
}

