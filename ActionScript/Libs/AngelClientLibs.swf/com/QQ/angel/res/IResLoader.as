package com.QQ.angel.res
{
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public interface IResLoader
   {
      
      function load(param1:URLRequest, param2:LoaderContext = null) : void;
      
      function getContent() : *;
      
      function getED() : IEventDispatcher;
      
      function get type() : int;
      
      function unload() : void;
      
      function close() : void;
      
      function getContentDomain() : ApplicationDomain;
      
      function getURL() : String;
   }
}

