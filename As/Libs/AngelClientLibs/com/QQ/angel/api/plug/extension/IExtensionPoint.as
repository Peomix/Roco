package com.QQ.angel.api.plug.extension
{
   public interface IExtensionPoint
   {
       
      
      function getID() : String;
      
      function addExtension(param1:IExtension) : void;
      
      function removeExtension(param1:IExtension) : void;
   }
}
