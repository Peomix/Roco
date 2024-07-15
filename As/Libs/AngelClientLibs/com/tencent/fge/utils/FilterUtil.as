package com.tencent.fge.utils
{
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.filters.GradientGlowFilter;
   
   public class FilterUtil
   {
      
      private static var ms_filterGray:Array;
      
      private static var ms_filterDisable:Array;
      
      private static var ms_filterHightLight:Array;
       
      
      public function FilterUtil()
      {
         super();
      }
      
      public static function getSaturationFilter(param1:Number) : ColorMatrixFilter
      {
         return new ColorMatrixFilter([0.3086 * (1 - param1) + param1,0.6094 * (1 - param1),0.082 * (1 - param1),0,0,0.3086 * (1 - param1),0.6094 * (1 - param1) + param1,0.082 * (1 - param1),0,0,0.3086 * (1 - param1),0.6094 * (1 - param1),0.082 * (1 - param1) + param1,0,0,0,0,0,1,0]);
      }
      
      public static function getContrastFilter(param1:Number) : ColorMatrixFilter
      {
         return new ColorMatrixFilter([param1,0,0,0,128 * (1 - param1),0,param1,0,0,128 * (1 - param1),0,0,param1,0,128 * (1 - param1),0,0,0,1,0]);
      }
      
      public static function getBrightnessFilter(param1:Number) : ColorMatrixFilter
      {
         return new ColorMatrixFilter([1,0,0,0,param1,0,1,0,0,param1,0,0,1,0,param1,0,0,0,1,0]);
      }
      
      public static function getInversionFilter() : ColorMatrixFilter
      {
         return new ColorMatrixFilter([-1,0,0,0,255,0,-1,0,0,255,0,0,-1,0,255,0,0,0,1,0]);
      }
      
      public static function getHueFilter(param1:Number) : ColorMatrixFilter
      {
         var _loc2_:Number = Math.cos(param1 * Math.PI / 180);
         var _loc3_:Number = Math.sin(param1 * Math.PI / 180);
         var _loc4_:Number = 0.213;
         var _loc5_:Number = 0.715;
         var _loc6_:Number = 0.072;
         return new ColorMatrixFilter([_loc4_ + _loc2_ * (1 - _loc4_) + _loc3_ * (0 - _loc4_),_loc5_ + _loc2_ * (0 - _loc5_) + _loc3_ * (0 - _loc5_),_loc6_ + _loc2_ * (0 - _loc6_) + _loc3_ * (1 - _loc6_),0,0,_loc4_ + _loc2_ * (0 - _loc4_) + _loc3_ * 0.143,_loc5_ + _loc2_ * (1 - _loc5_) + _loc3_ * 0.14,_loc6_ + _loc2_ * (0 - _loc6_) + _loc3_ * -0.283,0,0,_loc4_ + _loc2_ * (0 - _loc4_) + _loc3_ * (0 - (1 - _loc4_)),_loc5_ + _loc2_ * (0 - _loc5_) + _loc3_ * _loc5_,_loc6_ + _loc2_ * (1 - _loc6_) + _loc3_ * _loc6_,0,0,0,0,0,1,0]);
      }
      
      public static function getThresholdFilter(param1:Number) : ColorMatrixFilter
      {
         return new ColorMatrixFilter([0.3086 * 256,0.6094 * 256,0.082 * 256,0,-256 * param1,0.3086 * 256,0.6094 * 256,0.082 * 256,0,-256 * param1,0.3086 * 256,0.6094 * 256,0.082 * 256,0,-256 * param1,0,0,0,1,0]);
      }
      
      public static function getGrayFilter() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:ColorMatrixFilter = null;
         if(!ms_filterGray)
         {
            _loc1_ = new Array();
            _loc1_ = _loc1_.concat([0.3086,0.6094,0.082,0,0]);
            _loc1_ = _loc1_.concat([0.3086,0.6094,0.082,0,0]);
            _loc1_ = _loc1_.concat([0.3086,0.6094,0.082,0,0]);
            _loc1_ = _loc1_.concat([0,0,0,1,0]);
            _loc2_ = new ColorMatrixFilter(_loc1_);
            ms_filterGray = [_loc2_];
         }
         return ms_filterGray;
      }
      
      public static function getDisableFilter() : Array
      {
         if(!ms_filterDisable)
         {
            ms_filterDisable = [new ColorMatrixFilter([0.34317,0.57893,0.0779,0,0,0.29317,0.62893,0.0779,0,0,0.29317,0.57893,0.1279,0,0,0,0,0,1,0])];
         }
         return ms_filterDisable;
      }
      
      public static function getHighLightFilter() : Array
      {
         if(!ms_filterHightLight)
         {
            ms_filterHightLight = [new ColorMatrixFilter([2,0,0,0,-50,0,2,0,0,-50,0,0,2,0,-50,0,0,0,1,0])];
         }
         return ms_filterHightLight;
      }
      
      public static function getBorderFilter(param1:uint = 0, param2:int = 1) : Array
      {
         var _loc3_:Array = null;
         switch(param2)
         {
            case 2:
               _loc3_ = [new GlowFilter(param1,1,2,2,180,2)];
               break;
            case 3:
               _loc3_ = [new GlowFilter(param1,1,3,3,180,2)];
               break;
            case 1:
            default:
               _loc3_ = [new GlowFilter(param1,1,2,2,8)];
         }
         return _loc3_;
      }
      
      public static function getSelectedFilter(param1:uint, param2:int = 10, param3:Number = 2) : Array
      {
         return [new GradientGlowFilter(0,0,[16777215,param1],[0,1],[0,255],param2,param2,param3,1,"outer",false)];
      }
   }
}
