package com.QQ.angel.world.effects
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class ClickEffect
   {
       
      
      protected var container:DisplayObjectContainer;
      
      protected var effect:MovieClip;
      
      public function ClickEffect(param1:DisplayObjectContainer, param2:MovieClip)
      {
         super();
         this.container = param1;
         this.effect = param2;
         this.effect.mouseEnabled = false;
         this.effect.addEventListener("onMVEnd",this.onMVEndHandler);
         this.effect.stop();
      }
      
      protected function onMVEndHandler(param1:Event) : void
      {
         if(this.container.contains(this.effect))
         {
            this.container.removeChild(this.effect);
         }
      }
      
      public function click(param1:Point) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(!this.container.contains(this.effect))
         {
            this.container.addChild(this.effect);
         }
         this.effect.x = param1.x;
         this.effect.y = param1.y;
         this.effect.gotoAndPlay(1);
      }
   }
}
