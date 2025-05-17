package com.QQ.angel.api.error
{
   import flash.utils.getQualifiedClassName;
   
   public class AngelError extends Error
   {
      
      public static const SYSAPI_IS_NULL:String = "系统API为NULL";
      
      public static const METHOD_NOT_IMPL:String = "方法没有实现";
      
      public function AngelError(param1:String, param2:Object = null)
      {
         var _loc3_:String = "";
         if(param2 != null)
         {
            _loc3_ = getQualifiedClassName(param2);
         }
         param1 = "[" + _loc3_ + "]发生了一个错误:" + param1;
         super(param1);
      }
   }
}

