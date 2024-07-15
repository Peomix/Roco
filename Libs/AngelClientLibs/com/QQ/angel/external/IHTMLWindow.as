package com.QQ.angel.external
{
   import flash.events.IEventDispatcher;
   
   public interface IHTMLWindow extends IEventDispatcher
   {
       
      
      function lcCall(... rest) : void;
      
      function setListener(param1:Object) : void;
      
      function registerWinEvent(param1:Array) : void;
      
      function getState() : int;
      
      function close() : void;
   }
}
