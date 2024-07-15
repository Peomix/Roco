package com.QQ.angel.ui.core
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ModalBlocker extends Sprite implements IWindowContent
   {
       
      
      protected var _dpoc:DisplayObjectContainer;
      
      public function ModalBlocker(param1:DisplayObjectContainer, param2:int = 16777215, param3:Number = 0)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         this._dpoc = param1;
         this.draw(param2,param3);
         addEventListener(MouseEvent.CLICK,this.onBlock);
      }
      
      public function draw(param1:int, param2:Number) : void
      {
         graphics.clear();
         graphics.beginFill(param1,param2);
         graphics.drawRect(0,0,960,560);
         graphics.endFill();
      }
      
      public function dispose() : void
      {
         graphics.clear();
         removeEventListener(MouseEvent.CLICK,this.onBlock);
      }
      
      private function onBlock(param1:MouseEvent) : void
      {
         trace("[ModalBlocker] Warning: Click action is blocked by modal window.");
      }
   }
}
