package com.QQ.angel.api.plug
{
   import com.QQ.angel.api.IAngelSysAPIAware;
   import flash.events.IEventDispatcher;
   
   public interface IPlugProgram extends IAngelSysAPIAware
   {
       
      
      function initialize() : Boolean;
      
      function finalize() : Boolean;
      
      function call(param1:Object) : *;
      
      function getEDispatcher() : IEventDispatcher;
      
      function setPlugName(param1:String) : void;
      
      function getPlugName() : String;
   }
}
