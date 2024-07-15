package com.QQ.angel.world.panel
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.command.ICmdListener;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.data.CALLBACK;
   
   public class OpenCombatHandler implements ICmdListener
   {
       
      
      public function OpenCombatHandler(param1:IAngelSysAPI)
      {
         super();
         param1.getGEventAPI().addCmdListener("onOpenCombat",this);
      }
      
      public function call(param1:Object) : *
      {
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_SYNC,[AngelSysEvent.ON_OPEN_COMBAT,param1]);
         return null;
      }
   }
}
