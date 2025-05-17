package com.QQ.angel.world.scene.cmdLogic
{
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.SceneCMDDes;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.protocol.P_FreeRequest;
   import com.QQ.angel.net.protocol.P_GetCTLevel;
   import com.QQ.angel.world.scene.ChallengeTowerEvent;
   import com.QQ.angel.world.scene.IChallengeTower;
   import com.QQ.angel.world.scene.ISceneCMDLogic;
   import com.QQ.angel.world.scene.ISceneData;
   import com.QQ.angel.world.scene.ISceneManager;
   import flash.events.EventDispatcher;
   
   public class ChallengeTowerLogic extends EventDispatcher implements ISceneCMDLogic, IChallengeTower
   {
      
      protected var manager:ISceneManager;
      
      protected var raCallBack:Function;
      
      public function ChallengeTowerLogic(param1:ISceneManager)
      {
         super();
         this.manager = param1;
      }
      
      public function execute(param1:SceneCMDDes) : void
      {
         var _loc3_:ISceneData = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = param1.params;
         switch(_loc2_)
         {
            case ChallengeTowerEvent.BOSS_INIT:
               _loc3_ = this.manager["getSceneData"]() as ISceneData;
               _loc3_.setSceneCache("boss_init",1);
               break;
            case ChallengeTowerEvent.SCENE_CLEAR:
               dispatchEvent(new ChallengeTowerEvent(ChallengeTowerEvent.SCENE_CLEAR));
         }
      }
      
      protected function gotCTLevel(param1:P_GetCTLevel) : void
      {
         __global.UI.closeMiniLoading();
         if(this.raCallBack != null)
         {
            this.raCallBack(param1);
         }
         this.raCallBack = null;
      }
      
      public function requestAccess(param1:Function) : void
      {
         __global.UI.createMiniLoading();
         this.raCallBack = param1;
         var _loc2_:P_FreeRequest = new P_FreeRequest(ADFCmdsType.T_CTOWER_LEVEL,null,P_GetCTLevel,this.gotCTLevel);
         _loc2_.send();
      }
   }
}

