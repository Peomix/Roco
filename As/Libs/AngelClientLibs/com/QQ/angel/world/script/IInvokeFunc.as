package com.QQ.angel.world.script
{
   public interface IInvokeFunc
   {
       
      
      function setGlobal(param1:Object) : void;
      
      function invoke(param1:String, param2:Function) : void;
      
      function dispose() : void;
   }
}
