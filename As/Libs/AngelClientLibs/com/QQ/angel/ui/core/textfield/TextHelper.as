package com.QQ.angel.ui.core.textfield
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TextHelper
   {
       
      
      public function TextHelper()
      {
         super();
      }
      
      public static function align(param1:TextField, param2:String) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.align = param2;
         param1.defaultTextFormat = _loc3_;
         param1.text = param1.text;
      }
      
      public static function bold(param1:TextField, param2:Object) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.bold = param2;
         param1.defaultTextFormat = _loc3_;
         param1.text = param1.text;
      }
      
      public static function color(param1:TextField, param2:Object) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.color = param2;
         param1.defaultTextFormat = _loc3_;
         param1.text = param1.text;
      }
      
      public static function font(param1:TextField, param2:String) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.font = param2;
         param1.defaultTextFormat = _loc3_;
         param1.text = param1.text;
      }
      
      public static function size(param1:TextField, param2:Object) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.size = param2;
         param1.defaultTextFormat = _loc3_;
         param1.text = param1.text;
      }
      
      public static function letterSpacing(param1:TextField, param2:Object) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.letterSpacing = param2;
         param1.defaultTextFormat = _loc3_;
         param1.text = param1.text;
      }
      
      public static function leading(param1:TextField, param2:Object) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.leading = param2;
         param1.defaultTextFormat = _loc3_;
         param1.text = param1.text;
      }
      
      public static function underline(param1:TextField, param2:Object) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.underline = param2;
         param1.defaultTextFormat = _loc3_;
         param1.text = param1.text;
      }
   }
}
