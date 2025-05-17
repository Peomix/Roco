package com.QQ.angel.world.role
{
   import flash.display.MovieClip;
   
   public class AvatarTransformView
   {
      
      private var body:MovieClip;
      
      public function AvatarTransformView()
      {
         super();
      }
      
      public function setView(param1:MovieClip, param2:AvatarBodyContainer) : void
      {
         this.body = MovieClip(param1.getChildAt(param1.numChildren - 1));
         param2.body.visible = false;
         param2.midLayer.addChild(this.body);
      }
      
      public function cancleView(param1:AvatarBodyContainer) : void
      {
         param1.body.visible = true;
         param1.midLayer.removeChild(this.body);
      }
      
      public function playMotion(param1:int, param2:int) : void
      {
         this.body.gotoAndStop(param1 + "-" + param2);
      }
   }
}

