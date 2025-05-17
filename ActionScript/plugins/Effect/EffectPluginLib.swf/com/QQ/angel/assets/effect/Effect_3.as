package com.QQ.angel.assets.effect
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol177")]
   public dynamic class Effect_3 extends MovieClip
   {
      
      public function Effect_3()
      {
         super();
         addFrameScript(32,frame33,45,frame46);
      }
      
      internal function frame33() : *
      {
         gotoAndPlay(1);
      }
      
      internal function frame46() : *
      {
         stop();
         dispatchEvent(new Event("onMVEnd"));
      }
   }
}

