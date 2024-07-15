package com.QQ.angel.world.res
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.world.role.RoleMotion;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.res.AvatarRequest;
   import com.QQ.angel.world.render.BreathFCS;
   import com.QQ.angel.world.render.MotionFCS;
   import com.QQ.angel.world.vo.Avatar;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class RoleAvatarResAdapter extends BaseAvatarResAdapter
   {
       
      
      protected var isCDN:Boolean = false;
      
      private var timer:Timer;
      
      public var delay:uint = 5000;
      
      public var minR:uint = 2;
      
      public var loadN:uint = 0;
      
      protected var delayAvatarLoadArg:AvatarLoadArg;
      
      public function RoleAvatarResAdapter()
      {
         this.delayAvatarLoadArg = new AvatarLoadArg();
         super();
         this.resType = Constants.AVATAR_RES;
         this.isCDN = DEFINE.AVATAR_ROOT.indexOf("key=") != -1;
      }
      
      override protected function getAvatarURL(param1:AvatarRequest) : String
      {
         var _loc2_:String = null;
         if(param1.avatarVersion != 0)
         {
            if(!this.isCDN)
            {
               return super.getAvatarURL(param1);
            }
            _loc2_ = DEFINE.AVATAR_ROOT;
            _loc2_ = _loc2_.replace(/\{key\}/g,param1.avatarURL);
            return _loc2_.replace(/\{ver\}/g,param1.avatarVersion);
         }
         return DEFINE.COMM_ROOT + "swf/" + param1.avatarType + ".swf";
      }
      
      override protected function onAvatarLoaded(param1:LoadTaskEvent, param2:Boolean = false) : void
      {
         param2 = currentLoadArgs.avatarType == 9527;
         var _loc3_:ApplicationDomain = param1.resData.domain;
         var _loc4_:Object = param1.resData.content;
         var _loc5_:uint = currentLoadArgs.avatarType;
         var _loc6_:int = currentLoadArgs.avatarVersion;
         pools.addNewTypeAvatar(_loc3_,_loc5_,_loc6_,param2,null,_loc4_["WH_ARR"]);
         var _loc7_:Avatar;
         (_loc7_ = new Avatar()).styleID = _loc5_;
         _loc7_.version = _loc6_;
         var _loc8_:AvatarRequest = AvatarRequest(currentLoadArgs.reqs[0]);
         if(currentLoadArgs.reqs.length > 0 && _loc8_.roleData != null && _loc8_.roleData.isFlying != 1)
         {
            ++this.loadN;
         }
         currentLoadArgs.avatarLoadedCall(_loc7_);
         currentLoadArgs.clear();
         currentLoadArgs = null;
         if(!this.isDelayLoad())
         {
            loadAvatar();
         }
      }
      
      private function isDelayLoad() : Boolean
      {
         if(this.loadN >= this.minR)
         {
            currentLoadArgs = this.delayAvatarLoadArg;
            if(this.timer == null)
            {
               this.timer = new Timer(this.delay,1);
            }
            if(!this.timer.running)
            {
               this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.timerCompleteHandler);
               this.timer.start();
            }
            return true;
         }
         return false;
      }
      
      private function timerCompleteHandler(param1:Event) : void
      {
         this.loadN = 0;
         this.resetTimer();
         loadAvatar();
      }
      
      private function resetTimer() : void
      {
         if(currentLoadArgs == this.delayAvatarLoadArg)
         {
            currentLoadArgs = null;
            this.loadN = 0;
         }
         if(this.timer == null)
         {
            return;
         }
         this.timer.reset();
         this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.timerCompleteHandler);
      }
      
      override protected function addAvatarRequest(param1:AvatarRequest) : void
      {
         var _loc2_:String = this.getAvatarURL(param1);
         var _loc3_:AvatarLoadArg = findArg(param1);
         if(_loc3_ == null)
         {
            _loc3_ = new AvatarLoadArg();
            this.pushLoadQueue(_loc3_,param1.roleData);
         }
         _loc3_.addReq(param1,_loc2_);
      }
      
      private function pushLoadQueue(param1:AvatarLoadArg, param2:RoleData) : void
      {
         var _loc3_:AvatarLoadArg = null;
         if(param2 != null)
         {
            if(param2.id == __global.MainRoleData.id)
            {
               _loc3_ = param1;
            }
            else if(param2.isFlying == 1)
            {
               loadAvatarList.unshift(param1);
            }
            else
            {
               loadAvatarList.push(param1);
            }
         }
         else
         {
            loadAvatarList.unshift(param1);
         }
         if(_loc3_ != null)
         {
            loadAvatarList.unshift(_loc3_);
         }
      }
      
      override public function initialize(... rest) : void
      {
         super.initialize();
         this.minR = DEFINE.AVATAR_MIN_NUM;
         this.delay = DEFINE.AVATAR_DELAY;
         this.pools = new AvatarCachePools();
         var _loc2_:Dictionary = new Dictionary();
         _loc2_[RoleMotion.STAND] = new BreathFCS(RoleMotion.STAND,[40,3]);
         _loc2_[RoleMotion.F_MAGIC] = new MotionFCS(RoleMotion.S_MAGIC,[6,4],["","onMagicAct"]);
         _loc2_[RoleMotion.S_MAGIC] = new MotionFCS(RoleMotion.S_MAGIC,[6,4,3],["","onMagicAct",""]);
         _loc2_[RoleMotion.FLOAT] = new MotionFCS(RoleMotion.FLOAT,[4,4,3],null,[0,1,0]);
         _loc2_[RoleMotion.WALK] = new MotionFCS(RoleMotion.WALK,[1,2,1,2]);
         this.pools.mfDefined = _loc2_;
         var _loc3_:Dictionary = new Dictionary();
         _loc3_[RoleMotion.STAND] = new MotionFCS(RoleMotion.STAND,[12,12]);
         _loc3_[RoleMotion.F_MAGIC] = new MotionFCS(RoleMotion.S_MAGIC,[6,4],["","onMagicAct"]);
         _loc3_[RoleMotion.S_MAGIC] = new MotionFCS(RoleMotion.S_MAGIC,[6,4],["","onMagicAct"]);
         _loc3_[RoleMotion.FLOAT] = new MotionFCS(RoleMotion.FLOAT,[4,4,3,3],null,[0,1,1,0]);
         _loc3_[RoleMotion.WALK] = new MotionFCS(RoleMotion.WALK,[2,3,2,3]);
         this.pools.mfDazzleDefined = _loc3_;
         this.pools.addNewTypeAvatar(ApplicationDomain.currentDomain,0,0,true,[_Assets_0,_Assets_1,_Assets_2,_Assets_3,_Assets_4,_Assets_5]);
      }
      
      override public function cancelRequest(... rest) : Boolean
      {
         super.cancelRequest(rest[0]);
         if(loadAvatarList.length == 0)
         {
            this.resetTimer();
         }
         return true;
      }
      
      public function requestAvatarSceneEffectMC(param1:int, param2:Function) : *
      {
         var _loc3_:RoleAvatarExtraResRequest = new RoleAvatarExtraResRequest();
         _loc3_.onCompleteHandler = param2;
         _loc3_.loadByID(param1);
         return _loc3_;
      }
   }
}
