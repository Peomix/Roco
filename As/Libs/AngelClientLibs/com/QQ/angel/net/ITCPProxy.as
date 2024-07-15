package com.QQ.angel.net
{
   import com.QQ.angel.api.net.protocol.ADF;
   import flash.events.IEventDispatcher;
   
   public interface ITCPProxy extends IEventDispatcher
   {
       
      
      function getID() : int;
      
      function setPolicyPort(param1:int) : void;
      
      function setTimeOut(param1:int) : void;
      
      function connect(param1:String, param2:int) : void;
      
      function reconnect() : void;
      
      function isConnected() : Boolean;
      
      function sendData(param1:ADF) : void;
      
      function close() : void;
      
      function dispose() : void;
   }
}
