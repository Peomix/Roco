package com.QQ.angel.assets.effect
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol176")]
   public dynamic class Effect_2 extends MovieClip
   {
      
      public function Effect_2()
      {
         super();
         addFrameScript(99,frame100);
      }
      
      internal function frame100() : *
      {
         stop();
         dispatchEvent(new Event("onMVEnd"));
      }
   }
}

