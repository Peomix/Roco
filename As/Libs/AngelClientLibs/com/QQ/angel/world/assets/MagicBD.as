package com.QQ.angel.world.assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="com.QQ.angel.world.assets.MagicBD")]
   public dynamic class MagicBD extends MovieClip
   {
       
      
      public function MagicBD()
      {
         super();
         addFrameScript(0,frame1,31,frame32,44,frame45,45,frame46);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame32() : *
      {
         gotoAndPlay(1);
      }
      
      internal function frame45() : *
      {
         gotoAndPlay(1);
      }
      
      internal function frame46() : *
      {
         stop();
      }
   }
}
