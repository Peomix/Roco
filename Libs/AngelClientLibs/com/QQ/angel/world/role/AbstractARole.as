package com.QQ.angel.world.role
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.world.action.ActionExecuter;
   import com.QQ.angel.api.world.action.IAction;
   import com.QQ.angel.api.world.action.IActor;
   import com.QQ.angel.api.world.role.IRole;
   import com.QQ.angel.api.world.role.IRoleView;
   import com.QQ.angel.api.world.scene.ISPlace;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.world.IItemListener;
   import com.QQ.angel.world.actions.AddEffectAction;
   import com.QQ.angel.world.assets.FishingBD;
   import com.QQ.angel.world.assets.MagicBD;
   import com.QQ.angel.world.assets.PKBD;
   import com.QQ.angel.world.role.actions.AddBalloonEffect;
   import com.QQ.angel.world.role.actions.AddBlebEffect;
   import com.QQ.angel.world.role.actions.BroomFlyAction;
   import com.QQ.angel.world.vo.RoleInfoData;
   import com.QQ.angel.world.vo.RoleStateData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class AbstractARole extends EventDispatcher implements IRole, IActor
   {
       
      
      protected var roleData:RoleData;
      
      protected var view:IRoleView;
      
      protected var instanceName:String = "";
      
      protected var actionExecuter:ActionExecuter;
      
      protected var id:uint = 0;
      
      protected var itemListener:IItemListener;
      
      protected var splace:ISPlace;
      
      protected var magicOffsetMC:MovieClip;
      
      protected var pkIcon:MovieClip;
      
      protected var fishIcon:MovieClip;
      
      protected var lastClickTime:int = 0;
      
      public function AbstractARole()
      {
         super();
         this.actionExecuter = new ActionExecuter(this);
      }
      
      protected function onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = getTimer();
         if(this.itemListener != null && !this.itemListener.isFrequency(_loc2_ - this.lastClickTime))
         {
            this.itemListener.onItemClick(this);
            this.lastClickTime = _loc2_;
         }
      }
      
      protected function onMagicHandler(param1:Event) : void
      {
         if(this.itemListener != null)
         {
            this.itemListener.onItemMagic(this);
         }
      }
      
      private function getSelectedMedalInfo() : Object
      {
         var _loc1_:Object = {};
         _loc1_.idx = this.roleData.selectedMedal;
         _loc1_.trainerLevel = this.roleData.trainerLevel;
         _loc1_.qualifyLevel = 0;
         if(this.view is SimpleARoleView && this.view as SimpleARoleView != null)
         {
            _loc1_.qualifyLevel = this.roleData["qualifyEmblem"];
         }
         return _loc1_;
      }
      
      public function initialize(... rest) : void
      {
         var _loc5_:Object = null;
         this.id = this.roleData.id;
         var _loc2_:String = this.roleData.nickName;
         this.view.setName(_loc2_);
         var _loc3_:Object = this.getSelectedMedalInfo();
         this.view.setSelectedMedal(_loc3_);
         var _loc4_:IDataProxy;
         if(_loc4_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.ACHIEVE_LIST_DATA))
         {
            if(_loc5_ = _loc4_.select(this.roleData.achieveId,this.roleData.titleLevel))
            {
               this.view.setAchieve(_loc5_.label);
            }
         }
         this.view.setLocation(this.roleData.locXY);
         this.view.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.view.addEventListener("onMagicAccepted",this.onMagicHandler);
         this.setMotionAndDir(this.roleData.stateType,this.roleData.direction);
         this.view.wearAvatar(this.roleData.avatarType,this.roleData.avatarURL,this.roleData.avatarVersion,this.roleData.motionType);
         if(this.roleData.avatarTransformID != 0 && !this.roleData.dazzleAvatar)
         {
            this.view.wearAvatarTransform(this.roleData.avatarTransformID);
         }
         if(this.roleData.avatarTransformID == 0 && this.roleData.avatarEffectID != 0 && !this.roleData.dazzleAvatar)
         {
            this.view.setAvatarEffect(this.roleData.avatarEffectID);
         }
         if(this.roleData.dazzleAvatar)
         {
            this.view.setFootPrintEffect(this.roleData.daFootprint,this.roleData.dazzleAvatar);
         }
         else
         {
            this.view.setFootPrintEffect(this.roleData.footprintID,this.roleData.dazzleAvatar);
         }
         if(this.roleData.dazzleAvatar)
         {
            this.view.setNameBgid(this.roleData.daNamebg,this.roleData.dazzleAvatar);
         }
         else
         {
            this.view.setNameBgid(this.roleData.namebgId,this.roleData.dazzleAvatar);
         }
         if(this.roleData.dazzleAvatar)
         {
            this.view.setPaopaoId(this.roleData.daPopup,this.roleData.dazzleAvatar);
         }
         else
         {
            this.view.setPaopaoId(this.roleData.paopaoId,this.roleData.dazzleAvatar);
         }
         if(this.roleData.dazzleAvatar)
         {
            this.view.setMount(this.roleData.daMount);
            this.view.setMagicArea(this.roleData.daMagic);
         }
      }
      
      public function finalize() : void
      {
         this.actionExecuter.clear();
         this.view.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.view.removeEventListener("onMagicAccepted",this.onMagicHandler);
         this.view.unload();
         this.roleData = null;
         this.actionExecuter = null;
         this.itemListener = null;
         this.id = 0;
      }
      
      public function getDirection() : int
      {
         if(this.roleData != null)
         {
            return this.roleData.direction;
         }
         return 0;
      }
      
      public function setDirection(param1:int) : void
      {
         if(this.getDirection() == param1)
         {
            return;
         }
         this.roleData.direction = param1;
         this.view.playMotion(this.roleData.motionType,param1);
      }
      
      public function getMotionType() : int
      {
         if(this.roleData != null)
         {
            return this.roleData.motionType;
         }
         return 0;
      }
      
      public function setMotionType(param1:int) : void
      {
         if(this.getMotionType() == param1)
         {
            return;
         }
         this.roleData.motionType = param1;
         this.view.playMotion(param1,this.roleData.direction);
      }
      
      public function setMotionAndDir(param1:int, param2:int) : void
      {
         if(this.getMotionType() == param1 && this.getDirection() == param2)
         {
            return;
         }
         this.roleData.motionType = param1;
         this.roleData.direction = param2;
         this.view.playMotion(param1,param2);
      }
      
      public function getPosition() : Point
      {
         return this.roleData.locXY.clone();
      }
      
      public function setPosition(param1:Point) : void
      {
         this.view.setLocation(param1);
         var _loc2_:Point = this.roleData.locXY.clone();
         this.roleData.locXY.x = param1.x;
         this.roleData.locXY.y = param1.y;
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_A_ROLE_POSITION_CHANGED,[this,_loc2_,this.roleData.locXY,this.roleData.uin]);
      }
      
      public function getSpeed() : Number
      {
         if(this.roleData != null)
         {
            return this.roleData.speed;
         }
         return 3;
      }
      
      public function setVisible() : void
      {
         if(this.roleData.id == __global.MainRoleData.id)
         {
            return;
         }
         var _loc1_:Boolean = DEFINE.SET_AVATA_VISIBLE == 0 ? false : true;
         Sprite(this.view).visible = _loc1_;
      }
      
      public function canExecAction(param1:int) : Boolean
      {
         return this.actionExecuter.canExecAction(param1);
      }
      
      public function setID(param1:uint) : void
      {
         this.id = param1;
      }
      
      public function getID() : uint
      {
         return this.id;
      }
      
      public function getName() : String
      {
         return this.instanceName;
      }
      
      public function getView() : *
      {
         return this.view;
      }
      
      public function getRoleView() : IRoleView
      {
         return this.view as IRoleView;
      }
      
      public function onTick(... rest) : void
      {
         this.actionExecuter.onTick();
      }
      
      public function act(param1:IAction) : Boolean
      {
         return this.actionExecuter.act(param1);
      }
      
      public function getData() : Object
      {
         return this.roleData;
      }
      
      public function setData(param1:Object) : void
      {
         this.roleData = param1 as RoleData;
      }
      
      public function attachView(param1:*) : void
      {
         if(param1 is IRoleView)
         {
            this.view = param1 as IRoleView;
            this.instanceName = (param1 as IRoleView).display.name;
            return;
         }
         throw new Error("角色类不能绑定非IRoleView的视图实例!");
      }
      
      public function get display() : DisplayObject
      {
         if(this.view != null)
         {
            return this.view.display;
         }
         return null;
      }
      
      public function onDataChange(param1:Object) : void
      {
         var _loc4_:IDataProxy = null;
         var _loc5_:Object = null;
         var _loc2_:RoleInfoData = param1 as RoleInfoData;
         if(this.roleData.nickName != _loc2_.nickName)
         {
            this.roleData.nickName = _loc2_.nickName;
            this.getRoleView().setName(this.roleData.nickName);
         }
         else if(this.roleData.avatarVersion != _loc2_.avatarVer)
         {
            this.roleData.avatarVersion = _loc2_.avatarVer;
            this.roleData.avatarType = this.roleData.uin;
            this.getRoleView().wearAvatar(this.roleData.avatarType,this.roleData.avatarURL,this.roleData.avatarVersion,this.roleData.motionType);
         }
         else if(this.roleData.level != _loc2_.level)
         {
            this.roleData.level = _loc2_.level;
            if(this.itemListener != null)
            {
               this.itemListener.onItemLevelUp(this,_loc2_.level);
            }
         }
         else if(this.roleData.trainerLevel != _loc2_.trainerLevel)
         {
            this.roleData.trainerLevel = _loc2_.trainerLevel;
            this.view.setTrainerLevel(this.roleData.trainerLevel);
         }
         if(this.roleData.achieveId != _loc2_.achieveId || this.roleData.titleLevel != _loc2_.titleLevel)
         {
            this.roleData.achieveId = _loc2_.achieveId;
            this.roleData.titleLevel = _loc2_.titleLevel;
            if(_loc4_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.ACHIEVE_LIST_DATA))
            {
               if(_loc5_ = _loc4_.select(this.roleData.achieveId,this.roleData.titleLevel))
               {
                  this.view.setAchieve(_loc5_.label);
               }
               else
               {
                  this.view.setAchieve("");
               }
            }
         }
         if(this.roleData.daMount != _loc2_.daMount || this.roleData.dazzleAvatar != _loc2_.dazzleAvatar)
         {
            this.roleData.daMount = _loc2_.daMount;
            if(_loc2_.dazzleAvatar)
            {
               this.getRoleView().setMount(this.roleData.daMount);
            }
            else
            {
               this.getRoleView().setMount(0);
            }
         }
         if(this.roleData.daMagic != _loc2_.daMagic || this.roleData.dazzleAvatar != _loc2_.dazzleAvatar)
         {
            this.roleData.daMagic = _loc2_.daMagic;
            if(_loc2_.dazzleAvatar)
            {
               this.getRoleView().setMagicArea(this.roleData.daMagic);
            }
            else
            {
               this.getRoleView().setMagicArea(0);
            }
         }
         var _loc3_:Boolean = false;
         if(this.roleData.avatarTransformID != _loc2_.avatarTransformID || this.roleData.dazzleAvatar != _loc2_.dazzleAvatar)
         {
            this.roleData.avatarTransformID = _loc2_.avatarTransformID;
            if(!_loc2_.dazzleAvatar)
            {
               this.getRoleView().wearAvatarTransform(this.roleData.avatarTransformID);
            }
            else
            {
               this.getRoleView().wearAvatarTransform(0);
            }
            if(this.roleData.avatarTransformID != 0 && this.roleData.avatarEffectID != 0)
            {
               this.getRoleView().setAvatarEffect(0);
            }
            if(this.roleData.avatarTransformID == 0 && this.roleData.avatarEffectID != 0)
            {
               _loc3_ = true;
            }
         }
         if(this.roleData.avatarEffectID != _loc2_.avatarEffectID)
         {
            this.roleData.avatarEffectID = _loc2_.avatarEffectID;
            if(this.roleData.avatarTransformID != 0)
            {
               this.getRoleView().setAvatarEffect(0);
            }
            else
            {
               _loc3_ = true;
            }
         }
         if(_loc3_ && !_loc2_.dazzleAvatar)
         {
            this.getRoleView().setAvatarEffect(this.roleData.avatarEffectID);
         }
         if(this.roleData.footprintID != _loc2_.footprintID || this.roleData.daFootprint != _loc2_.daFootprint || this.roleData.dazzleAvatar != _loc2_.dazzleAvatar)
         {
            this.roleData.footprintID = _loc2_.footprintID;
            this.roleData.daFootprint = _loc2_.daFootprint;
            if(!_loc2_.dazzleAvatar)
            {
               this.getRoleView().setFootPrintEffect(this.roleData.footprintID,_loc2_.dazzleAvatar);
            }
            else
            {
               this.getRoleView().setFootPrintEffect(this.roleData.daFootprint,_loc2_.dazzleAvatar);
            }
         }
         if(this.roleData.namebgId != _loc2_.namebgId || this.roleData.daNamebg != _loc2_.daNamebg || this.roleData.dazzleAvatar != _loc2_.dazzleAvatar)
         {
            this.roleData.namebgId = _loc2_.namebgId;
            this.roleData.daNamebg = _loc2_.daNamebg;
            if(_loc2_.dazzleAvatar)
            {
               this.getRoleView().setNameBgid(this.roleData.daNamebg,_loc2_.dazzleAvatar);
            }
            else
            {
               this.getRoleView().setNameBgid(this.roleData.namebgId,_loc2_.dazzleAvatar);
            }
         }
         if(this.roleData.paopaoId != _loc2_.paopaoId || this.roleData.daPopup != _loc2_.daPopup || this.roleData.dazzleAvatar != _loc2_.dazzleAvatar)
         {
            this.roleData.paopaoId = _loc2_.paopaoId;
            this.roleData.daPopup = _loc2_.daPopup;
            if(_loc2_.dazzleAvatar)
            {
               this.getRoleView().setPaopaoId(this.roleData.daPopup,_loc2_.dazzleAvatar);
            }
            else
            {
               this.getRoleView().setPaopaoId(this.roleData.paopaoId,_loc2_.dazzleAvatar);
            }
         }
         if(this.roleData.dazzleAvatar != _loc2_.dazzleAvatar)
         {
            this.roleData.dazzleAvatar = _loc2_.dazzleAvatar;
            this.view.setIsDazzleAvatar(this.roleData.dazzleAvatar);
         }
      }
      
      public function isHit(param1:Number, param2:Number) : Boolean
      {
         if(this.view == null)
         {
            return false;
         }
         return this.view.hitTestPoint(param1,param2,true);
      }
      
      public function isHit2(param1:DisplayObject) : Boolean
      {
         if(param1 == null || this.view == null)
         {
            return false;
         }
         return this.view.hitTestObject(param1);
      }
      
      public function addClickListener(param1:Object) : void
      {
         this.itemListener = param1 as IItemListener;
      }
      
      public function getSPlace() : ISPlace
      {
         return this.splace;
      }
      
      public function setSPlace(param1:ISPlace) : void
      {
         this.splace = param1;
      }
      
      public function getActor() : IActor
      {
         return this;
      }
      
      public function fly() : void
      {
         var _loc1_:int = int(this.roleData.flyItem);
         if(_loc1_ == RoleStateData.FLY_BALLOON)
         {
            this.act(new AddBalloonEffect({
               "id":5,
               "dur":-1
            }));
         }
         else if(_loc1_ > 1 && this.roleData.cursedType == 0)
         {
            this.act(new BroomFlyAction(_loc1_));
         }
      }
      
      public function swim() : void
      {
         var _loc1_:Boolean = this.roleData.dazzleAvatar;
         if(this.roleData.swimItem == RoleStateData.SWIM_BLEB)
         {
            this.act(new AddBlebEffect({
               "id":4,
               "dur":-1,
               "isDazzle":_loc1_
            }));
         }
      }
      
      public function magicOffset(param1:uint = 0) : void
      {
         if(param1 != 0)
         {
            if(this.magicOffsetMC != null)
            {
               this.magicOffsetMC.gotoAndPlay("s2");
            }
            return;
         }
         if(this.roleData.isMagicOffset == 1)
         {
            if(this.magicOffsetMC == null)
            {
               this.magicOffsetMC = new MagicBD();
            }
            this.magicOffsetMC.gotoAndPlay("s1");
            this.act(new AddEffectAction({
               "id":20001,
               "dur":-1,
               "mc":this.magicOffsetMC
            }));
         }
         else if(this.magicOffsetMC != null && this.magicOffsetMC.parent != null)
         {
            this.magicOffsetMC.gotoAndStop("BLANK");
            this.magicOffsetMC.parent.removeChild(this.magicOffsetMC);
         }
      }
      
      public function showCombatResultEffect(param1:uint) : Object
      {
         var _loc2_:Object = new Object();
         if(param1 == 1)
         {
            _loc2_.id = 7;
            _loc2_.dur = 1500;
         }
         else
         {
            _loc2_.id = 8;
            _loc2_.dur = 1500;
         }
         return _loc2_;
      }
      
      public function pkState(param1:int) : void
      {
         if(param1 == 3)
         {
            if(this.pkIcon == null)
            {
               this.pkIcon = new PKBD();
            }
            this.pkIcon.y = -110;
            this.act(new AddEffectAction({
               "id":2000,
               "dur":-1,
               "mc":this.pkIcon
            }));
         }
         else if(this.pkIcon != null && this.pkIcon.parent != null)
         {
            this.pkIcon.parent.removeChild(this.pkIcon);
         }
      }
      
      public function fishingState(param1:int) : void
      {
         if(param1 == 1)
         {
            if(this.fishIcon == null)
            {
               this.fishIcon = new FishingBD();
            }
            this.fishIcon.y = -110;
            this.act(new AddEffectAction({
               "id":156689,
               "dur":-1,
               "mc":this.fishIcon
            }));
         }
         else if(this.fishIcon != null && this.fishIcon.parent != null)
         {
            this.fishIcon.parent.removeChild(this.fishIcon);
         }
      }
   }
}
