package com.QQ.angel.world.script.autoexec.trigger
{
   import com.QQ.angel.common.ISceneListener;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.SceneDes;
   import com.QQ.angel.world.script.autoexec.ITriggerListener;
   import com.QQ.angel.world.script.autoexec.ITriggerManager;
   import com.QQ.angel.world.script.autoexec.TriggerTypes;
   
   public class EnterRoomTriggerManager implements ITriggerManager, ISceneListener
   {
      
      protected var triggers:Array;
      
      protected var listener:ITriggerListener;
      
      public function EnterRoomTriggerManager()
      {
         super();
         this.triggers = [];
      }
      
      public function addListener(listener:ITriggerListener) : void
      {
         this.listener = listener;
      }
      
      public function watch() : void
      {
         if(triggers.length == 0)
         {
            return;
         }
         __global.sceneWatcher.addSceneListener(this);
      }
      
      public function getType() : String
      {
         return TriggerTypes.ENTER_ROOM;
      }
      
      public function addTrigger(trigger:XML) : Boolean
      {
         var etg:EnterRoomTrigger = new EnterRoomTrigger();
         etg.parse(trigger);
         triggers.push(etg);
         return true;
      }
      
      public function enterScene(des:SceneDes) : void
      {
         var trigger:EnterRoomTrigger = null;
         var i:int = triggers.length - 1;
         while(i >= 0)
         {
            trigger = triggers[i];
            if(trigger.willTrigger(des))
            {
               if(trigger.once)
               {
                  triggers.splice(i,1);
               }
               listener.fireExec(trigger.script);
            }
            i--;
         }
         if(triggers.length == 0)
         {
            __global.sceneWatcher.removeSceneListener(this);
         }
      }
      
      public function leaveScene(des:SceneDes) : void
      {
      }
   }
}

