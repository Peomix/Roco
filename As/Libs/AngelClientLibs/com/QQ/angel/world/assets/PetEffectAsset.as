package com.QQ.angel.world.assets
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="com.QQ.angel.world.assets.PetEffectAsset")]
   public dynamic class PetEffectAsset extends MovieClip
   {
       
      
      public function PetEffectAsset()
      {
         super();
         addFrameScript(0,frame1,24,frame25,25,frame26);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame25() : *
      {
         stop();
      }
      
      internal function frame26() : *
      {
         stop();
      }
   }
}
