package com.QQ.angel.world.role
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.IGreenSystem;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.api.world.action.IAction;
   import com.QQ.angel.api.world.action.IActor;
   import com.QQ.angel.api.world.role.IRole;
   import com.QQ.angel.api.world.role.RoleMotion;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.CheckUserInfoDes;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.data.entity.SceneDes;
   import com.QQ.angel.data.entity.SysEventDes;
   import com.QQ.angel.data.entity.WalkAndThenDes;
   import com.QQ.angel.world.IItemListener;
   import com.QQ.angel.world.actions.ActionsIntro;
   import com.QQ.angel.world.actions.AddEffectAction;
   import com.QQ.angel.world.actions.BeCursedAction;
   import com.QQ.angel.world.actions.DelCursedAction;
   import com.QQ.angel.world.actions.MakeMagicAction;
   import com.QQ.angel.world.actions.SpeakAction;
   import com.QQ.angel.world.actions.ThrowAction;
   import com.QQ.angel.world.actions.WalkAction;
   import com.QQ.angel.world.actions.WalkAndThenAction;
   import com.QQ.angel.world.net.ARDataReceiver;
   import com.QQ.angel.world.net.protocol.P_SubBC_Paths;
   import com.QQ.angel.world.res.MagicAreaResAdapter;
   import com.QQ.angel.world.res.MountResAdapter;
   import com.QQ.angel.world.res.RoleAvatarResAdapter;
   import com.QQ.angel.world.scene.HeroAdapter;
   import com.QQ.angel.world.scene.ISceneManager;
   import com.QQ.angel.world.vo.CombatResultVo;
   import com.QQ.angel.world.vo.RoleInfoData;
   import com.QQ.angel.world.vo.RoleStateData;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class AngelRoleSystem extends EventDispatcher implements IGreenSystem, IAngelRoleSystem, IAngelSysAPIAware, IItemListener
   {
      
      private var __angelSysAPI:IAngelSysAPI;
      
      private var __rolesManager:AngelRoleManager;
      
      private var __scenceManager:ISceneManager;
      
      private var __aRdataRec:ARDataReceiver;
      
      private var __mainRoleID:uint;
      
      private var __currScene:SceneDes;
      
      private var __roleActionsMap:Dictionary;
      
      private var __lastMoveTime:int = 0;
      
      private var _shieldActionDic:Dictionary;
      
      public function AngelRoleSystem()
      {
         super();
      }
      
      protected function onSysEvent(param1:AngelSysEvent) : void
      {
         var _loc2_:SysEventDes = param1.data as SysEventDes;
         if(_loc2_ == null)
         {
            return;
         }
      }
      
      public function isFrequency(param1:int) : Boolean
      {
         return param1 < 500;
      }
      
      public function onItemClick(param1:Object) : void
      {
         var _loc2_:IRole = param1 as IRole;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:CheckUserInfoDes = new CheckUserInfoDes();
         _loc3_.uin = _loc2_.getID();
         this.__angelSysAPI.getGEventAPI().cmdExecuted(AngelSysEvent.ON_USER_INFO,_loc3_);
      }
      
      public function onItemMagic(param1:Object, param2:int = 0) : void
      {
         var _loc3_:IRole = param1 as IRole;
         if(_loc3_.getData().isMagicOffset == 0)
         {
            this.applyActionTo3(_loc3_.getActor(),0,{
               "id":1,
               "dur":2200,
               "isDazzle":(_loc3_.getData() as RoleData).dazzleAvatar
            });
         }
      }
      
      public function onItemLevelUp(param1:Object, param2:int) : void
      {
         var _loc3_:IRole = param1 as IRole;
         if(_loc3_.getID() != this.__mainRoleID)
         {
            return;
         }
         var _loc4_:IEventDispatcher = this.__angelSysAPI.getGEventAPI().angelEventDispatcher;
         var _loc5_:AngelSysEvent = new AngelSysEvent(AngelSysEvent.ON_SYS_EVENT);
         var _loc6_:SysEventDes = new SysEventDes();
         _loc6_.type = SysEventDes.LEVEL_UP;
         _loc6_.data = param2;
         _loc5_.data = _loc6_;
         _loc4_.dispatchEvent(_loc5_);
      }
      
      public function onItemSpirit(param1:Object, param2:Object) : void
      {
      }
      
      public function onOneRoleMove(param1:P_SubBC_Paths) : void
      {
         var _loc2_:WalkAction = null;
         var _loc3_:HeroAdapter = null;
         if(param1.bcType == 0)
         {
            if(param1.paths.length > 0)
            {
               _loc2_ = new WalkAction(param1.paths);
               this.applyActionTo(param1.uin,_loc2_);
            }
         }
         else
         {
            _loc3_ = new HeroAdapter();
            _loc3_.bindParams(this,this.getRoleByID(param1.uin));
            __global.fireSceneEvent("changePosition",{
               "hero":_loc3_,
               "bcType":param1.bcType,
               "paths":param1.paths
            });
         }
      }
      
      public function addRole(param1:RoleData) : void
      {
         this.__rolesManager.addRole(param1);
      }
      
      public function removeRoleById(param1:uint) : void
      {
         this.__rolesManager.removeRoleById(param1);
      }
      
      public function onOneRoleStateChange(param1:RoleStateData) : void
      {
         this.__rolesManager.roleStateChange(param1);
      }
      
      public function onOneRoleInfoChange(param1:RoleInfoData) : void
      {
         this.__rolesManager.roleInfoChange(param1);
      }
      
      public function initialize(... rest) : void
      {
         var _loc2_:IResAdapter = new RoleAvatarResAdapter();
         this.__angelSysAPI.getResSysAPI().addResAdapter(_loc2_);
         this.__angelSysAPI.getResSysAPI().addResAdapter(new MountResAdapter());
         this.__angelSysAPI.getResSysAPI().addResAdapter(new MagicAreaResAdapter());
         var _loc3_:RMArgsContext = new RMArgsContext();
         _loc3_.roleLogicCls = AbstractARole;
         _loc3_.roleViewCls = SimpleARoleView;
         _loc3_.avataAdapter = _loc2_;
         _loc3_.wearEffectCls = this.__angelSysAPI.getResSysAPI().getEffectClsByID(3);
         _loc3_.petSkinAdapter = this.__angelSysAPI.getResSysAPI().getResAdapter(Constants.SCENE_RES);
         _loc3_.guardianPetSkinAdapter = this.__angelSysAPI.getResSysAPI().getResAdapter(Constants.GUARDIANPET_RES);
         _loc3_.magicDProxy = this.__angelSysAPI.getGDataAPI().getDataProxy(Constants.MAGIC_DATA);
         _loc3_.roleSys = this;
         _loc3_.spiritDesProxy = this.__angelSysAPI.getGDataAPI().getDataProxy(Constants.SPIRIT_DATA);
         _loc3_.guardianPetDesProxy = this.__angelSysAPI.getGDataAPI().getDataProxy(Constants.GUARDIANPET_DATA);
         this.__rolesManager = new AngelRoleManager(_loc3_);
         this.__rolesManager.setAngelSysAPI(this.__angelSysAPI);
         this.__angelSysAPI.getGEventAPI().addTickListener(this.__rolesManager);
         var _loc4_:IEventDispatcher = this.__angelSysAPI.getGEventAPI().angelEventDispatcher;
         _loc4_.addEventListener(AngelSysEvent.ON_SYS_EVENT,this.onSysEvent);
         this.__scenceManager = this.__angelSysAPI.getWorldAPI().getSceneAPI() as ISceneManager;
         this.__aRdataRec = new ARDataReceiver();
         this.__aRdataRec.setAngelSysAPI(this.__angelSysAPI);
         this.__aRdataRec.initialize();
         this.__mainRoleID = this.__angelSysAPI.getGDataAPI().getGlobalVal(Constants.MAIN_ROLE_INFO)["id"];
         this.__roleActionsMap = new Dictionary();
         this.__roleActionsMap[ActionsIntro.SpeakAction] = SpeakAction;
         this.__roleActionsMap[ActionsIntro.WalkAction] = WalkAction;
         this.__roleActionsMap[ActionsIntro.WalkAndThenAction] = WalkAndThenAction;
         this.__roleActionsMap[ActionsIntro.BeCursedAction] = BeCursedAction;
         this.__roleActionsMap[ActionsIntro.DelCursedAction] = DelCursedAction;
         this.__roleActionsMap[ActionsIntro.AddEffectAction] = AddEffectAction;
         this.__roleActionsMap[ActionsIntro.MakeMagicAction] = MakeMagicAction;
         this.__roleActionsMap[ActionsIntro.ThrowAction] = ThrowAction;
         this._shieldActionDic = new Dictionary();
         trace("[AngelRoleSystem] 角色系统初始化完毕");
      }
      
      public function finalize() : void
      {
      }
      
      public function buildAndLoadRoles() : void
      {
         this.__currScene = this.__angelSysAPI.getGDataAPI().getGlobalVal(Constants.CUR_SCENE) as SceneDes;
         this.__rolesManager.bindLayer(this.__scenceManager.getSceneLogic().getSpaceLayer());
         this.__rolesManager.mainRoleID = this.__mainRoleID;
         this.__rolesManager.dataProxy = this.__angelSysAPI.getGDataAPI().getDataProxy(Constants.ROLE_DATA);
         this.__aRdataRec.setIgnoreNetData();
      }
      
      public function delAndUnloadRoles() : void
      {
         this.__rolesManager.removeAll();
         this.__aRdataRec.setIgnoreNetData(true);
      }
      
      public function distanceToMR(param1:Point) : Number
      {
         var _loc2_:IRole = this.getMainRole();
         if(_loc2_ == null)
         {
            return 0;
         }
         return Point.distance(_loc2_.getPosition(),param1);
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.__angelSysAPI = param1;
      }
      
      public function getRoleByID(param1:uint) : IRole
      {
         return this.__rolesManager.getRoleByID(param1);
      }
      
      public function getMainRole() : IRole
      {
         return this.__rolesManager.getRoleByID(this.__mainRoleID);
      }
      
      public function getRolesList() : Array
      {
         return this.__rolesManager.getRoleList();
      }
      
      public function getRoleCounts() : int
      {
         return this.__rolesManager.getRoleCounts();
      }
      
      public function getRoleManger() : IRoleManager
      {
         return this.__rolesManager;
      }
      
      public function getRoleAtPoint(param1:Number, param2:Number) : IRole
      {
         return this.__rolesManager.getRoleAtPoint(param1,param2);
      }
      
      public function getRoleModel() : Object
      {
         return this.__aRdataRec;
      }
      
      public function isWalkable(param1:uint = 0) : Boolean
      {
         var _loc2_:IRole = null;
         if(param1 == 0 || param1 == uint.MAX_VALUE)
         {
            _loc2_ = this.getMainRole();
         }
         else
         {
            _loc2_ = this.getRoleByID(param1);
         }
         if(_loc2_ == null)
         {
            return false;
         }
         return this.__scenceManager.isWalkable(_loc2_.getPosition());
      }
      
      public function mainRoleWalk(param1:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc6_:WalkAndThenDes = null;
         if(getTimer() - this.__lastMoveTime < 150)
         {
            trace("[AngelRoleSystem] 移动操作频率过快!!");
            return false;
         }
         this.__lastMoveTime = getTimer();
         var _loc2_:IRole = this.__rolesManager.getRoleByID(this.__mainRoleID);
         if(_loc2_ == null || _loc2_.canExecAction(ActionsIntro.WalkAction) == false)
         {
            return false;
         }
         var _loc4_:int = _loc2_.getMotionType() == RoleMotion.FLOAT ? 1 : 0;
         var _loc5_:int = this.__currScene.sceneID;
         if(param1 is Point)
         {
            _loc3_ = this.__scenceManager.findPath(_loc2_.getPosition(),param1 as Point,_loc4_);
            if(_loc3_ == null)
            {
               return false;
            }
            this.applyActionTo3(_loc2_.getActor(),1,_loc3_);
         }
         else if(param1 is WalkAndThenDes)
         {
            _loc6_ = param1 as WalkAndThenDes;
            _loc3_ = this.__scenceManager.findPath(_loc2_.getPosition(),_loc6_.aim.clone(),_loc4_);
            if(_loc3_ == null)
            {
               return false;
            }
            _loc6_.paths = _loc3_;
            if(_loc6_.dis > 0)
            {
               _loc6_.tellStop = new CFunction(this.__aRdataRec.submitPaths,this.__aRdataRec,[_loc5_]);
            }
            this.applyActionTo3(_loc2_.getActor(),17,_loc6_);
         }
         this.__aRdataRec.submitPaths(_loc5_,_loc3_);
         return true;
      }
      
      public function bcRolePos(param1:int, param2:Array) : void
      {
         var _loc3_:int = this.__currScene.sceneID;
         this.__aRdataRec.submitPaths(_loc3_,param2,param1);
      }
      
      public function applyActionTo(param1:uint, param2:IAction) : void
      {
         var _loc3_:IRole = this.__rolesManager.getRoleByID(param1);
         if(_loc3_ != null)
         {
            _loc3_.act(param2);
         }
      }
      
      public function applyActionTo2(param1:uint, param2:int, param3:Object) : void
      {
         var _loc4_:IRole = null;
         if(param1 == 0 || param1 == uint.MAX_VALUE)
         {
            param1 = this.__mainRoleID;
         }
         _loc4_ = this.__rolesManager.getRoleByID(param1);
         if(_loc4_ == null)
         {
            return;
         }
         this.applyActionTo3(_loc4_.getActor(),param2,param3);
      }
      
      public function applyActionTo3(param1:IActor, param2:int, param3:Object) : void
      {
         var _loc4_:Class = this.__roleActionsMap[param2];
         if(this._shieldActionDic[param2] == true)
         {
            trace("[AngelRoleSystem] 该类型Action操作已被屏蔽!!");
            return;
         }
         if(_loc4_ == null || param1 == null)
         {
            trace("[AngelRoleSystem] 没有找到相应的ACTION类，操作失败!!");
            return;
         }
         var _loc5_:IAction = new _loc4_(param3) as IAction;
         param1.act(_loc5_);
      }
      
      public function shieldAction(param1:int) : Boolean
      {
         if(this._shieldActionDic[param1] == null || this._shieldActionDic[param1] == undefined)
         {
            this._shieldActionDic[param1] = true;
            return true;
         }
         return false;
      }
      
      public function unshieldAction(param1:int) : Boolean
      {
         if(this._shieldActionDic[param1] == true)
         {
            delete this._shieldActionDic[param1];
            return true;
         }
         return false;
      }
      
      public function onCombatResultChange(param1:CombatResultVo) : void
      {
         var _loc2_:IRole = this.__rolesManager.getRoleByID(param1.uin);
         if(_loc2_ != null)
         {
            this.applyActionTo2(param1.uin,0,_loc2_.showCombatResultEffect(param1.state));
         }
         _loc2_ = this.__rolesManager.getRoleByID(param1.oUin);
         if(_loc2_ != null)
         {
            this.applyActionTo2(param1.oUin,0,_loc2_.showCombatResultEffect(param1.oState));
         }
      }
   }
}

