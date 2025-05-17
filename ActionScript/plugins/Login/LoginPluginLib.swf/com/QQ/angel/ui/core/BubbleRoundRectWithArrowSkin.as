package com.QQ.angel.ui.core
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol249")]
   public class BubbleRoundRectWithArrowSkin extends AbstractBubbleSkin
   {
      
      public var bg:Sprite;
      
      public var arrow:Sprite;
      
      public function BubbleRoundRectWithArrowSkin()
      {
         super();
         this.bg.scale9Grid = new Rectangle(8,6,15,7);
      }
      
      override public function setSize(param1:int, param2:int) : void
      {
         this.bg.width = param1;
         this.bg.height = param2;
         this.bg.x = -(this.bg.width >> 1);
         this.bg.y = -this.bg.height - this.arrow.height + 4;
      }
      
      override public function get contentRect() : Rectangle
      {
         return new Rectangle(this.bg.x,this.bg.y,this.bg.x + this.bg.width,this.bg.y + this.bg.height);
      }
      
      override public function get borderWidth() : int
      {
         return 20;
      }
      
      override public function get borderHeight() : int
      {
         return 12;
      }
      
      override public function unload() : void
      {
         removeChild(this.bg);
         this.bg = null;
         removeChild(this.arrow);
         this.arrow = null;
      }
   }
}

