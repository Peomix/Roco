package com.QQ.angel.ui.filters
{
   import com.QQ.angel.utils.AdjustColor;
   import flash.display.DisplayObject;
   import flash.display.SimpleButton;
   import flash.filters.ColorMatrixFilter;
   
   public class FilterFactory
   {
      
      public function FilterFactory()
      {
         super();
      }
      
      public static function createGrayFilter(param1:int = -100, param2:int = 0, param3:int = 0, param4:int = 0) : ColorMatrixFilter
      {
         var _loc5_:AdjustColor = new AdjustColor();
         _loc5_.saturation = param1;
         _loc5_.brightness = param2;
         _loc5_.hue = param3;
         _loc5_.contrast = param4;
         return new ColorMatrixFilter(_loc5_.CalculateFinalFlatArray());
      }
      
      public static function setAshingFilter(param1:DisplayObject, param2:Boolean) : void
      {
         if(param1 != null)
         {
            if(param2)
            {
               param1.filters = [];
            }
            else
            {
               param1.filters = [createGrayFilter()];
            }
            if(param1 is SimpleButton)
            {
               SimpleButton(param1).mouseEnabled = param2;
            }
         }
      }
   }
}

