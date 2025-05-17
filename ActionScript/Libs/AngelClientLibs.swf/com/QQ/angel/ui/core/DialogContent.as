package com.QQ.angel.ui.core
{
   import com.QQ.angel.api.ui.IWindow;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol43")]
   public class DialogContent extends Sprite implements IWindowContent
   {
      
      public var icon:Sprite;
      
      public var msg:TextField;
      
      public var btnOK:SimpleButton;
      
      public var btnCancel:SimpleButton;
      
      public function DialogContent()
      {
         super();
         this.mouseEnabled = false;
         this.msg.autoSize = TextFieldAutoSize.LEFT;
         this.msg.wordWrap = true;
         this.msg.mouseEnabled = false;
         this.msg.text = "";
         this.btnOK.addEventListener(MouseEvent.CLICK,this.onOK);
         this.btnCancel.addEventListener(MouseEvent.CLICK,this.onCancel);
      }
      
      public function dispose() : void
      {
         this.btnOK.removeEventListener(MouseEvent.CLICK,this.onOK);
         this.btnCancel.removeEventListener(MouseEvent.CLICK,this.onCancel);
      }
      
      public function set message(param1:String) : void
      {
         this.msg.text = param1;
         this.adjustSize();
      }
      
      private function adjustSize() : void
      {
         this.btnOK.x = 10;
         this.btnOK.y = this.msg.y + this.msg.height + 20;
         this.btnCancel.x = width - this.btnCancel.x + 5;
         this.btnCancel.y = this.btnOK.y;
         (parent as IWindow).setSize(width + 80,height + 100);
      }
      
      private function onOK(param1:MouseEvent) : void
      {
         var _loc2_:IWindow = parent as IWindow;
         if(_loc2_ != null)
         {
            _loc2_.close();
         }
      }
      
      private function onCancel(param1:MouseEvent) : void
      {
         var _loc2_:IWindow = parent as IWindow;
         if(_loc2_ != null)
         {
            _loc2_.close();
         }
      }
   }
}

