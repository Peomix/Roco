package com.QQ.angel.plugs.Login.ui2.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol223")]
   public class PageNavigationPageText extends Sprite
   {
      
      public var txt:TextField;
      
      private var t:TextField;
      
      private var _enabled:Boolean = true;
      
      private var _selected:Boolean = false;
      
      public function PageNavigationPageText()
      {
         super();
         this.graphics.beginFill(0,0);
         this.graphics.drawRect(0,0,this["txt"].width,this["txt"].height);
         this.graphics.endFill();
         this["txt"].mouseEnabled = false;
         this.enabled = true;
         addEventListener(MouseEvent.ROLL_OVER,over);
         addEventListener(MouseEvent.ROLL_OUT,over);
      }
      
      private function over(param1:MouseEvent) : void
      {
         if(selected)
         {
            return;
         }
         this["txt"].textColor = param1.type == MouseEvent.ROLL_OVER ? 39372 : 16777215;
      }
      
      public function get text() : String
      {
         return this["txt"].text;
      }
      
      public function set text(param1:String) : void
      {
         this["txt"].text = param1;
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this.buttonMode = _enabled = param1;
         this.mouseChildren = this.mouseEnabled = param1;
         this.filters = enabled ? [] : [new ColorMatrixFilter([0.1,0.6,0,0,0,0.1,0.6,0,0,0,0.1,0.6,0,0,0,0,0,0,1,0])];
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         this["txt"].textColor = selected ? 39372 : 16777215;
      }
      
      public function dispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,over);
         removeEventListener(MouseEvent.ROLL_OUT,over);
         graphics.clear();
         removeChild(this["txt"]);
      }
   }
}

