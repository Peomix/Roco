package com.QQ.angel.world.effects
{
   import com.QQ.angel.world.assets.SmogEffectAsset;
   import com.QQ.angel.world.events.EffectEvent;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   
   public class SmogEffect extends EventDispatcher
   {
       
      
      protected var dis:MovieClip;
      
      public function SmogEffect()
      {
         super();
         this.dis = new SmogEffectAsset();
         this.dis.gotoAndStop(this.dis.totalFrames);
         this.dis.addFrameScript(this.dis.totalFrames - 1,this.onMVEnd);
      }
      
      public function getDisplay() : MovieClip
      {
         return this.dis;
      }
      
      protected function onMVEnd() : void
      {
         dispatchEvent(new EffectEvent(EffectEvent.END_EFFECT));
         this.dis.stop();
      }
      
      public function start() : void
      {
         this.dis.gotoAndPlay(1);
      }
      
      public function dispose() : void
      {
         this.dis.gotoAndStop(this.dis.totalFrames);
      }
   }
}
