package com.QQ.angel.logging
{
   public function logClient(param1:int, param2:String) : void
   {
      var _loc3_:ILogger = AngelLogger.getLogger();
      if(_loc3_ != null)
      {
         _loc3_.logClient(param1,param2);
      }
   }
}

