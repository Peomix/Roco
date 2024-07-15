package com.QQ.angel.world.scene.cmdLogic
{
   import com.QQ.angel.api.events.BaseEvent;
   import com.QQ.angel.data.entity.SceneCMDDes;
   import com.QQ.angel.world.scene.ISceneCMDLogic;
   import com.QQ.angel.world.scene.ISceneManager;
   import flash.events.IEventDispatcher;
   
   public class SEventCMDLogic implements ISceneCMDLogic
   {
       
      
      protected var manager:ISceneManager;
      
      public function SEventCMDLogic(param1:ISceneManager)
      {
         super();
         this.manager = param1;
      }
      
      public function execute(param1:SceneCMDDes) : void
      {
         var _loc2_:IEventDispatcher = this.manager.getSceneLogic() as IEventDispatcher;
         if(_loc2_ == null)
         {
            trace("[SceneEventCMDLogic] 场景逻辑为空!!");
            return;
         }
         var _loc3_:BaseEvent = new BaseEvent(param1.type);
         _loc3_.data = param1.params;
         _loc2_.dispatchEvent(_loc3_);
      }
   }
}
