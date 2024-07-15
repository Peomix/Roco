package com.QQ.angel.ui.core
{
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   
   public class BaseCursor extends Bitmap
   {
       
      
      protected var owner:DisplayObjectContainer;
      
      protected var xOffset:int = 25;
      
      protected var yOffset:int = 25;
      
      public function BaseCursor()
      {
         super();
      }
      
      protected function movingHandler(param1:MouseEvent) : void
      {
         this.x = this.owner.mouseX + this.xOffset;
         this.y = this.owner.mouseY + this.yOffset;
         Mouse.hide();
      }
      
      public function show(param1:DisplayObjectContainer) : void
      {
         if(param1 == null || this.owner != null)
         {
            return;
         }
         this.owner = param1;
         this.owner.addChild(this);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.movingHandler);
         this.movingHandler(new MouseEvent(MouseEvent.MOUSE_MOVE));
      }
      
      public function hidden() : void
      {
         if(this.owner == null)
         {
            return;
         }
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.movingHandler);
         this.owner.removeChild(this);
         this.owner = null;
         Mouse.show();
      }
      
      public function getCursorType() : int
      {
         return 1;
      }
   }
}
