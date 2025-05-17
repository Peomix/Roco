package com.QQ.angel.ui.core
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol246")]
   public class BubbleGameRectSkin extends AbstractBubbleSkin
   {
      
      public static const ICON_BORDER_SIZE:int = 4;
      
      public var bg:Sprite;
      
      public var icon:Sprite;
      
      public function BubbleGameRectSkin()
      {
         super();
      }
      
      override public function setSize(param1:int, param2:int) : void
      {
         this.icon.x = ICON_BORDER_SIZE;
         this.icon.y = -this.icon.height - ICON_BORDER_SIZE;
         this.bg.width = param1 + this.icon.width + ICON_BORDER_SIZE;
         this.bg.height = this.icon.height + (ICON_BORDER_SIZE << 1);
         this.bg.x = 0;
         this.bg.y = -this.bg.height;
      }
      
      override public function get contentRect() : Rectangle
      {
         return new Rectangle(this.icon.width + ICON_BORDER_SIZE,this.bg.y,this.bg.x + this.bg.width,this.bg.y + this.bg.height);
      }
      
      override public function get borderWidth() : int
      {
         return 10;
      }
      
      override public function get borderHeight() : int
      {
         return 18;
      }
      
      override public function unload() : void
      {
         removeChild(this.bg);
         this.bg = null;
      }
   }
}

