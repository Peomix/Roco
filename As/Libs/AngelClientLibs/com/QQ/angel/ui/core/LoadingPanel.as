package com.QQ.angel.ui.core
{
   import com.QQ.angel.api.ui.ILoadingView;
   import com.QQ.angel.ui.Billboard;
   import com.QQ.angel.utils.AdjustColor;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   
   [Embed(source="/_assets/assets.swf", symbol="com.QQ.angel.ui.core.LoadingPanel")]
   public class LoadingPanel extends Window implements ILoadingView
   {
       
      
      public var content:MovieClip;
      
      public var billboard:Billboard;
      
      public var frame:Sprite;
      
      private var _bottomDisplay:Bitmap;
      
      private var _grayFilter:ColorMatrixFilter;
      
      public function LoadingPanel(param1:DisplayObjectContainer, param2:Boolean = false)
      {
         super();
         visible = false;
         x = y = 0;
         this.initContent();
         addChildAt(this._bottomDisplay = new Bitmap(),0);
         var _loc3_:AdjustColor = new AdjustColor();
         _loc3_.saturation = 0;
         _loc3_.brightness = -90;
         _loc3_.hue = 0;
         _loc3_.contrast = -56;
         this._grayFilter = new ColorMatrixFilter(_loc3_.CalculateFinalFlatArray());
         initialize(param1,null,null,this.content,param2);
      }
      
      protected function initContent() : void
      {
         this.content.progressBar.gotoAndStop(1);
         this.content.mouseChildren = false;
         this.content.mouseEnabled = false;
         this.content.infoText.text = "";
         this.content.loadingText.text = "";
         this.content.addChild(this.billboard = new Billboard());
         this.billboard.visible = false;
      }
      
      override public function show() : void
      {
         x = y = 0;
         var _loc1_:Point = this.content.globalToLocal(new Point(0,0));
         this.billboard.x = _loc1_.x;
         this.billboard.y = _loc1_.y;
         this.billboard.visible = true;
         visible = true;
         this.billboard.active();
         super.show();
      }
      
      override public function hide() : void
      {
         this.billboard.deactive();
         super.hide();
      }
      
      override public function close() : void
      {
         this.billboard.deactive();
         super.close();
      }
      
      public function setProgress(param1:Number) : void
      {
         this.content.progressBar.gotoAndStop(param1);
         this.billboard.setProgress(param1);
      }
      
      public function setTipText(param1:String) : void
      {
         this.content.tipText.text = param1;
      }
      
      public function setLabel(param1:String, param2:String = "") : void
      {
         this.content.infoText.text = param1;
      }
      
      public function setBackGround(param1:*) : void
      {
         if(this._bottomDisplay.bitmapData != null)
         {
            this._bottomDisplay.bitmapData.dispose();
            this._bottomDisplay.bitmapData = null;
         }
         if(param1 is BitmapData)
         {
            this._bottomDisplay.filters = [this._grayFilter];
            this._bottomDisplay.bitmapData = param1 as BitmapData;
         }
         else if(param1 is Object)
         {
            this._bottomDisplay.filters = null;
            this._bottomDisplay.bitmapData = param1.bd;
         }
      }
      
      public function setCancelEnabled(param1:Boolean = false, param2:Function = null) : void
      {
      }
      
      public function getType() : int
      {
         return WindowManager.LOADING_PANEL;
      }
   }
}
