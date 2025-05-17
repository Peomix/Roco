package com.QQ.angel.world.role
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.api.world.role.RoleMotion;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.res.AvatarRequest;
   import com.QQ.angel.world.render.BDRenderPlayer;
   import com.QQ.angel.world.res.MagicAreaResAdapter;
   import com.QQ.angel.world.vo.Avatar;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class SimpleAMagicArea
   {
      
      protected var adapter:MagicAreaResAdapter;
      
      protected var loaded:Boolean;
      
      protected var currentAvatarBefore:Avatar;
      
      protected var currentAvatarBehind:Avatar;
      
      protected var magicBodyBefore:BDRenderPlayer;
      
      protected var magicBodyBehind:BDRenderPlayer;
      
      protected var magicBodyBeforeC:Sprite;
      
      protected var magicBodyBehindC:Sprite;
      
      protected var currentDirection:int;
      
      protected var currentMotion:int;
      
      protected var currentId:int;
      
      protected var __onLoadDoneCallback:Function;
      
      public function SimpleAMagicArea()
      {
         super();
         this.adapter = __global.SysAPI.getResSysAPI().getResAdapter(Constants.MAGIC_AREA_RES) as MagicAreaResAdapter;
         this.magicBodyBefore = new BDRenderPlayer();
         this.magicBodyBehind = new BDRenderPlayer();
         this.magicBodyBeforeC = new Sprite();
         this.magicBodyBeforeC.addChild(this.magicBodyBefore);
         this.magicBodyBehindC = new Sprite();
         this.magicBodyBehindC.addChild(this.magicBodyBehind);
         this.magicBodyBeforeC.visible = false;
         this.magicBodyBeforeC.y = 20;
         this.magicBodyBehindC.visible = false;
         this.magicBodyBehindC.y = 20;
         this.loaded = false;
         this.currentDirection = 0;
         this.currentMotion = RoleMotion.STAND;
      }
      
      public function getMagicBefore() : Sprite
      {
         return this.magicBodyBeforeC;
      }
      
      public function getMagicBehind() : Sprite
      {
         return this.magicBodyBehindC;
      }
      
      public function onRender(param1:Event) : void
      {
         this.magicBodyBefore.onRender(param1);
         this.magicBodyBehind.onRender(param1);
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
      
      public function setMagicId(param1:uint, param2:Function) : void
      {
         var _loc3_:AvatarRequest = null;
         var _loc4_:Avatar = null;
         var _loc5_:AvatarRequest = null;
         var _loc6_:Avatar = null;
         this.__onLoadDoneCallback = param2;
         if(param1 == 0)
         {
            this.loaded = false;
            this.magicBodyBeforeC.visible = false;
            this.magicBodyBehindC.visible = false;
            this.__onLoadDoneCallback();
         }
         else
         {
            this.magicBodyBeforeC.visible = true;
            this.magicBodyBehindC.visible = true;
            _loc3_ = new AvatarRequest(param1,1,this.currentMotion,new CFunction(this.onLoadMagicRes));
            _loc4_ = this.adapter.requestRes(_loc3_) as Avatar;
            this.currentId = param1;
            if(_loc4_ != null)
            {
               _loc5_ = new AvatarRequest(param1,2,this.currentMotion,new CFunction(this.onLoadMagicRes));
               _loc6_ = this.adapter.requestRes(_loc5_) as Avatar;
               this.currentAvatarBefore = _loc4_;
               this.currentAvatarBehind = _loc6_;
               this.loaded = true;
               this.magicBodyBefore.playFrames(this.currentAvatarBefore.frames[this.currentDirection]);
               this.magicBodyBehind.playFrames(this.currentAvatarBehind.frames[this.currentDirection]);
               this.__onLoadDoneCallback();
            }
         }
      }
      
      protected function onLoadMagicRes(param1:Avatar) : void
      {
         var _loc2_:AvatarRequest = new AvatarRequest(this.currentId,1,this.currentMotion,new CFunction(this.onLoadMagicRes));
         this.currentAvatarBefore = this.adapter.requestRes(_loc2_) as Avatar;
         var _loc3_:AvatarRequest = new AvatarRequest(this.currentId,2,this.currentMotion,new CFunction(this.onLoadMagicRes));
         this.currentAvatarBehind = this.adapter.requestRes(_loc3_) as Avatar;
         this.loaded = true;
         this.magicBodyBefore.playFrames(this.currentAvatarBefore.frames[this.currentDirection]);
         this.magicBodyBehind.playFrames(this.currentAvatarBehind.frames[this.currentDirection]);
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
            _loc3_ = new AvatarRequest(this.currentId,1,this.currentMotion,new CFunction(this.onLoadMagicRes));
            this.currentAvatarBefore = this.adapter.requestRes(_loc3_) as Avatar;
            _loc4_ = new AvatarRequest(this.currentId,2,this.currentMotion,new CFunction(this.onLoadMagicRes));
            this.currentAvatarBehind = this.adapter.requestRes(_loc4_) as Avatar;
            this.magicBodyBefore.playFrames(this.currentAvatarBefore.frames[this.currentDirection]);
            this.magicBodyBehind.playFrames(this.currentAvatarBehind.frames[this.currentDirection]);
         }
         else if(param2 != this.currentDirection)
         {
            this.currentDirection = param2;
            this.magicBodyBefore.playFrames(this.currentAvatarBefore.frames[this.currentDirection]);
            this.magicBodyBehind.playFrames(this.currentAvatarBehind.frames[this.currentDirection]);
         }
      }
   }
}

