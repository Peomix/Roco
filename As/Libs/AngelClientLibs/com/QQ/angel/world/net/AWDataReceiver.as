package com.QQ.angel.world.net
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IGlobalDataAPI;
   import com.QQ.angel.api.INetSysAPI;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.net.AbstractDataReceiver;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.data.entity.SceneDes;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.processor.GetItemsByTypeP;
   import com.QQ.angel.net.processor.SceneAnyDataBCP;
   import com.QQ.angel.net.processor.SceneAnyDataP;
   import com.QQ.angel.world.IAngelWorld;
   import com.QQ.angel.world.net.processor.ChangeSceneP;
   import com.QQ.angel.world.net.processor.GetRoleListP;
   import com.QQ.angel.world.net.processor.GotCombatAwardP;
   import com.QQ.angel.world.net.protocol.P_ReqSceneChange;
   import com.QQ.angel.world.utils.WorldHelper;
   import flash.events.IEventDispatcher;
   
   public class AWDataReceiver extends AbstractDataReceiver
   {
       
      
      protected var globalData:IGlobalDataAPI;
      
      protected var globalEventDist:IEventDispatcher;
      
      protected var roleDataProxy:IDataProxy;
      
      protected var angelWorld:IAngelWorld;
      
      protected var mainRoleData:RoleData;
      
      public function AWDataReceiver()
      {
         super();
      }
      
      private static function onSceneDataInited(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc5_:AWDataReceiver;
         (_loc5_ = param4 as AWDataReceiver).globalEventDist.dispatchEvent(new AngelSysEvent(AngelSysEvent.ON_SCENEDATA_INIT));
         var _loc6_:SceneDes = __global.SysAPI.getGDataAPI().getGlobalVal(Constants.PRE_SCENE) as SceneDes;
         var _loc7_:SceneDes = __global.SysAPI.getGDataAPI().getGlobalVal(Constants.CUR_SCENE) as SceneDes;
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_NEW_SCENE_ENTERED,[_loc6_,_loc7_]);
         if(!_loc6_)
         {
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_NEW_SCENE_ENTERED_FIRST_TIME,[_loc6_,_loc7_]);
         }
         return CallbackCenter.EVENT_OK;
      }
      
      override public function initialize() : void
      {
         this.angelWorld = sysApi.getWorldAPI() as IAngelWorld;
         this.globalData = sysApi.getGDataAPI();
         this.roleDataProxy = this.globalData.getDataProxy(Constants.ROLE_DATA);
         this.globalEventDist = sysApi.getGEventAPI().angelEventDispatcher;
         this.mainRoleData = this.globalData.getGlobalVal(Constants.MAIN_ROLE_INFO) as RoleData;
         var _loc1_:INetSysAPI = sysApi.getNetSysAPI();
         _loc1_.addDataProcessor(new GetRoleListP());
         _loc1_.addDataProcessor(new ChangeSceneP());
         _loc1_.addDataProcessor(new GotCombatAwardP(sysApi.getGDataAPI().getDataProxy(Constants.ITEM_DATA)));
         _loc1_.addDataProcessor(new SceneAnyDataP());
         _loc1_.addDataProcessor(new SceneAnyDataBCP());
         var _loc2_:GetItemsByTypeP = new GetItemsByTypeP();
         _loc2_.itemDataProxy = sysApi.getGDataAPI().getDataProxy(Constants.ITEM_DATA);
         _loc1_.addDataProcessor(_loc2_);
         _loc1_.addDataReceiver(this);
         var _loc3_:ServerPushReceiver = new ServerPushReceiver();
         _loc3_.setAngelSysAPI(sysApi);
         _loc3_.initialize();
         _loc1_.addDataReceiver(_loc3_);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_WORLD_ON_NEW_SCENE_DATA_INITED,AWDataReceiver.onSceneDataInited,this);
      }
      
      protected function onGetRoleListData(param1:Object) : void
      {
         if(param1.error == true)
         {
            trace("错误:获取人物列表失败,进入场景失败!\n" + "原因:" + param1.message);
            return;
         }
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_NEW_SCENE_ROLE_DATA_LOADED,param1);
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_NEW_SCENE_DATA_INITED,[__global.SysAPI.getGDataAPI().getGlobalVal(Constants.PRE_SCENE),__global.SysAPI.getGDataAPI().getGlobalVal(Constants.CUR_SCENE)]);
      }
      
      protected function clearAndUpdateMain(param1:RoleData) : void
      {
         this.roleDataProxy.clear();
         this.mainRoleData.update(param1);
      }
      
      public function initSceneData(param1:int) : void
      {
         sendDataToServer(ADFCmdsType.T_GetRoleList,param1);
      }
      
      public function requestChangeScene(param1:int, param2:int, param3:uint, param4:int) : void
      {
         trace("请求场景切换[" + param2 + "." + param4 + "]");
         var _loc5_:P_ReqSceneChange;
         (_loc5_ = new P_ReqSceneChange()).newSceneID = param2;
         _loc5_.oldSceneID = param1;
         _loc5_.uin = param3;
         _loc5_.ver = param4;
         sendDataToServer(ADFCmdsType.T_ChangeScene,_loc5_);
      }
      
      override public function onDataReceive(param1:int, param2:Object) : void
      {
         switch(param1)
         {
            case ADFCmdsType.T_GetRoleList:
               this.onGetRoleListData(param2);
               break;
            case ADFCmdsType.T_ChangeScene:
               if(param2.error == false)
               {
                  this.clearAndUpdateMain(param2.roleData);
               }
               this.angelWorld.onChangeSceneRes(param2);
               break;
            case ADFCmdsType.T_COMBAT_AWARD:
            case ADFCmdsType.T_SERVER_MSG:
               WorldHelper.addAward(param2);
         }
      }
      
      override public function getAcceptTypes() : Array
      {
         return [ADFCmdsType.T_GetRoleList,ADFCmdsType.T_ChangeScene,ADFCmdsType.T_COMBAT_AWARD,ADFCmdsType.T_SERVER_MSG];
      }
   }
}
