package com.QQ.angel.net
{
   import com.QQ.angel.api.INetSysAPI;
   import flash.net.URLLoader;
   
   public interface INetSystem extends INetSysAPI
   {
      
      function getURLLoader() : URLLoader;
      
      function getHttpProxy() : IHttpProxy;
      
      function getTCPProxy(param1:int = -1) : ITCPProxy;
      
      function setMainTcpProxy(param1:int) : void;
      
      function createTCPProxy(param1:Boolean = true) : ITCPProxy;
      
      function disposeTCPProxy(param1:int) : void;
      
      function trySendData(param1:int, param2:Object, param3:Boolean = false, param4:int = -1) : uint;
   }
}

