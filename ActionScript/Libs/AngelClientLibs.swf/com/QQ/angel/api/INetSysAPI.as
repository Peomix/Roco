package com.QQ.angel.api
{
   import com.QQ.angel.api.net.HttpRequest;
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.IDataReceiver;
   import flash.events.IEventDispatcher;
   import flash.net.URLLoader;
   
   public interface INetSysAPI extends IEventDispatcher
   {
      
      function addDataProcessor(param1:IDataProcessor) : void;
      
      function removeDataProcessor(param1:IDataProcessor) : void;
      
      function addDataReceiver(param1:IDataReceiver) : void;
      
      function removeDataReceiver(param1:IDataReceiver) : void;
      
      function sendHttpRequest(param1:HttpRequest) : String;
      
      function cancelHttpRequest(param1:String) : Boolean;
      
      function createURLLoader(param1:Boolean = false, param2:int = -1) : URLLoader;
   }
}

