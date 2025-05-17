package com.QQ.angel.world.role
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.api.world.role.RoleMotion;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.res.AvatarRequest;
   import com.QQ.angel.world.render.BDRenderPlayer;
   import com.QQ.angel.world.res.MountResAdapter;
   import com.QQ.angel.world.vo.Avatar;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class SimpleAMount
   {
      
      protected var adapter:MountResAdapter;
      
      protected var loaded:Boolean;
      
      protected var currentAvatarBefore:Avatar;
      
      protected var currentAvatarBehind:Avatar;
      
      protected var mountBodyBefore:BDRenderPlayer;
      
      protected var mountBodyBehind:BDRenderPlayer;
      
      protected var mountBodyBeforeC:Sprite;
      
      protected var mountBodyBehindC:Sprite;
      
      protected var currentDirection:int;
      
      protected var currentMotion:int;
      
      protected var currentId:int;
      
      protected var __onLoadDoneCallback:Function;
      
      public function SimpleAMount()
      {
         super();
         this.adapter = __global.SysAPI.getResSysAPI().getResAdapter(Constants.MOUNT_RES) as MountResAdapter;
         this.mountBodyBefore = new BDRenderPlayer();
         this.mountBodyBehind = new BDRenderPlayer();
         this.mountBodyBeforeC = new Sprite();
         this.mountBodyBeforeC.addChild(this.mountBodyBefore);
         this.mountBodyBehindC = new Sprite();
         this.mountBodyBehindC.addChild(this.mountBodyBehind);
         this.mountBodyBeforeC.visible = false;
         this.mountBodyBeforeC.y = 20;
         this.mountBodyBehindC.visible = false;
         this.mountBodyBehindC.y = 20;
         this.loaded = false;
         this.currentDirection = 0;
         this.currentMotion = RoleMotion.STAND;
      }
      
      public function getMountBefore() : Sprite
      {
         return this.mountBodyBeforeC;
      }
      
      public function getMountBehind() : Sprite
      {
         return this.mountBodyBehindC;
      }
      
      public function onRender(param1:Event) : void
      {
         this.mountBodyBefore.onRender(param1);
         this.mountBodyBehind.onRender(param1);
      }
      
      public function hasRender() : Boolean
      {
         return true;
      }
      
      public function isLoaded() : Boolean
      {
         return this.loaded;
      }
      
      public function isActive() : Boolean
      {
         return this.loaded;
      }
      
      public function getHeight() : int
      {
         return this.loaded ? 15 : 0;
      }
      
      public function setMountId(param1:uint, param2:Function) : void
      {
         var _loc3_:AvatarRequest = null;
         var _loc4_:Avatar = null;
         var _loc5_:AvatarRequest = null;
         var _loc6_:Avatar = null;
         this.__onLoadDoneCallback = param2;
         if(param1 == 0)
         {
            this.loaded = false;
            this.mountBodyBeforeC.visible = false;
            this.mountBodyBehindC.visible = false;
            this.__onLoadDoneCallback();
         }
         else
         {
            this.mountBodyBeforeC.visible = true;
            this.mountBodyBehindC.visible = true;
            _loc3_ = new AvatarRequest(param1,1,this.currentMotion,new CFunction(this.onLoadMountRes));
            _loc4_ = this.adapter.requestRes(_loc3_) as Avatar;
            this.currentId = param1;
            if(_loc4_ != null)
            {
               _loc5_ = new AvatarRequest(param1,2,this.currentMotion,new CFunction(this.onLoadMountRes));
               _loc6_ = this.adapter.requestRes(_loc5_) as Avatar;
               this.currentAvatarBefore = _loc4_;
               this.currentAvatarBehind = _loc6_;
               this.loaded = true;
               this.mountBodyBefore.playFrames(this.currentAvatarBefore.frames[this.currentDirection]);
               this.mountBodyBehind.playFrames(this.currentAvatarBehind.frames[this.currentDirection]);
               this.__onLoadDoneCallback();
            }
         }
      }
      
      protected function onLoadMountRes(param1:Avatar) : void
      {
         var _loc2_:AvatarRequest = new AvatarRequest(this.currentId,1,this.currentMotion,new CFunction(this.onLoadMountRes));
         this.currentAvatarBefore = this.adapter.requestRes(_loc2_) as Avatar;
         var _loc3_:AvatarRequest = new AvatarRequest(this.currentId,2,this.currentMotion,new CFunction(this.onLoadMountRes));
         this.currentAvatarBehind = this.adapter.requestRes(_loc3_) as Avatar;
         this.loaded = true;
         this.mountBodyBefore.playFrames(this.currentAvatarBefore.frames[this.currentDirection]);
         this.mountBodyBehind.playFrames(this.currentAvatarBehind.frames[this.currentDirection]);
         this.__onLoadDoneCallback();
      }
      
      public function setMotionAndDir(param1:int, param2:int) : void
      {
         var _loc3_:AvatarRequest = null;
         var _loc4_:AvatarRequest = null;
         if(param1 == RoleMotion.S_MAGIC || param1 == RoleMotion.F_MAGIC)
         {
            param1 = RoleMotion.STAND;
         }
         if(!this.loaded)
         {
            this.currentDirection = param2;
            this.currentMotion = param1;
            return;
         }
         if(param1 != this.currentMotion)
         {
            this.currentMotion = param1;
            this.currentDirection = param2;
            _loc3_ = new AvatarRequest(this.currentId,1,this.currentMotion,new CFunction(this.onLoadMountRes));
            this.currentAvatarBefore = this.adapter.requestRes(_loc3_) as Avatar;
            _loc4_ = new AvatarRequest(this.currentId,2,this.currentMotion,new CFunction(this.onLoadMountRes));
            this.currentAvatarBehind = this.adapter.requestRes(_loc4_) as Avatar;
            this.mountBodyBefore.playFrames(this.currentAvatarBefore.frames[this.currentDirection]);
            this.mountBodyBehind.playFrames(this.currentAvatarBehind.frames[this.currentDirection]);
         }
         else if(param2 != this.currentDirection)
         {
            this.currentDirection = param2;
            this.mountBodyBefore.playFrames(this.currentAvatarBefore.frames[this.currentDirection]);
            this.mountBodyBehind.playFrames(this.currentAvatarBehind.frames[this.currentDirection]);
         }
      }
   }
}

