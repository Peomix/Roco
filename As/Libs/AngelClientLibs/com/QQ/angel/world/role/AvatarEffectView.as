package com.QQ.angel.world.role
{
   import flash.display.MovieClip;
   
   public class AvatarEffectView
   {
       
      
      private var topBody:MovieClip;
      
      private var fallBody:MovieClip;
      
      public function AvatarEffectView()
      {
         super();
      }
      
      public function setView(param1:MovieClip, param2:AvatarBodyContainer) : void
      {
         this.topBody = MovieClip(param1.getChildAt(param1.numChildren - 1));
         if(param1.numChildren > 1)
         {
            this.fallBody = MovieClip(param1.getChildAt(param1.numChildren - 2));
         }
         param2.topLayer.addChild(this.topBody);
         if(this.fallBody)
         {
            param2.groundLayer.addChild(this.fallBody);
         }
      }
      
      public function cancleView(param1:AvatarBodyContainer) : void
      {
         param1.topLayer.removeChild(this.topBody);
         if(this.fallBody)
         {
            param1.groundLayer.removeChild(this.fallBody);
         }
      }
      
      public function playMotion(param1:int, param2:int) : void
      {
         this.topBody.gotoAndStop(param1 + "-" + param2);
         if(this.fallBody)
         {
            this.fallBody.gotoAndStop(param1 + "-" + param2);
         }
      }
   }
}
