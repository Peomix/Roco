package com.QQ.angel.api.net
{
   import flash.events.IEventDispatcher;
   
   public interface IDataReceiver extends IEventDispatcher
   {
      
      function onDataReceive(param1:int, param2:Object) : void;
      
      function sendDataToServer(param1:int, param2:Object) : void;
      
      function getAcceptTypes() : Array;
   }
}

