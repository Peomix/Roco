package com.QQ.angel.logging
{
   public class Xstate
   {
      
      public function Xstate()
      {
         super();
      }
      
      public static function log(param1:int) : void
      {
         log(param1,1);
      }
      
      public static function LogClientOss(param1:int, param2:int) : void
      {
         if(param1 >= 1000)
         {
            log(param2,param1);
         }
         else
         {
            trace("com.QQ.angel.logging.log.Xstate[LogClientOss]:出错！上报id必须大于1000");
         }
      }
      
      public static function logClientStr(param1:int, param2:String) : void
      {
         logClient(param1,param2);
      }
   }
}

