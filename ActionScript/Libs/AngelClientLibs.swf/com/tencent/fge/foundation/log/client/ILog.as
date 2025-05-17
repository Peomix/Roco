package com.tencent.fge.foundation.log.client
{
   public interface ILog
   {
      
      function trace(param1:String, ... rest) : void;
      
      function error(param1:String, ... rest) : void;
      
      function debug(param1:String, ... rest) : void;
      
      function exthrow(param1:String, ... rest) : void;
      
      function log(param1:String, param2:String, param3:String, ... rest) : void;
   }
}

