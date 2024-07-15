package com.QQ.angel.ui.core.bubbles
{
   import com.QQ.angel.ui.core.AbstractBubbleSkin;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   [Embed(source="/_assets/assets.swf", symbol="com.QQ.angel.ui.core.bubbles.WorldMapBubbleSkin")]
   public class WorldMapBubbleSkin extends AbstractBubbleSkin
   {
       
      
      public var bg:Sprite;
      
      public function WorldMapBubbleSkin()
      {
         super();
      }
      
      override public function setSize(param1:int, param2:int) : void
      {
         this.bg.width = param1 + 30;
         this.bg.height = param2 + 12;
         this.bg.x = 23;
         this.bg.y = -this.bg.height;
      }
      
      override public function get contentRect() : Rectangle
      {
         return new Rectangle(this.bg.x + 23,this.bg.y + 5,this.bg.x + this.bg.width - 23,this.bg.y + this.bg.height);
      }
      
      override public function get borderWidth() : int
      {
         return 10;
      }
      
      override public function get borderHeight() : int
      {
         return 6;
      }
      
      override public function unload() : void
      {
         removeChild(this.bg);
         this.bg = null;
      }
   }
}
