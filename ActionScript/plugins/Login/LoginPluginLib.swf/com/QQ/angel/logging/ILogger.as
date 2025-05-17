package com.QQ.angel.logging
{
   public interface ILogger
   {
      
      function log(param1:int, param2:int = 1) : void;
      
      function logClient(param1:int, param2:String) : void;
   }
}

