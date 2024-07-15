package com.QQ.angel.ui.core
{
   import com.QQ.angel.api.ui.ILoadingView;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   [Embed(source="/_assets/assets.swf", symbol="com.QQ.angel.ui.core.SimpleLoading")]
   public class SimpleLoading extends Window implements ILoadingView
   {
       
      
      public var bg:Sprite;
      
      public var content:*;
      
      public function SimpleLoading(param1:DisplayObjectContainer, param2:Boolean = false)
      {
         super();
         initialize(param1,null,null,null,param2);
         center();
      }
      
      override public function close() : void
      {
         this.content.stop();
         super.close();
      }
      
      override public function show() : void
      {
         this.content.play();
         super.show();
      }
      
      override public function hide() : void
      {
         this.content.stop();
         super.hide();
      }
      
      public function setProgress(param1:Number) : void
      {
      }
      
      public function setTipText(param1:String) : void
      {
      }
      
      public function setLabel(param1:String, param2:String = "") : void
      {
      }
      
      public function setBackGround(param1:*) : void
      {
      }
      
      public function setCancelEnabled(param1:Boolean = false, param2:Function = null) : void
      {
      }
      
      public function getType() : int
      {
         return WindowManager.SIMPLE_LOADING;
      }
   }
}
