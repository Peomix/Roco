package com.QQ.angel.plug
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IPlugManagerAPI;
   import com.QQ.angel.api.plug.IPlugLib;
   import com.QQ.angel.api.plug.IPlugProgram;
   
   public interface IAngelPluginManager extends IPlugManagerAPI
   {
      
      function installFromLib(param1:IPlugLib, param2:PluginSetting) : IPlugProgram;
      
      function getSys() : IAngelSysAPI;
      
      function getSettingByName(param1:String) : PluginSetting;
   }
}

