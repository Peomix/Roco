package com.QQ.angel.plugs.AutoExec
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.plug.IPlugProgram;
   import com.QQ.angel.world.script.autoexec.AutoExecManager;
   import flash.events.IEventDispatcher;
   
   public class AutoExecPlugin implements IPlugProgram
   {
      
      protected var m_plugName:String;
      
      protected var autoExecManager:AutoExecManager;
      
      private var _sysApi:IAngelSysAPI;
      
      public function AutoExecPlugin()
      {
         super();
      }
      
      public function setPlugName(name:String) : void
      {
         this.m_plugName = name;
      }
      
      public function call(arg:Object) : *
      {
      }
      
      public function setAngelSysAPI(angelSysAPI:IAngelSysAPI) : void
      {
         _sysApi = angelSysAPI;
      }
      
      public function getPlugName() : String
      {
         return this.m_plugName;
      }
      
      public function finalize() : Boolean
      {
         m_plugName = null;
         return true;
      }
      
      public function initialize() : Boolean
      {
         if(Boolean(_sysApi))
         {
            autoExecManager = new AutoExecManager(_sysApi);
         }
         return true;
      }
      
      public function getEDispatcher() : IEventDispatcher
      {
         return null;
      }
   }
}

