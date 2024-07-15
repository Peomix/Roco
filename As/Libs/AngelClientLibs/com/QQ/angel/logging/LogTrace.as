package com.QQ.angel.logging
{
   import flash.utils.getQualifiedClassName;
   
   public class LogTrace
   {
      
      private static var _info:String = "欢迎使用log系统！\n";
      
      private static var num:uint;
      
      private static var _instance:LogTrace;
       
      
      public function LogTrace()
      {
         super();
      }
      
      public static function log(param1:Object, ... rest) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = uint(rest.length);
         var _loc5_:String = "";
         ++num;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ += String(rest[_loc3_]);
            _loc3_++;
         }
         if(param1 == null)
         {
            _info += String(num) + ".【】: " + _loc5_ + "\n";
         }
         else
         {
            _info += String(num) + ".【" + getQualifiedClassName(param1) + "】:" + _loc5_ + "\n";
         }
      }
      
      public static function clear() : void
      {
         _info = "欢迎使用log系统！\n";
         num = 0;
      }
      
      public static function get info() : String
      {
         return _info;
      }
   }
}
