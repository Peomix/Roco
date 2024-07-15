package com.QQ.angel.ui.effect
{
   import com.QQ.angel.api.utils.CFunction;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="com.QQ.angel.ui.effect.Effect5Controller")]
   public class Effect5Controller extends MovieClip implements IEffectController
   {
       
      
      protected var container:DisplayObjectContainer;
      
      protected var endHandler:CFunction;
      
      public function Effect5Controller(param1:DisplayObjectContainer)
      {
         super();
         this.container = param1;
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this.gotoAndStop("BLANK");
         x = 350;
         y = 250;
         addFrameScript(totalFrames - 1,this.onStopHandler);
      }
      
      protected function onStopHandler() : void
      {
         if(this.container.contains(this))
         {
            this.container.removeChild(this);
         }
         this.gotoAndStop("BLANK");
         var _loc1_:CFunction = this.endHandler;
         this.endHandler = null;
         if(_loc1_ != null)
         {
            _loc1_.invoke();
         }
         trace("[TaskAcceptedMV] stop at here!!");
      }
      
      public function start(param1:Object, param2:CFunction = null) : void
      {
         this.endHandler = param2;
         this.container.addChild(this);
         gotoAndPlay(1);
         trace("[TaskUpdateMV]  播入效果!!!");
      }
   }
}
