package com.QQ.angel.net
{
   import com.QQ.angel.api.net.HttpRequest;
   import flash.events.IEventDispatcher;
   
   public interface IHttpProxy extends IEventDispatcher
   {
       
      
      function sendHttpRequest(param1:HttpRequest) : String;
      
      function cancelHttpRequest(param1:String) : Boolean;
      
      function dispose() : void;
   }
}
