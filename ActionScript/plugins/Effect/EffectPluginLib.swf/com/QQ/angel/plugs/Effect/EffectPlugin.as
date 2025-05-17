package com.QQ.angel.plugs.Effect
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.plug.IPlugProgram;
   import flash.events.IEventDispatcher;
   
   public class EffectPlugin implements IPlugProgram
   {
      
      protected var m_plugName:String;
      
      public function EffectPlugin()
      {
         super();
      }
      
      public function call(param1:Object) : *
      {
      }
      
      public function finalize() : Boolean
      {
         m_plugName = null;
         return true;
      }
      
      public function getPlugName() : String
      {
         return this.m_plugName;
      }
      
      public function initialize() : Boolean
      {
         return true;
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
      }
      
      public function getEDispatcher() : IEventDispatcher
      {
         return null;
      }
      
      public function setPlugName(param1:String) : void
      {
         this.m_plugName = param1;
      }
   }
}

VipIconUI;

