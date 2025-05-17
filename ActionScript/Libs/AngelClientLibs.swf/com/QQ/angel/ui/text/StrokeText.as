package com.QQ.angel.ui.text
{
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class StrokeText extends TextField
   {
      
      private var _format:TextFormat;
      
      private var _font:String;
      
      private var _size:int;
      
      private var _align:String;
      
      private var _bold:Boolean;
      
      private var _strokeColor:int;
      
      public function StrokeText()
      {
         super();
         this._format = new TextFormat();
         this.mouseEnabled = false;
         this.selectable = false;
         this.border = false;
         this.textColor = 16777215;
         this.strokeColor = 0;
         this.filters = [this.getFilter()];
      }
      
      public function get font() : String
      {
         return this._font;
      }
      
      public function set font(param1:String) : void
      {
         this._font = param1;
         this._format.font = this._font;
         this.defaultTextFormat = this._format;
      }
      
      public function get size() : int
      {
         return this._size;
      }
      
      public function set size(param1:int) : void
      {
         this._size = param1;
         this._format.size = this._size;
         this.defaultTextFormat = this._format;
      }
      
      public function get align() : String
      {
         return this._align;
      }
      
      public function set align(param1:String) : void
      {
         this._align = param1;
         this._format.align = this._align;
         this.defaultTextFormat = this._format;
      }
      
      public function get bold() : Boolean
      {
         return this._bold;
      }
      
      public function set bold(param1:Boolean) : void
      {
         this._bold = param1;
         this._format.bold = this._bold;
         this.defaultTextFormat = this._format;
      }
      
      public function get strokeColor() : int
      {
         return this._strokeColor;
      }
      
      public function set strokeColor(param1:int) : void
      {
         this._strokeColor = param1;
      }
      
      private function getFilter() : GlowFilter
      {
         var _loc1_:Number = this.strokeColor;
         var _loc2_:Number = 1;
         var _loc3_:Number = 2;
         var _loc4_:Number = 2;
         var _loc5_:Number = 3;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:Number = BitmapFilterQuality.HIGH;
         return new GlowFilter(_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc8_,_loc6_,_loc7_);
      }
   }
}

