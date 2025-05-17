package com.QQ.angel.ui.core
{
   import com.QQ.angel.api.ui.ILoadingView;
   import com.QQ.angel.ui.Billboard;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol130")]
   public class ItemLoadingPanel extends Window implements ILoadingView
   {
      
      public var bg:Sprite;
      
      public var closeButton:SimpleButton;
      
      public var infoTextBox:TextField;
      
      public var progressTxt:TextField;
      
      public var progressBar:MovieClip;
      
      public var dot_mc:MovieClip;
      
      public var billboard:Billboard;
      
      public function ItemLoadingPanel(param1:DisplayObjectContainer, param2:Boolean = false)
      {
         super();
         this.initContent();
         initialize(param1,null,this.closeButton,null,param2);
         x = y = 0;
         visible = false;
      }
      
      protected function initContent() : void
      {
         this.progressBar.gotoAndStop(1);
         this.infoTextBox.text = "";
         this.progressTxt.text = "0%";
         this.dot_mc.stop();
         this.billboard = new Billboard();
         this.billboard.visible = false;
         addChild(this.billboard);
      }
      
      public function setProgress(param1:Number) : void
      {
         this.progressBar.gotoAndStop(param1);
         this.progressTxt.text = param1 + "%";
         this.billboard.setProgress(param1);
      }
      
      public function setTipText(param1:String) : void
      {
      }
      
      public function setLabel(param1:String, param2:String = "") : void
      {
         this.infoTextBox.text = param1;
      }
      
      public function setBackGround(param1:*) : void
      {
      }
      
      public function setCancelEnabled(param1:Boolean = false, param2:Function = null) : void
      {
      }
      
      public function getType() : int
      {
         return WindowManager.ITEM_LOADING_PANEL;
      }
      
      override public function hide() : void
      {
         this.dot_mc.stop();
         this.billboard.deactive();
         super.hide();
      }
      
      override public function close() : void
      {
         this.dot_mc.stop();
         this.billboard.deactive();
         super.close();
      }
      
      override public function show() : void
      {
         x = y = 0;
         var _loc1_:Point = this.globalToLocal(new Point(0,0));
         this.billboard.x = _loc1_.x;
         this.billboard.y = _loc1_.y;
         this.billboard.visible = true;
         visible = true;
         this.dot_mc.play();
         this.billboard.active();
         super.show();
      }
   }
}

