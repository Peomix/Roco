package com.tencent.fge.foundation.signals
{
   public interface ISignal
   {
      
      function get numListeners() : uint;
      
      function addOnce(param1:Function) : void;
      
      function add(param1:Function) : void;
      
      function dispatch(... rest) : *;
      
      function remove(param1:Function) : void;
      
      function removeAll() : void;
   }
}

