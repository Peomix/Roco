package com.QQ.angel.api
{
   import com.QQ.angel.api.plug.IPlugProgram;
   import com.QQ.angel.api.plug.extension.IExtensionRegistry;
   import com.QQ.angel.api.utils.CFunction;
   import flash.system.LoaderContext;
   
   public interface IPlugManagerAPI
   {
      
      function loadAndInstallPlug(param1:String, param2:String, param3:CFunction = null, param4:LoaderContext = null) : void;
      
      function install(param1:IPlugProgram) : Boolean;
      
      function hasPlug(param1:String) : Boolean;
      
      function getPlugByName(param1:String) : IPlugProgram;
      
      function getPlugList() : Array;
      
      function getExtensionRegistry() : IExtensionRegistry;
      
      function uninstall(param1:String) : Boolean;
      
      function installPlugin(param1:String, param2:Boolean = true) : void;
      
      function callPlugin(param1:String, param2:Object = null, param3:Boolean = true, param4:Boolean = true) : void;
   }
}

