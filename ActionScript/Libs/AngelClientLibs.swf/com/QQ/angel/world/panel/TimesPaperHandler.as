package com.QQ.angel.world.panel
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.command.ICmdListener;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.data.CALLBACK;
   
   public class TimesPaperHandler implements ICmdListener
   {
      
      public function TimesPaperHandler(param1:IAngelSysAPI)
      {
         super();
         param1.getGEventAPI().addCmdListener(AngelSysEvent.ON_TIMES_PAPER,this);
      }
      
      public function call(param1:Object) : *
      {
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_SYNC,["Guide",param1]);
         return null;
      }
   }
}

