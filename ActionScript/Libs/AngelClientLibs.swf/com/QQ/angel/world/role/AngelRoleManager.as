package com.QQ.angel.world.role
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.api.world.action.TickManager;
   import com.QQ.angel.api.world.role.IRole;
   import com.QQ.angel.api.world.role.IRoleView;
   import com.QQ.angel.api.world.scene.ILayer;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.MagicSkillDes;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.data.entity.SysEventDes;
   import com.QQ.angel.data.entity.combatsys.GuardianPetDes;
   import com.QQ.angel.utils.AMath;
   import com.QQ.angel.world.actions.ActionsIntro;
   import com.QQ.angel.world.scene.ISceneManager;
   import com.QQ.angel.world.scene.impl.AbstractSceneLogic;
   import com.QQ.angel.world.vo.RoleInfoData;
   import com.QQ.angel.world.vo.RoleStateData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public class AngelRoleManager extends TickManager implements IRoleManager
   {
      
      protected var dproxy:IDataProxy;
      
      protected var magicDProxy:IDataProxy;
      
      protected var spiritDesProxy:IDataProxy;
      
      protected var guardianPetDesProxy:IDataProxy;
      
      protected var layer:ILayer;
      
      protected var roleSys:IAngelRoleSystem;
      
      protected var roleLogicCls:Class;
      
      protected var roleViewCls:Class;
      
      protected var avatarAdapter:IResAdapter;
      
      protected var wearEffectCls:Class;
      
      protected var wearEffect:MovieClip;
      
      protected var roleSpiritsM:RoleSpiritsManager;
      
      protected var guardianPetM:GuardianPetManager;
      
      protected var vipLulusM:VipLuLuManager;
      
      public var mainRoleID:uint = 0;
      
      private var __scenceManager:ISceneManager;
      
      private var __angelSysAPI:IAngelSysAPI;
      
      public function AngelRoleManager(param1:RMArgsContext)
      {
         super();
         this.roleLogicCls = param1.roleLogicCls;
         this.roleViewCls = param1.roleViewCls;
         this.wearEffectCls = param1.wearEffectCls;
         this.avatarAdapter = param1.avataAdapter;
         this.roleSys = param1.roleSys;
         this.magicDProxy = param1.magicDProxy;
         this.guardianPetDesProxy = param1.guardianPetDesProxy;
         this.roleSpiritsM = new RoleSpiritsManager(param1);
         this.vipLulusM = new VipLuLuManager();
         this.guardianPetM = new GuardianPetManager(param1);
      }
      
      protected function calculateAngle(param1:RoleData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:Object = AMath.getVector(param1.locXY.clone(),new Point(480,480));
         param1.direction = _loc2_.dir;
      }
      
      public function set dataProxy(param1:IDataProxy) : void
      {
         this.dproxy = param1;
         var _loc2_:Array = this.dproxy.select("*") as Array;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            this.addRole(_loc2_[_loc3_]);
            _loc3_++;
         }
         var _loc4_:IEventDispatcher = __global.GEventAPI.angelEventDispatcher;
         _loc4_.addEventListener(AngelSysEvent.ON_SYS_EVENT,this.onSysEvent);
      }
      
      private function updateRoleVisible() : void
      {
         if(this.dproxy == null)
         {
            return;
         }
         var _loc1_:Array = this.dproxy.select("*") as Array;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            this.setRoleVisible(_loc1_[_loc2_].uin);
            _loc2_++;
         }
      }
      
      private function onSysEvent(param1:AngelSysEvent) : void
      {
         var _loc2_:SysEventDes = param1.data as SysEventDes;
         switch(_loc2_.type)
         {
            case SysEventDes.ROLE_SET_VISIBLE:
               DEFINE.SET_AVATA_VISIBLE = uint(_loc2_.data);
               this.updateRoleVisible();
         }
      }
      
      public function getWearEffect() : MovieClip
      {
         if(this.wearEffect == null)
         {
            if(this.wearEffectCls == null)
            {
               this.wearEffect = new MovieClip();
            }
            else
            {
               this.wearEffect = new this.wearEffectCls() as MovieClip;
            }
            this.wearEffect.stop();
         }
         return this.wearEffect;
      }
      
      override public function onTickEvent(param1:Event) : void
      {
         super.onTickEvent(param1);
         this.roleSpiritsM.onTick();
         this.vipLulusM.onTick();
         this.guardianPetM.onTick();
      }
      
      public function get dataProxy() : IDataProxy
      {
         return this.dproxy;
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.__angelSysAPI = param1;
         this.__scenceManager = this.__angelSysAPI.getWorldAPI().getSceneAPI() as ISceneManager;
      }
      
      public function addRole(param1:RoleData) : IRole
      {
         var _loc2_:Class = null;
         var _loc6_:uint = 0;
         var _loc7_:MagicSkillDes = null;
         var _loc3_:AbstractSceneLogic = this.__scenceManager.getSceneLogic() as AbstractSceneLogic;
         if(Boolean(_loc3_) && Boolean(_loc3_.CustomRoleView))
         {
            _loc2_ = _loc3_.CustomRoleView;
         }
         var _loc4_:IRole = new this.roleLogicCls() as IRole;
         var _loc5_:IRoleView = _loc2_ ? new _loc2_(this.avatarAdapter) as IRoleView : new this.roleViewCls(this.avatarAdapter) as IRoleView;
         SimpleARoleView(_loc5_).setRoleData(param1);
         _loc4_.attachView(_loc5_);
         if(param1.uin == this.mainRoleID)
         {
            this.calculateAngle(param1);
            _loc5_["setWearEffect"](this.getWearEffect());
         }
         _loc4_.setData(param1);
         _loc4_.addClickListener(this.roleSys);
         _loc4_.initialize();
         this.layer.addElement(_loc4_);
         addTick(_loc4_.getActor());
         if(param1.spiritID != 0)
         {
            this.roleSpiritsM.createHenchman(_loc4_,param1.spiritID,false);
         }
         if(param1.isVip && param1.vipLulu != 0)
         {
            this.vipLulusM.createVipLulu(_loc4_,param1.vipLevel,false);
         }
         if(param1.guardianPetID != 0)
         {
            _loc6_ = param1.guardianPetID * 100 + param1.guardianPetLv;
            this.guardianPetM.createGuardianPet(_loc4_,_loc6_,false);
         }
         if(param1.fishingState != 0)
         {
         }
         if(param1.cursedType != 0)
         {
            try
            {
               _loc7_ = this.magicDProxy.select(param1.cursedType) as MagicSkillDes;
               this.roleSys.applyActionTo3(_loc4_.getActor(),_loc7_.actionType,_loc7_);
            }
            catch(e:Error)
            {
            }
         }
         _loc4_.fly();
         _loc4_.swim();
         _loc4_.magicOffset();
         _loc4_.pkState(param1.pkState);
         _loc4_.fishingState(param1.fishingState);
         this.setRoleVisible(param1.id);
         return _loc4_;
      }
      
      public function setRoleVisible(param1:uint) : void
      {
         var _loc2_:AbstractARole = this.getRoleByID(param1) as AbstractARole;
         if(_loc2_ == null)
         {
            return;
         }
         AbstractARole(_loc2_).setVisible();
         this.vipLulusM.setLuluVisible(param1);
         this.roleSpiritsM.setSpiritVisible(param1);
         this.guardianPetM.setGuardianPetVisible(param1);
      }
      
      public function getRoleSpiritsManager() : RoleSpiritsManager
      {
         return this.roleSpiritsM;
      }
      
      public function getRoleByID(param1:uint) : IRole
      {
         return getTickByID(param1) as IRole;
      }
      
      public function getRoleAtPoint(param1:Number, param2:Number) : IRole
      {
         var _loc3_:IRole = null;
         var _loc4_:int = int(ticksList.length - 1);
         while(_loc4_ >= 0)
         {
            _loc3_ = ticksList[_loc4_] as IRole;
            if(_loc3_.isHit(param1,param2))
            {
               return _loc3_;
            }
            _loc4_--;
         }
         return null;
      }
      
      public function bindLayer(param1:ILayer) : void
      {
         this.layer = param1;
         this.roleSpiritsM.bindLayer(param1);
         this.vipLulusM.bindLayer(param1);
         this.guardianPetM.bindLayer(param1);
      }
      
      public function getRoleList() : Array
      {
         return ticksList;
      }
      
      public function getRoleCounts() : int
      {
         return ticksList.length;
      }
      
      public function removeRoleById(param1:uint) : IRole
      {
         var _loc2_:IRole = removeTickByID(param1) as IRole;
         if(_loc2_ == null)
         {
            return null;
         }
         this.roleSpiritsM.delHenchmanByUin(param1);
         this.vipLulusM.delVipLuluByUin(param1);
         this.guardianPetM.delGuardianPetByUin(param1);
         this.layer.removeElement(_loc2_);
         _loc2_.finalize();
         return _loc2_;
      }
      
      public function roleStateChange(param1:RoleStateData) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc2_:IRole = this.getRoleByID(param1.uin);
         if(_loc2_ == null)
         {
            trace("[RoleSystem] 没有找到UIN为" + param1.uin + "的角色!");
            return;
         }
         var _loc3_:RoleData = _loc2_.getData() as RoleData;
         _loc3_.isFlying = param1.isFlying;
         _loc3_.isSwiming = param1.isSwiming;
         if(_loc3_.swimItem != param1.swimItem)
         {
            _loc3_.swimItem = param1.swimItem;
            _loc2_.swim();
         }
         if(_loc3_.flyItem != param1.flyItem)
         {
            _loc3_.flyItem = param1.flyItem;
            _loc2_.fly();
         }
         if(param1.cursedType == 0 && _loc3_.cursedType != param1.cursedType)
         {
            this.roleSys.applyActionTo3(_loc2_.getActor(),ActionsIntro.DelCursedAction,null);
            if(param1.flyItem > 1)
            {
               _loc2_.fly();
            }
         }
         if(param1.stateType != _loc3_.stateType)
         {
            _loc3_.stateType = param1.stateType;
            _loc2_.setMotionType(param1.stateType);
         }
         if(param1.spiritID != _loc3_.spiritID)
         {
            _loc3_.spiritID = param1.spiritID;
            if(param1.spiritID == 0)
            {
               this.roleSpiritsM.delHenchmanByUin(param1.uin);
            }
            else
            {
               this.roleSpiritsM.createHenchman(_loc2_,param1.spiritID);
            }
         }
         if(param1.isVip != _loc3_.isVip)
         {
            _loc3_.isVip = param1.isVip;
            this.dispatchVipEvent(_loc3_.isVip);
         }
         _loc2_.getView().setName(_loc2_.getData().nickName);
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(param1.guardianPetID != 0 && _loc3_.guardianPetID != 0)
         {
            _loc6_ = _loc3_.guardianPetID * 100 + _loc3_.guardianPetLv;
            _loc4_ = (this.guardianPetDesProxy.select(_loc6_) as GuardianPetDes).phase;
            _loc7_ = param1.guardianPetID * 100 + param1.guardianPetLv;
            _loc5_ = (this.guardianPetDesProxy.select(_loc7_) as GuardianPetDes).phase;
         }
         if(param1.guardianPetID != _loc3_.guardianPetID || _loc4_ != _loc5_)
         {
            _loc3_.guardianPetID = param1.guardianPetID;
            _loc3_.guardianPetLv = param1.guardianPetLv;
            if(param1.guardianPetID == 0)
            {
               this.guardianPetM.delGuardianPetByUin(param1.uin);
            }
            else
            {
               _loc8_ = param1.guardianPetID * 100 + param1.guardianPetLv;
               this.guardianPetM.createGuardianPet(_loc2_,_loc8_);
            }
         }
         if(param1.vipLulu != _loc3_.vipLulu)
         {
            _loc3_.vipLulu = param1.vipLulu;
            if(_loc3_.vipLulu == 0)
            {
               this.vipLulusM.delVipLuluByUin(param1.uin);
            }
            else
            {
               this.vipLulusM.createVipLulu(_loc2_,param1.vipLevel);
            }
         }
         if(_loc3_.vipLevel != param1.vipLevel)
         {
            _loc3_.vipLevel = param1.vipLevel;
            this.dispatchVipEvent(_loc3_.vipLevel);
            if(_loc3_.vipLulu == 1)
            {
               this.vipLulusM.delVipLuluByUin(param1.uin);
               this.vipLulusM.createVipLulu(_loc2_,_loc3_.vipLevel,false);
            }
         }
         if(_loc3_.vipExpiringDays != param1.vipExpiringDays)
         {
            _loc3_.vipExpiringDays = param1.vipExpiringDays;
            this.dispatchVipEvent(_loc3_);
         }
         if(_loc3_.isMagicOffset != param1.isMagicOffset)
         {
            _loc3_.isMagicOffset = param1.isMagicOffset;
            _loc2_.magicOffset();
         }
         if(_loc3_.pkState != param1.pkState)
         {
            _loc3_.pkState = param1.pkState;
            _loc2_.pkState(param1.pkState);
         }
         _loc2_.fishingState(param1.fishingState);
      }
      
      private function dispatchVipEvent(param1:Object) : void
      {
         var _loc2_:IEventDispatcher = __global.GEventAPI.angelEventDispatcher;
         var _loc3_:AngelSysEvent = new AngelSysEvent(AngelSysEvent.ON_SYS_EVENT);
         var _loc4_:SysEventDes = new SysEventDes();
         _loc4_.type = SysEventDes.VIP_LEVEL_CHANGE;
         _loc4_.data = param1;
         _loc3_.data = _loc4_;
         _loc2_.dispatchEvent(_loc3_);
      }
      
      public function roleInfoChange(param1:RoleInfoData) : void
      {
         var _loc2_:IRole = this.getRoleByID(param1.uin);
         if(_loc2_ != null)
         {
            _loc2_.onDataChange(param1);
         }
      }
      
      public function removeAll() : void
      {
         var _loc1_:IRole = null;
         var _loc2_:int = int(ticksList.length - 1);
         while(_loc2_ >= 0)
         {
            _loc1_ = ticksList[_loc2_] as IRole;
            this.layer.removeElement(_loc1_);
            _loc1_.finalize();
            _loc2_--;
         }
         ticksList = [];
         this.roleSpiritsM.removeAll();
         this.vipLulusM.removeAll();
         this.guardianPetM.removeAll();
         this.layer = null;
         this.dproxy = null;
         this.mainRoleID = 0;
      }
   }
}

