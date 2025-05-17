package com.QQ.angel.ui.core
{
   import com.QQ.angel.api.ui.IWindow;
   import com.QQ.angel.api.utils.CFunction;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol390")]
   public class AlertContent extends Sprite implements IWindowContent
   {
      
      public var titleText:TextField;
      
      public var msgText:TextField;
      
      public var btnOK:SimpleButton;
      
      public var btnCancel:SimpleButton;
      
      private var _mode:int;
      
      private var _handler:CFunction;
      
      public function AlertContent()
      {
         super();
         this.mouseEnabled = false;
         this.titleText.mouseEnabled = false;
         this.titleText.htmlText = "";
         this.msgText.autoSize = TextFieldAutoSize.LEFT;
         this.msgText.wordWrap = true;
         this.msgText.mouseEnabled = false;
         this.msgText.htmlText = "";
         this.btnOK.addEventListener(MouseEvent.CLICK,this.onOK);
         this.btnCancel.addEventListener(MouseEvent.CLICK,this.onCancel);
      }
      
      public function dispose() : void
      {
         this.btnOK.removeEventListener(MouseEvent.CLICK,this.onOK);
         this.btnCancel.removeEventListener(MouseEvent.CLICK,this.onCancel);
      }
      
      public function set title(param1:String) : void
      {
         this.titleText.htmlText = param1;
         this.adjustSize();
      }
      
      public function set message(param1:String) : void
      {
         this.msgText.htmlText = param1;
         this.adjustSize();
      }
      
      public function set mode(param1:int) : void
      {
         this._mode = param1;
         switch(this._mode)
         {
            case WindowMode.OK:
               this.btnOK.x = 118;
               this.btnOK.visible = true;
               this.btnCancel.visible = false;
               break;
            case WindowMode.OK_CANCEL:
               this.btnOK.x = 55;
               this.btnOK.visible = true;
               this.btnCancel.x = 175;
               this.btnCancel.visible = true;
         }
      }
      
      public function set handler(param1:CFunction) : void
      {
         this._handler = param1;
      }
      
      private function adjustSize() : void
      {
         this.btnOK.y = this.msgText.y + this.msgText.height + 30;
         this.btnCancel.y = this.btnOK.y;
         (parent as IWindow).setSize(this.msgText.x + this.msgText.width + 15,height + 25);
      }
      
      private function onOK(param1:MouseEvent) : void
      {
         var _loc2_:IWindow = parent as IWindow;
         if(_loc2_ != null)
         {
            _loc2_.close();
         }
         if(this._handler != null)
         {
            this._handler.call(WindowResult.OK);
         }
      }
      
      private function onCancel(param1:MouseEvent) : void
      {
         var _loc2_:IWindow = parent as IWindow;
         if(_loc2_ != null)
         {
            _loc2_.close();
         }
         if(this._handler != null)
         {
            this._handler.call(WindowResult.CANCEL);
         }
      }
   }
}

