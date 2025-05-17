package com.QQ.angel.plug
{
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.data.entity.CmdExeDes;
   import flash.system.LoaderContext;
   
   public class InstallParams
   {
      
      public var plugName:String;
      
      public var loadType:int;
      
      public var setting:PluginSetting;
      
      public var handler:CFunction;
      
      public var context:LoaderContext;
      
      public var exeDes:CmdExeDes;
      
      public function InstallParams(param1:PluginSetting, param2:CFunction = null, param3:LoaderContext = null)
      {
         super();
         this.setting = param1;
         this.handler = param2;
         this.context = param3;
         this.plugName = param1.plugName;
         this.loadType = param1.loadType;
      }
   }
}

