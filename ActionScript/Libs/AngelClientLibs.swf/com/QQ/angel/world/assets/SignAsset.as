package com.QQ.angel.world.assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol209")]
   public dynamic class SignAsset extends MovieClip
   {
      
      public function SignAsset()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

