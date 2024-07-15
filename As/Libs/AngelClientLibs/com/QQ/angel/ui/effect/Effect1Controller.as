package com.QQ.angel.ui.effect
{
   import com.QQ.angel.api.utils.CFunction;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   [Embed(source="/_assets/assets.swf", symbol="com.QQ.angel.ui.effect.Effect1Controller")]
   public class Effect1Controller extends MovieClip implements IEffectController
   {
       
      
      public var block:Sprite;
      
      protected var container:DisplayObjectContainer;
      
      private var txt:TextField;
      
      protected var endHandler:CFunction;
      
      public function Effect1Controller(param1:DisplayObjectContainer = null)
      {
         super();
         this.container = param1;
         this.stop();
         this.x = 480;
         this.y = 148;
         this.txt = this.block.getChildByName("infoTxt") as TextField;
         this.txt.defaultTextFormat = new TextFormat(null,14,16777215);
         this.txt.embedFonts = false;
         addFrameScript(totalFrames - 1,this.onStopHandler);
      }
      
      protected function onStopHandler() : void
      {
         stop();
         if(this.container.contains(this))
         {
            this.container.removeChild(this);
         }
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
         this.txt.text = String(param1);
         this.container.addChild(this);
         gotoAndPlay(1);
         trace("[LightWeightInfo]  播入效果!!!");
      }
   }
}
