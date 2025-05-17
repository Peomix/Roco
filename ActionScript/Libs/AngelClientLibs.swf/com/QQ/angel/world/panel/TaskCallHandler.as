package com.QQ.angel.world.panel
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.command.ICmdListener;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.DealTaskDes;
   import com.QQ.angel.data.entity.NPCDialogData;
   import com.QQ.angel.data.entity.OpenNPCTaskDes2;
   import com.QQ.angel.data.entity.SceneDes;
   import com.QQ.angel.data.npc.NpcDialogCenter;
   
   public class TaskCallHandler implements ICmdListener
   {
      
      public function TaskCallHandler(param1:IAngelSysAPI)
      {
         super();
         param1.getGEventAPI().addCmdListener("onTaskCall",this);
         param1.getGEventAPI().addCmdListener("onTaskCall2",this);
      }
      
      public function call(param1:Object) : *
      {
         var _loc2_:OpenNPCTaskDes2 = null;
         if(param1 is OpenNPCTaskDes2)
         {
            _loc2_ = param1 as OpenNPCTaskDes2;
            if(_loc2_.params == "openTaskPanel")
            {
               CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_SYNC,["TaskPanel",param1]);
            }
            else
            {
               this.openDialog(_loc2_);
            }
         }
         else if(param1 is DealTaskDes)
         {
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_SYNC,["TaskV5",param1]);
         }
         else if(param1 is String)
         {
            if(param1 == "openTaskPanel")
            {
               CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_SYNC,["TaskPanel",param1]);
            }
            else if(param1 == "openDailyTaskPanel")
            {
               CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_SYNC,["DailyTask",param1]);
            }
         }
         return null;
      }
      
      private function openDialog(param1:OpenNPCTaskDes2) : void
      {
         var _loc2_:NPCDialogData = null;
         var _loc3_:CFunction = null;
         if(param1.params != null && param1.params != "")
         {
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_SYNC,["TaskV5",param1]);
            return;
         }
         _loc2_ = NpcDialogCenter.getSingleton().mergeData(param1,__global.SysAPI.getGDataAPI().getGlobalVal(Constants.CUR_SCENE) as SceneDes);
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_A_NPC_DIALOG_PREPARED_TO_OPEN,[param1,_loc2_]);
         if(_loc2_.items.length == 1)
         {
            _loc3_ = _loc2_.items[0].handler;
            if(_loc3_ != null)
            {
               _loc3_.invoke();
            }
            return;
         }
         __global.SysAPI.getUISysAPI().commUIManager.showManagedWin(9,_loc2_);
      }
   }
}

