package com.QQ.angel.api.plug.extension
{
   public interface IExtensionRegistry
   {
      
      function addExtensionPoint(param1:IExtensionPoint) : void;
      
      function removeExtensionPoint(param1:IExtensionPoint) : void;
      
      function getExtensionPoint(param1:String) : IExtensionPoint;
      
      function addExtension(param1:String, param2:IExtension) : void;
      
      function removeExtension(param1:String, param2:IExtension) : void;
      
      function getExtensionPoints() : Array;
   }
}

