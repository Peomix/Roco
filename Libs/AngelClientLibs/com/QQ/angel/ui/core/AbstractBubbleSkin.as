package com.QQ.angel.ui.core
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class AbstractBubbleSkin extends Sprite implements IBubbleSkin
   {
       
      
      public function AbstractBubbleSkin()
      {
         super();
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this.width = param1;
         this.height = param2;
      }
      
      public function get contentRect() : Rectangle
      {
         return new Rectangle(this.x,this.y,this.x + this.width,this.y + this.height);
      }
      
      public function get borderWidth() : int
      {
         return 0;
      }
      
      public function get borderHeight() : int
      {
         return 0;
      }
      
      public function onRender(param1:Event) : void
      {
      }
      
      public function hasRender() : Boolean
      {
         return false;
      }
      
      public function get display() : DisplayObject
      {
         return this;
      }
      
      public function unload() : void
      {
      }
   }
}
