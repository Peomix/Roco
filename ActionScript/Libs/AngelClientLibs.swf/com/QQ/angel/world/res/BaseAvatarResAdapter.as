package com.QQ.angel.world.res
{
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.api.res.IResLoadTaskManager;
   import com.QQ.angel.api.res.ResLoadTask;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.data.entity.GotAvatarImgDes;
   import com.QQ.angel.res.AvatarRequest;
   import com.QQ.angel.world.vo.Avatar;
   import flash.events.EventDispatcher;
   import flash.system.ApplicationDomain;
   
   public class BaseAvatarResAdapter extends EventDispatcher implements IResAdapter
   {
      
      protected var resType:String = "";
      
      protected var resLTManager:IResLoadTaskManager;
      
      protected var avatarLoadTask:ResLoadTask;
      
      protected var loadAvatarList:Array;
      
      protected var currentLoadArgs:AvatarLoadArg;
      
      protected var pools:AvatarCachePools;
      
      public function BaseAvatarResAdapter()
      {
         super();
      }
      
      protected function onAvatarLoaded(param1:LoadTaskEvent, param2:Boolean = false) : void
      {
         var _loc3_:ApplicationDomain = param1.resData.domain;
         var _loc4_:Object = param1.resData.content;
         var _loc5_:uint = this.currentLoadArgs.avatarType;
         var _loc6_:int = this.currentLoadArgs.avatarVersion;
         this.pools.addNewTypeAvatar(_loc3_,_loc5_,_loc6_,param2,null,_loc4_["WH_ARR"]);
         var _loc7_:Avatar = new Avatar();
         _loc7_.styleID = _loc5_;
         _loc7_.version = _loc6_;
         this.currentLoadArgs.avatarLoadedCall(_loc7_);
         this.currentLoadArgs.clear();
         this.currentLoadArgs = null;
         this.loadAvatar();
      }
      
      protected function onAvatarLoadError(param1:LoadTaskEvent) : void
      {
         this.currentLoadArgs.avatarLoadedCall(null);
         this.currentLoadArgs.clear();
         this.currentLoadArgs = null;
         this.loadAvatar();
      }
      
      protected function getAvatarURL(param1:AvatarRequest) : String
      {
         var _loc2_:String = DEFINE.AVATAR_ROOT;
         _loc2_ = _loc2_.replace(/\{uin\}/g,param1.avatarType);
         return _loc2_.replace(/\{ver\}/g,param1.avatarVersion);
      }
      
      protected function addAvatarRequest(param1:AvatarRequest) : void
      {
         var _loc2_:String = this.getAvatarURL(param1);
         var _loc3_:AvatarLoadArg = this.findArg(param1);
         if(_loc3_ == null)
         {
            _loc3_ = new AvatarLoadArg();
            this.loadAvatarList.push(_loc3_);
         }
         _loc3_.addReq(param1,_loc2_);
      }
      
      protected function findArg(param1:AvatarRequest) : AvatarLoadArg
      {
         var _loc3_:AvatarLoadArg = null;
         if(this.currentLoadArgs != null && this.currentLoadArgs.match(param1))
         {
            return this.currentLoadArgs;
         }
         var _loc2_:int = int(this.loadAvatarList.length - 1);
         while(_loc2_ >= 0)
         {
            _loc3_ = this.loadAvatarList[_loc2_];
            if(_loc3_.match(param1))
            {
               _loc3_.index = _loc2_;
               return _loc3_;
            }
            _loc2_--;
         }
         return null;
      }
      
      protected function loadAvatar(param1:AvatarRequest = null) : void
      {
         if(param1 != null)
         {
            this.addAvatarRequest(param1);
         }
         if(this.currentLoadArgs == null && this.loadAvatarList.length != 0)
         {
            this.currentLoadArgs = this.loadAvatarList.shift();
            this.avatarLoadTask.paths[0] = this.currentLoadArgs.url;
            this.currentLoadArgs.taskID = this.resLTManager.addLoadTask(this.avatarLoadTask);
         }
      }
      
      public function cancelRequest(... rest) : Boolean
      {
         var _loc3_:AvatarLoadArg = null;
         var _loc2_:AvatarRequest = rest[0];
         if(_loc2_ == null)
         {
            return false;
         }
         if(this.currentLoadArgs != null && this.currentLoadArgs.match(_loc2_))
         {
            this.currentLoadArgs.removeReq(_loc2_);
            if(this.currentLoadArgs.isEmpty())
            {
               this.resLTManager.delLoadTask(this.avatarLoadTask);
               this.currentLoadArgs.clear();
               this.currentLoadArgs = null;
               this.loadAvatar();
            }
         }
         else
         {
            _loc3_ = this.findArg(_loc2_);
            if(_loc3_ == null)
            {
               return false;
            }
            _loc3_.removeReq(_loc2_);
            if(_loc3_.isEmpty())
            {
               this.loadAvatarList.splice(_loc3_.index,1);
               _loc3_.clear();
            }
         }
         return true;
      }
      
      public function disposeRes(... rest) : void
      {
         var _loc2_:Avatar = rest[0] as Avatar;
         var _loc3_:Boolean = rest[1] as Boolean;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc3_)
         {
            this.pools.removeNewTypeAvatar(_loc2_.styleID,_loc2_.version);
         }
         else
         {
            this.pools.giveBackAvatar(_loc2_,rest[2] == "unload");
         }
      }
      
      public function initialize(... rest) : void
      {
         var _loc2_:Boolean = false;
         if(this.resType != "")
         {
            if(!this.resLTManager.hasVipChannel(this.resType))
            {
               _loc2_ = this.resLTManager.createVipChannel(this.resType);
            }
         }
         this.avatarLoadTask = new ResLoadTask();
         this.avatarLoadTask.resType = this.resType;
         this.avatarLoadTask.completeHandler = new CFunction(this.onAvatarLoaded,this);
         this.avatarLoadTask.errorHandler = new CFunction(this.onAvatarLoadError,this);
         this.avatarLoadTask.paths = [""];
         this.loadAvatarList = [];
      }
      
      public function requestRes(... rest) : Object
      {
         var _loc4_:GotAvatarImgDes = null;
         if(rest[0] is GotAvatarImgDes)
         {
            _loc4_ = rest[0];
            return this.pools.getCustomAvatarImg(_loc4_.uin,_loc4_.avatarVer,_loc4_.motionType);
         }
         var _loc2_:AvatarRequest = rest[0];
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:Avatar = this.pools.borrowAvatar(_loc2_.avatarType,_loc2_.avatarVersion,_loc2_.motionType);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         _loc2_.taskID = 1;
         this.loadAvatar(_loc2_);
         return null;
      }
      
      public function finalize() : void
      {
      }
      
      public function removeAllCacheRes() : void
      {
      }
      
      public function stopAllResRequest() : void
      {
      }
      
      public function setResLoadTaskManager(param1:IResLoadTaskManager) : void
      {
         this.resLTManager = param1;
      }
      
      public function getAdapterResType() : String
      {
         return this.resType;
      }
   }
}

