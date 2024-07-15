package com.QQ.angel.utils
{
   import flash.system.LoaderContext;
   
   public interface ILocalFile
   {
       
      
      function getURL() : String;
      
      function isNull() : Boolean;
      
      function onFileOpen(param1:Object) : void;
      
      function onFileLoaded(param1:Object) : void;
      
      function onFileLoadError(param1:String) : void;
      
      function getContext() : LoaderContext;
   }
}
