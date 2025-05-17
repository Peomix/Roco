package com.QQ.angel.install.logging
{
   public function log(param1:int, param2:int = 1) : void
   {
      SocketLogger.getInstance().log(param1,param2);
   }
}

