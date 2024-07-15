package com.QQ.angel.logging
{
   public function log(param1:int, param2:int = 1) : void
   {
      var _loc3_:ILogger = AngelLogger.getLogger();
      if(_loc3_ != null)
      {
         _loc3_.log(param1,param2);
      }
   }
}
