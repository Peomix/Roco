package com.QQ.angel.world.net
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IGlobalDataAPI;
   import com.QQ.angel.api.INetSysAPI;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.AbstractDataReceiver;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.data.entity.world.IRoleModel;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.world.net.processor.P_CombatResultPush;
   import com.QQ.angel.world.net.processor.RoadSubBCP;
   import com.QQ.angel.world.net.processor.RoleOutInSceneP;
   import com.QQ.angel.world.net.processor.RoleSDataChangeP;
   import com.QQ.angel.world.net.processor.SOneInfoChangeP;
   import com.QQ.angel.world.net.protocol.P_SubBC_Paths;
   import com.QQ.angel.world.role.IAngelRoleSystem;
   import com.QQ.angel.world.vo.CombatResultVo;
   import com.QQ.angel.world.vo.RoleInfoData;
   import com.QQ.angel.world.vo.RoleStateData;
   
   public class ARDataReceiver extends AbstractDataReceiver implements IRoleModel
   {
      
      protected var globalData:IGlobalDataAPI;
      
      protected var roleDataProxy:IDataProxy;
      
      protected var roleSystem:IAngelRoleSystem;
      
      protected var ignoreNetData:Boolean = true;
      
      public function ARDataReceiver()
      {
         super();
      }
      
      override public function initialize() : void
      {
         this.globalData = sysApi.getGDataAPI();
         this.roleDataProxy = this.globalData.getDataProxy(Constants.ROLE_DATA);
         this.roleSystem = sysApi.getWorldAPI().getRoleSysAPI() as IAngelRoleSystem;
         var _loc1_:INetSysAPI = sysApi.getNetSysAPI();
         _loc1_.addDataProcessor(new RoleOutInSceneP());
         _loc1_.addDataProcessor(new RoadSubBCP());
         _loc1_.addDataProcessor(new RoleSDataChangeP());
         _loc1_.addDataProcessor(new SOneInfoChangeP());
         _loc1_.addDataProcessor(new P_CombatResultPush());
         _loc1_.addDataReceiver(this);
      }
      
      public function setIgnoreNetData(param1:Boolean = false) : void
      {
         this.ignoreNetData = param1;
      }
      
      override public function onDataReceive(param1:int, param2:Object) : void
      {
         if(this.ignoreNetData)
         {
            return;
         }
         switch(param1)
         {
            case ADFCmdsType.T_SOneInScene:
               this.roleDataProxy.insert(param2);
               this.roleSystem.addRole(param2 as RoleData);
               trace("[ARDataReceiver] 进入场景人的ID:" + (param2 as RoleData).uin);
               break;
            case ADFCmdsType.T_SOneOutScene:
               this.roleDataProxy.deleted(param2);
               this.roleSystem.removeRoleById(param2 as uint);
               trace("[ARDataReceiver] 离开场景人的ID:" + param2);
               break;
            case ADFCmdsType.T_RoadPosBC:
               trace("[ARDataReceiver] 有人物移动");
               this.roleSystem.onOneRoleMove(param2 as P_SubBC_Paths);
               break;
            case ADFCmdsType.T_StateDataChange:
               trace("[ARDataReceiver] 有人的状态改变了");
               this.roleSystem.onOneRoleStateChange(param2 as RoleStateData);
               break;
            case ADFCmdsType.T_SOneInfoChange:
               trace("[ARDataReceiver] 有人的信息改变了");
               this.roleSystem.onOneRoleInfoChange(param2 as RoleInfoData);
               break;
            case ADFCmdsType.TYPE_COMBAT_END_PUSH:
               this.roleSystem.onCombatResultChange(param2 as CombatResultVo);
         }
      }
      
      override public function getAcceptTypes() : Array
      {
         return [ADFCmdsType.T_SOneInScene,ADFCmdsType.T_SOneOutScene,ADFCmdsType.T_RoadPosBC,ADFCmdsType.T_RoadPosSub,ADFCmdsType.T_StateDataChange,ADFCmdsType.T_SOneInfoChange,ADFCmdsType.TYPE_COMBAT_END_PUSH];
      }
      
      public function submitPaths(param1:int, param2:Array, param3:int = 0) : void
      {
         var _loc4_:P_SubBC_Paths = new P_SubBC_Paths();
         _loc4_.bcType = param3;
         _loc4_.sceneID = param1;
         _loc4_.paths = param2;
         sendDataToServer(ADFCmdsType.T_RoadPosSub,_loc4_);
      }
      
      public function submitAvatarChange(param1:Array) : void
      {
         sendDataToServer(ADFCmdsType.T_ChangeAvatar,param1);
      }
      
      public function addRole(param1:RoleData) : void
      {
         this.onDataReceive(ADFCmdsType.T_SOneInScene,param1);
      }
      
      public function removeRole(param1:uint) : void
      {
         this.onDataReceive(ADFCmdsType.T_SOneOutScene,param1);
      }
      
      public function roleMove(param1:uint, param2:Array) : void
      {
         var _loc3_:P_SubBC_Paths = new P_SubBC_Paths();
         _loc3_.uin = param1;
         _loc3_.paths = param2;
         this.onDataReceive(ADFCmdsType.T_RoadPosBC,_loc3_);
      }
      
      public function changeRoleState(param1:uint, param2:Object) : void
      {
         var _loc3_:RoleStateData = new RoleStateData();
         _loc3_.uin = param1;
         _loc3_.stateType = param2.stateType;
         _loc3_.isFlying = param2.isFlying;
         _loc3_.flyItem = param2.flyItem;
         _loc3_.isSwiming = param2.isSwiming;
         _loc3_.swimItem = param2.swimItem;
         _loc3_.cursedType = param2.cursedType;
         _loc3_.flashType = param2.flashType;
         _loc3_.summonType = param2.summonType;
         _loc3_.rideType = param2.rideType;
         _loc3_.spiritID = param2.spiritID;
         this.onDataReceive(ADFCmdsType.T_StateDataChange,_loc3_);
      }
   }
}

