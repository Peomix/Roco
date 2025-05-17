package com.tencent.fge.utils
{
   public class ArrayUtil
   {
      
      public function ArrayUtil()
      {
         super();
      }
      
      public static function vector2array(param1:*) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = new Array();
         if(param1 != null)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_.push(param1[_loc3_]);
               _loc3_++;
            }
            return _loc2_;
         }
         return null;
      }
      
      public static function array2vector(param1:Array, param2:*) : void
      {
         var _loc3_:int = 0;
         if(Boolean(param1) && param2)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               param2.push(param1[_loc3_]);
               _loc3_++;
            }
         }
      }
      
      public static function array2String(param1:Array) : String
      {
         var _loc3_:int = 0;
         var _loc2_:* = "";
         if(param1)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_ += param1[_loc3_];
               if(_loc3_ + 1 < param1.length)
               {
                  _loc2_ += " ";
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
   }
}

