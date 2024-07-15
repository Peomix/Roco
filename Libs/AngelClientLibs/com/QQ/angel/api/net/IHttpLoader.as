package com.QQ.angel.api.net
{
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   
   public interface IHttpLoader extends IEventDispatcher
   {
       
      
      function close() : void;
      
      function load(param1:URLRequest) : void;
      
      function setIsQueue(param1:Boolean) : void;
      
      function setNoCache(param1:Boolean) : void;
      
      function setTimeOut(param1:int = -1, param2:Boolean = true) : void;
      
      function getLatestURL() : String;
      
      function destroy() : void;
   }
}
