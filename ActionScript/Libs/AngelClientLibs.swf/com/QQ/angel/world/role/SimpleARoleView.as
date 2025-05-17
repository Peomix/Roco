package com.QQ.angel.world.role
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.api.ui.IBubble;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.api.world.role.ICursedDisplay;
   import com.QQ.angel.api.world.role.IRoleView;
   import com.QQ.angel.api.world.role.RoleMotion;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.res.AvatarRequest;
   import com.QQ.angel.ui.core.namebg.NameBgView;
   import com.QQ.angel.ui.core.paopao.PaoPaoView;
   import com.QQ.angel.world.effects.FootprintEffect;
   import com.QQ.angel.world.events.ElementViewEvent;
   import com.QQ.angel.world.impl.BaseObjectView;
   import com.QQ.angel.world.magic.IAcceptMagicWithUin;
   import com.QQ.angel.world.magic.ICanBeCursed;
   import com.QQ.angel.world.res.RoleAvatarExtraResRequest;
   import com.QQ.angel.world.res.RoleFootprintResRequest;
   import com.QQ.angel.world.vo.Avatar;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.text.TextField;
   
   public class SimpleARoleView extends BaseObjectView implements IRoleView, ICanBeCursed, IAcceptMagicWithUin, IEventDispatcher
   {
      
      protected var direction:int = -1;
      
      protected var motionType:int;
      
      protected var resAdapter:IResAdapter;
      
      protected var cursedDisplay:ICursedDisplay;
      
      protected var nameTxT:TextField;
      
      protected var m_roleData:RoleData;
      
      protected var currAvatarR:AvatarRequest;
      
      protected var avatarRequest:AvatarRequest;
      
      protected var gotCallBack:CFunction;
      
      protected var motionEvent:ElementViewEvent;
      
      protected var dirEvent:ElementViewEvent;
      
      protected var wearE:MovieClip;
      
      protected var isWearing:int = 0;
      
      protected var trainerIcon:TitleIconLoader;
      
      protected var qualifyIcon:QualifyIconAsset;
      
      protected var achieveTxt:TextField;
      
      protected var avatarTResLdr:RoleAvatarExtraResRequest;
      
      protected var avatarEResLdr:RoleAvatarExtraResRequest;
      
      protected var avatarTransformView:AvatarTransformView;
      
      protected var avatarEffectView:AvatarEffectView;
      
      protected var bodyC:AvatarBodyContainer;
      
      protected var footprintResLdr:RoleFootprintResRequest;
      
      private var footprintEffect:FootprintEffect;
      
      private var m_paopaoView:PaoPaoView;
      
      private var m_namebgView:NameBgView;
      
      private var m_nameBgContainer:Sprite;
      
      private var mount:SimpleAMount;
      
      private var magicArea:SimpleAMagicArea;
      
      private var beforeLayer:Sprite;
      
      private var behindLayer:Sprite;
      
      public function SimpleARoleView(param1:IResAdapter, param2:uint = 0, param3:int = 0)
      {
         super();
         if(param1 == null)
         {
            throw new Error("SimpleARoleView的资源请求适配器不能为NULL");
         }
         this.resAdapter = param1;
         this.bodyC = new AvatarBodyContainer();
         this.bodyC.setBody(body);
         addChild(this.bodyC);
         this.beforeLayer = new Sprite();
         addChild(this.beforeLayer);
         this.behindLayer = new Sprite();
         addChildAt(this.behindLayer,0);
         addChild(this.nameTxT = new TextField());
         this.nameTxT.cacheAsBitmap = true;
         this.nameTxT.selectable = false;
         this.nameTxT.autoSize = "center";
         this.nameTxT.mouseEnabled = false;
         this.nameTxT.mouseWheelEnabled = false;
         this.m_nameBgContainer = new Sprite();
         addChild(this.m_nameBgContainer);
         this.m_namebgView = new NameBgView();
         this.m_namebgView.mouseEnabled = this.m_namebgView.mouseChildren = false;
         this.m_namebgView.setNameLoadCompleteFun(this.onloadNameBgComplete);
         setMouseEnabled(true);
         this.gotCallBack = new CFunction(this.onGotAvatarHandler,this);
         this.avatarRequest = new AvatarRequest(param2,param3,0,this.gotCallBack);
         this.currAvatarR = new AvatarRequest(param2,param3,-1,this.gotCallBack);
         this.motionEvent = new ElementViewEvent(ElementViewEvent.ON_MOTION_CHANGE);
         this.dirEvent = new ElementViewEvent(ElementViewEvent.ON_DIR_CHANGE);
         this.mount = new SimpleAMount();
         this.magicArea = new SimpleAMagicArea();
         this.behindLayer.addChild(this.magicArea.getMagicBehind());
         this.behindLayer.addChild(this.mount.getMountBehind());
         this.beforeLayer.addChild(this.mount.getMountBefore());
         this.beforeLayer.addChild(this.magicArea.getMagicBefore());
      }
      
      public function setIsDazzleAvatar(param1:Boolean) : void
      {
         this.m_roleData.dazzleAvatar = param1;
         this.createClickArea();
         if(!param1)
         {
            this.m_paopaoView && (this.m_paopaoView.y = -85);
            bubble && (bubble.y = -85);
         }
         else
         {
            this.m_paopaoView && (this.m_paopaoView.y = -125);
            bubble && (bubble.y = -125);
         }
      }
      
      override protected function createClickArea() : void
      {
         var _loc1_:Number = 60;
         if(Boolean(this.m_roleData) && this.m_roleData.dazzleAvatar)
         {
            _loc1_ = 120;
         }
         if(hitArea != null)
         {
            removeChild(hitArea);
         }
         addChild(hitArea = new Sprite());
         hitArea.graphics.clear();
         hitArea.graphics.beginFill(16711680,0);
         hitArea.graphics.drawEllipse(-20,-10 - _loc1_,40,_loc1_);
         hitArea.graphics.endFill();
      }
      
      override public function onRender(param1:Event) : void
      {
         body.onRender(param1);
         this.mount.onRender(param1);
         this.magicArea.onRender(param1);
      }
      
      private function onloadNameBgComplete() : void
      {
         if(this.achieveTxt)
         {
            this.refreshAchieveTxtPos();
         }
         this.refreshTrainerIconPos();
      }
      
      private function refreshAchieveTxtPos() : void
      {
         this.achieveTxt.y = 40;
      }
      
      private function refreshTrainerIconPos() : void
      {
         if(this.trainerIcon)
         {
            if(!this.m_roleData.dazzleAvatar && this.m_roleData.namebgId != 0 || this.m_roleData.dazzleAvatar && this.m_roleData.daNamebg != 0)
            {
               if(this.m_namebgView.getTextField() != null)
               {
                  this.trainerIcon.y = this.m_namebgView.getTextField().y + this.m_namebgView.y + this.m_namebgView.getTextField().textHeight + 5;
                  this.trainerIcon.x = this.m_namebgView.x - this.m_namebgView.width / 2 - 5;
                  return;
               }
            }
            this.trainerIcon.y = this.nameTxT.y + this.nameTxT.height;
            this.trainerIcon.x = this.nameTxT.x - 12;
         }
      }
      
      protected function setWearing(param1:int) : void
      {
         this.isWearing = param1;
         if(this.wearE == null)
         {
            return;
         }
         if(this.isWearing == 1)
         {
            this.wearE.gotoAndPlay(1);
            this.addEffect(this.wearE);
         }
         else if(this.isWearing == 2)
         {
            this.wearE.gotoAndPlay("end");
         }
      }
      
      protected function wearingEffectEnd(param1:Event) : void
      {
         this.delEffect(this.wearE);
         this.wearE.gotoAndStop(1);
         this.isWearing = 0;
      }
      
      protected function findAvatar(param1:int, param2:Boolean = false, param3:Avatar = null) : void
      {
         if((param1 == RoleMotion.WALK || param1 == RoleMotion.FLOAT) && this.mount.isActive())
         {
            param1 = RoleMotion.STAND;
         }
         this.currAvatarR.motionType = param1;
         var _loc4_:Avatar = currentAvatar;
         currentAvatar = param3 == null ? this.resAdapter.requestRes(this.currAvatarR) as Avatar : param3;
         if(_loc4_ != null)
         {
            this.resAdapter.disposeRes(_loc4_,param2);
         }
      }
      
      protected function onGotAvatarTransformHandler(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(this.avatarTransformView != null)
         {
            this.avatarTransformView.cancleView(this.bodyC);
            this.avatarTransformView = null;
         }
         this.avatarTransformView = new AvatarTransformView();
         this.avatarTransformView.setView(param1,this.bodyC);
         this.avatarTransformView.playMotion(this.motionType,this.direction);
      }
      
      protected function onGotAvatarEffectHandler(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(this.avatarEffectView != null)
         {
            this.avatarEffectView.cancleView(this.bodyC);
            this.avatarEffectView = null;
         }
         this.avatarEffectView = new AvatarEffectView();
         this.avatarEffectView.setView(param1,this.bodyC);
         this.avatarEffectView.playMotion(this.motionType,this.direction);
      }
      
      private function onGotFootprintEffectHandler(param1:Class) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(this.footprintEffect != null)
         {
            this.footprintEffect.stop();
            this.footprintEffect = null;
         }
         this.footprintEffect = new FootprintEffect();
         this.footprintEffect.init(param1,this);
      }
      
      protected function onGotAvatarHandler(param1:Avatar) : void
      {
         if(param1 == null)
         {
            this.avatarRequest.reset();
            return;
         }
         this.currAvatarR.avatarType = this.avatarRequest.avatarType;
         this.currAvatarR.avatarVersion = this.avatarRequest.avatarVersion;
         this.findAvatar(this.motionType,true,param1.frames != null ? param1 : null);
         var _loc2_:int = this.direction;
         this.direction = -1;
         this.avatarRequest.reset();
         this.playMotion(this.motionType,_loc2_);
         if(this.isWearing == 1)
         {
            this.setWearing(2);
         }
         var _loc3_:ElementViewEvent = new ElementViewEvent(ElementViewEvent.ON_CLOTHES_LOADED);
         _loc3_.data = this;
         this.dispatchEvent(_loc3_);
      }
      
      public function getDirection() : int
      {
         return this.direction;
      }
      
      public function getMotionType() : int
      {
         return this.motionType;
      }
      
      public function setMount(param1:uint) : void
      {
         this.mount.setMountId(param1,this.onSetMountDone);
      }
      
      public function setMagicArea(param1:uint) : void
      {
         this.magicArea.setMagicId(param1,this.onSetMagicDone);
      }
      
      private function onSetMountDone() : void
      {
         var _loc1_:int = this.motionType;
         this.motionType = -1;
         this.playMotion(_loc1_,this.direction);
      }
      
      private function onSetMagicDone() : void
      {
         var _loc1_:int = this.motionType;
         this.motionType = -1;
         this.playMotion(_loc1_,this.direction);
      }
      
      public function playMotion(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = false;
         this.mount.setMotionAndDir(param1,param2);
         this.bodyC.y = -this.mount.getHeight();
         this.magicArea.setMotionAndDir(param1,param2);
         if(this.motionType != param1)
         {
            _loc3_ = true;
            body.setYOffsets(null);
            this.motionType = param1;
            this.findAvatar(param1);
            this.motionEvent.data = param1;
            dispatchEvent(this.motionEvent);
         }
         if(_loc3_ || this.direction != param2)
         {
            if(this.direction != param2)
            {
               this.direction = param2;
               dispatchEvent(this.dirEvent);
            }
            if(body != null && currentAvatar != null && currentAvatar.frames != null)
            {
               body.playFrames(currentAvatar.frames[param2]);
            }
            else
            {
               trace("大哥你修的什么BUG，又为空!");
            }
            if(this.cursedDisplay != null)
            {
               this.cursedDisplay.playMotion(param1,param2);
            }
            if(this.avatarTransformView != null)
            {
               this.avatarTransformView.playMotion(param1,param2);
            }
            if(this.avatarEffectView != null)
            {
               this.avatarEffectView.playMotion(param1,param2);
            }
         }
      }
      
      public function setName(param1:String) : void
      {
         if(Boolean(this.m_roleData) && this.m_roleData.isVip)
         {
            this.nameTxT.textColor = 16711680;
         }
         else
         {
            this.nameTxT.textColor = 0;
         }
         this.nameTxT.text = param1;
         this.nameTxT.x = this.nameTxT.textWidth * -0.5;
         if(this.m_namebgView != null)
         {
            this.m_namebgView.setName(param1);
            this.m_namebgView.y = 40;
            if(Boolean(this.m_roleData) && this.m_roleData.isVip)
            {
               this.m_namebgView.setTextColor(16711680);
            }
            else
            {
               this.m_namebgView.setTextColor(0);
            }
         }
         this.refreshTrainerIconPos();
      }
      
      public function setQualifyIcon(param1:int) : void
      {
         if(param1 >= 1 && param1 <= 6)
         {
            if(this.qualifyIcon == null)
            {
               this.qualifyIcon = new QualifyIconAsset();
            }
            this.qualifyIcon.gotoAndStop(param1);
            this.qualifyIcon.x = this.nameTxT.x + this.nameTxT.textWidth + 4;
            this.qualifyIcon.y = this.nameTxT.y - 3;
            addChildAt(this.qualifyIcon,getChildIndex(this.m_nameBgContainer) - 1);
            this.qualifyIcon.width = 20;
            this.qualifyIcon.height = 20;
         }
         else if(Boolean(this.qualifyIcon) && Boolean(this.qualifyIcon.parent))
         {
            this.qualifyIcon.parent.removeChild(this.qualifyIcon);
            this.qualifyIcon = null;
         }
      }
      
      private function setQualifyIconLeft(param1:int) : void
      {
         if(this.trainerIcon)
         {
            this.trainerIcon.parent.removeChild(this.trainerIcon);
            this.trainerIcon = null;
         }
         if(param1 >= 1 && param1 <= 6)
         {
            if(this.qualifyIcon == null)
            {
               this.qualifyIcon = new QualifyIconAsset();
            }
            this.qualifyIcon.gotoAndStop(param1);
            this.qualifyIcon.x = this.nameTxT.x - 26;
            this.qualifyIcon.y = this.nameTxT.y - 3;
            addChild(this.qualifyIcon);
            this.qualifyIcon.width = 20;
            this.qualifyIcon.height = 20;
         }
         else if(Boolean(this.qualifyIcon) && Boolean(this.qualifyIcon.parent))
         {
            this.qualifyIcon.parent.removeChild(this.qualifyIcon);
            this.qualifyIcon = null;
         }
      }
      
      public function setTrainerLevel(param1:int) : void
      {
      }
      
      public function setSelectedMedal(param1:Object) : void
      {
         this.setMedalNew(param1.idx);
      }
      
      private function setMedalNew(param1:int) : void
      {
         var _loc2_:int = 0;
         if(this.qualifyIcon)
         {
            this.qualifyIcon.parent.removeChild(this.qualifyIcon);
            this.qualifyIcon = null;
         }
         if(param1 == 0 && this.trainerIcon && Boolean(this.trainerIcon.parent))
         {
            this.trainerIcon.parent.removeChild(this.trainerIcon);
         }
         else if(param1 > 0)
         {
            if(this.trainerIcon == null)
            {
               this.trainerIcon = new TitleIconLoader(false,0.4);
            }
            this.trainerIcon.y = this.nameTxT.y + this.nameTxT.height;
            this.trainerIcon.x = this.nameTxT.x - 12;
            addChildAt(this.trainerIcon,getChildIndex(this.m_nameBgContainer) + 1);
            _loc2_ = param1 <= 25 ? param1 - 1 : param1;
            this.trainerIcon.load(new URLRequest(DEFINE.formatFileVersion(DEFINE.COMM_ROOT + "res/titile/" + _loc2_ + ".swf")));
            this.refreshTrainerIconPos();
         }
      }
      
      public function setAchieve(param1:String) : void
      {
         var _loc2_:GlowFilter = null;
         if(this.achieveTxt == null)
         {
            addChild(this.achieveTxt = new TextField());
            this.achieveTxt.cacheAsBitmap = true;
            this.achieveTxt.selectable = false;
            this.achieveTxt.autoSize = "center";
            this.achieveTxt.mouseEnabled = false;
            this.achieveTxt.mouseWheelEnabled = false;
            this.achieveTxt.textColor = 9521694;
            addChild(this.achieveTxt);
            _loc2_ = new GlowFilter(16777215,1,2,2,50,BitmapFilterQuality.LOW,false,false);
            this.achieveTxt.filters = [_loc2_];
         }
         this.achieveTxt.x = this.achieveTxt.textWidth * -0.5;
         this.achieveTxt.y = this.nameTxT.height;
         this.achieveTxt.text = param1;
         if(this.m_namebgView.visible == true && Boolean(this.m_namebgView.parent))
         {
            this.onloadNameBgComplete();
         }
      }
      
      public function setRoleData(param1:RoleData) : void
      {
         this.m_roleData = param1;
         this.createClickArea();
      }
      
      public function getRoleData() : RoleData
      {
         return this.m_roleData;
      }
      
      public function wearAvatar(param1:uint, param2:String, param3:int, param4:int) : void
      {
         if(this.currAvatarR.avatarType == param1 && this.currAvatarR.avatarVersion == param3)
         {
            return;
         }
         if(!this.avatarRequest.isNull())
         {
            this.resAdapter.cancelRequest(this.avatarRequest);
         }
         this.avatarRequest.avatarType = param1;
         this.avatarRequest.avatarVersion = param3;
         this.avatarRequest.motionType = param4;
         this.avatarRequest.avatarURL = param2;
         this.avatarRequest.roleData = this.m_roleData;
         var _loc5_:Avatar = this.resAdapter.requestRes(this.avatarRequest) as Avatar;
         if(_loc5_ != null)
         {
            this.onGotAvatarHandler(_loc5_);
         }
         else
         {
            this.setWearing(1);
         }
      }
      
      public function wearAvatarTransform(param1:int) : void
      {
         if(param1 == 0)
         {
            if(this.avatarTResLdr != null)
            {
               this.avatarTResLdr.cancle();
            }
            if(this.avatarTransformView != null)
            {
               this.avatarTransformView.cancleView(this.bodyC);
               this.avatarTransformView = null;
            }
         }
         else
         {
            if(this.avatarTResLdr == null)
            {
               this.avatarTResLdr = new RoleAvatarExtraResRequest();
               this.avatarTResLdr.onCompleteHandler = this.onGotAvatarTransformHandler;
            }
            this.avatarTResLdr.loadByID(param1);
         }
      }
      
      public function setAvatarEffect(param1:int) : void
      {
         if(param1 == 0)
         {
            if(this.avatarEResLdr != null)
            {
               this.avatarEResLdr.cancle();
            }
            if(this.avatarEffectView != null)
            {
               this.avatarEffectView.cancleView(this.bodyC);
               this.avatarEffectView = null;
            }
         }
         else
         {
            if(this.avatarEResLdr == null)
            {
               this.avatarEResLdr = new RoleAvatarExtraResRequest();
               this.avatarEResLdr.onCompleteHandler = this.onGotAvatarEffectHandler;
            }
            this.avatarEResLdr.loadByID(param1);
         }
      }
      
      public function setFootPrintEffect(param1:int, param2:Boolean) : void
      {
         if(param1 == 0)
         {
            if(this.footprintResLdr != null)
            {
               this.footprintResLdr.cancle();
            }
            if(this.footprintEffect != null)
            {
               this.footprintEffect.stop();
               this.footprintEffect = null;
            }
         }
         else
         {
            if(this.footprintResLdr == null)
            {
               this.footprintResLdr = new RoleFootprintResRequest();
               this.footprintResLdr.onCompleteHandler = this.onGotFootprintEffectHandler;
            }
            this.footprintResLdr.loadByID(param1,param2);
         }
      }
      
      public function setWearEffect(param1:MovieClip) : void
      {
         this.wearE = param1;
         if(this.wearE != null)
         {
            this.wearE.addEventListener("onMVEnd",this.wearingEffectEnd);
         }
      }
      
      public function addEffect(param1:Object) : void
      {
         if(param1 is DisplayObject)
         {
            addChild(param1 as DisplayObject);
         }
      }
      
      public function delEffect(param1:Object) : void
      {
         if(param1 is DisplayObject && param1.parent != null)
         {
            removeChild(param1 as DisplayObject);
         }
      }
      
      public function effectToBody(param1:Object, param2:Boolean = true) : void
      {
         var _loc3_:DisplayObject = param1 as DisplayObject;
         if(_loc3_ == null || !contains(_loc3_))
         {
            return;
         }
         var _loc4_:int = getChildIndex(this.bodyC);
         var _loc5_:int = getChildIndex(_loc3_);
         if(param2)
         {
            if(_loc5_ > _loc4_)
            {
               setChildIndex(_loc3_,_loc4_);
            }
         }
         else
         {
            if(this.cursedDisplay != null)
            {
               _loc4_ += 1;
            }
            if(_loc5_ < _loc4_)
            {
               setChildIndex(_loc3_,_loc4_ + 1);
            }
         }
      }
      
      public function setCursedDis(param1:ICursedDisplay) : void
      {
         var _loc2_:int = 0;
         if(this.cursedDisplay != null)
         {
            if(this.cursedDisplay.hasRender())
            {
               add_remove_RenderList(this.cursedDisplay,false);
            }
            removeChild(this.cursedDisplay.display);
         }
         this.cursedDisplay = param1;
         if(this.cursedDisplay != null)
         {
            _loc2_ = getChildIndex(this.bodyC);
            addChildAt(this.cursedDisplay.display,_loc2_ + 1);
            if(this.cursedDisplay.hasRender())
            {
               add_remove_RenderList(this.cursedDisplay);
            }
            this.cursedDisplay.playMotion(this.motionType,this.direction);
         }
      }
      
      public function useTimerSelf() : Boolean
      {
         return false;
      }
      
      public function onAcceptedUinMagic(param1:int, param2:Number = 0, param3:Number = 0, param4:uint = 0) : Boolean
      {
         var _loc5_:Array = [];
         _loc5_[0] = param1;
         _loc5_[1] = param2;
         _loc5_[2] = param3;
         _loc5_[3] = param4;
         _loc5_[4] = this;
         _loc5_[5] = this.m_roleData;
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_A_ROLE_ACCEPTED_A_THROW_MAGIC,_loc5_,this);
         if(_loc5_[0] != 1027)
         {
            return false;
         }
         dispatchEvent(new Event("onMagicAccepted"));
         return true;
      }
      
      override public function unload() : void
      {
         super.unload();
         this.nameTxT.filters = null;
         this.nameTxT.cacheAsBitmap = false;
         this.motionEvent = null;
         if(this.wearE != null)
         {
            this.wearE.removeEventListener("onMVEnd",this.wearingEffectEnd);
            if(this.isWearing == 2)
            {
               this.delEffect(this.wearE);
               this.wearE.gotoAndStop(1);
               this.isWearing = 0;
            }
            this.wearE = null;
         }
         if(!this.avatarRequest.isNull())
         {
            this.resAdapter.cancelRequest(this.avatarRequest);
            this.resAdapter.disposeRes(currentAvatar,true);
         }
         else
         {
            this.resAdapter.disposeRes(currentAvatar,false,"unload");
         }
         if(this.avatarTResLdr)
         {
            this.avatarTResLdr.cancle();
            this.avatarTResLdr = null;
         }
         if(this.avatarEResLdr)
         {
            this.avatarEResLdr.cancle();
            this.avatarEResLdr = null;
         }
         if(this.avatarTransformView)
         {
            this.avatarTransformView.cancleView(this.bodyC);
            this.avatarTransformView = null;
         }
         if(this.avatarEffectView)
         {
            this.avatarEffectView.cancleView(this.bodyC);
            this.avatarEffectView = null;
         }
         if(this.footprintResLdr)
         {
            this.footprintResLdr.cancle();
            this.footprintResLdr = null;
         }
         if(this.footprintEffect)
         {
            this.footprintEffect.stop();
            this.footprintEffect = null;
         }
      }
      
      public function setTalkBubbleVisible(param1:Boolean) : void
      {
         if(this.m_paopaoView != null)
         {
            if(param1 == true)
            {
               addChild(this.m_paopaoView);
            }
            else if(this.m_paopaoView.parent)
            {
               this.m_paopaoView.parent.removeChild(this.m_paopaoView);
            }
         }
      }
      
      public function getTalkBubbleView() : PaoPaoView
      {
         return this.m_paopaoView;
      }
      
      public function setNameBgid(param1:int, param2:Boolean) : void
      {
         if(param1 != 0)
         {
            this.nameTxT.visible = false;
            this.m_namebgView.setNameBgId(param1,param2);
            this.m_nameBgContainer.addChild(this.m_namebgView);
            if(this.achieveTxt)
            {
               this.refreshAchieveTxtPos();
            }
         }
         else
         {
            if(this.achieveTxt)
            {
               this.achieveTxt.y = this.nameTxT.height;
            }
            this.nameTxT.visible = true;
            if(this.m_namebgView.parent)
            {
               this.m_nameBgContainer.removeChild(this.m_namebgView);
            }
         }
         this.refreshTrainerIconPos();
      }
      
      public function setPaopaoId(param1:int, param2:Boolean) : void
      {
         if(this.m_paopaoView != null)
         {
            if(this.m_paopaoView.parent)
            {
               this.m_paopaoView.parent.removeChild(this.m_paopaoView);
            }
         }
         if(param1 != 0)
         {
            this.m_paopaoView = new PaoPaoView(param1,param2);
            if(param2)
            {
               this.m_paopaoView.y = -125;
            }
            else
            {
               this.m_paopaoView.y = -85;
            }
         }
      }
      
      override public function setBodyVisible(param1:Boolean) : void
      {
         if(this.bodyC)
         {
            this.bodyC.visible = param1;
         }
         else
         {
            super.setBodyVisible(param1);
         }
         this.beforeLayer.visible = param1;
         this.behindLayer.visible = param1;
      }
      
      override public function setBubble(param1:IBubble) : void
      {
         if(param1 == null)
         {
            if(bubble != null)
            {
               bubble.unload();
               bubble = null;
            }
         }
         else
         {
            bubble = param1;
            bubble.setContainer(this);
            if(this.m_roleData.dazzleAvatar)
            {
               bubble.y = -125;
            }
            else
            {
               bubble.y = -85;
            }
         }
      }
   }
}

