package com.QQ.angel.world.npc.lulu
{
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.res.AvatarRequest;
   import com.QQ.angel.world.events.ElementViewEvent;
   import com.QQ.angel.world.impl.BaseObjectView;
   import com.QQ.angel.world.vo.Avatar;
   import flash.events.Event;
   
   public class VipLuluView extends BaseObjectView
   {
       
      
      protected var direction:int = 0;
      
      protected var resAdapter:IResAdapter;
      
      protected var currAvatarR:AvatarRequest;
      
      protected var avatarRequest:AvatarRequest;
      
      protected var gotCallBack:CFunction;
      
      protected var motionEvent:ElementViewEvent;
      
      protected var hasAvatar:Boolean = false;
      
      public function VipLuluView(param1:IResAdapter, param2:uint = 0, param3:int = 0)
      {
         super();
         if(param1 == null)
         {
            throw new Error("SimpleSpiritView的资源请求适配器不能为NULL");
         }
         this.resAdapter = param1;
         setMouseEnabled(true);
         this.gotCallBack = new CFunction(this.onGotAvatarHandler,this);
         this.avatarRequest = new AvatarRequest(param2,param3,0,this.gotCallBack);
         this.currAvatarR = new AvatarRequest(param2,param3,0,this.gotCallBack);
         this.motionEvent = new ElementViewEvent(ElementViewEvent.ON_MOTION_CHANGE);
      }
      
      protected function updateHeadPos() : void
      {
         if(bubble != null)
         {
            bubble.y = -body.height - 20;
         }
      }
      
      override protected function createClickArea() : void
      {
      }
      
      protected function findAvatar(param1:int, param2:Boolean = false, param3:Avatar = null) : void
      {
         if(!this.hasAvatar)
         {
            return;
         }
         this.currAvatarR.motionType = param1;
         var _loc4_:Avatar = currentAvatar;
         currentAvatar = param3 == null ? this.resAdapter.requestRes(this.currAvatarR) as Avatar : param3;
         if(_loc4_ != null)
         {
            this.resAdapter.disposeRes(_loc4_,false,param2 ? "unload" : "");
         }
      }
      
      protected function onGotAvatarHandler(param1:Avatar) : void
      {
         if(param1 == null)
         {
            this.avatarRequest.reset();
            return;
         }
         this.hasAvatar = true;
         this.currAvatarR.avatarType = this.avatarRequest.avatarType;
         this.currAvatarR.avatarVersion = this.avatarRequest.avatarVersion;
         this.findAvatar(this.currAvatarR.motionType,true,param1.frames != null ? param1 : null);
         var _loc2_:int = this.direction;
         this.direction = -1;
         this.avatarRequest.reset();
         this.playMotion(this.currAvatarR.motionType,_loc2_);
         this.updateHeadPos();
      }
      
      public function getDirection() : int
      {
         return this.direction;
      }
      
      public function getMotionType() : int
      {
         return this.currAvatarR.motionType;
      }
      
      public function playMotion(param1:int, param2:int) : void
      {
         param1 = 0;
         var _loc3_:Boolean = false;
         if(this.currAvatarR.motionType != param1)
         {
            _loc3_ = true;
            body.setYOffsets(null);
            this.findAvatar(param1);
            this.motionEvent.data = param1;
            dispatchEvent(this.motionEvent);
         }
         if(_loc3_ || this.direction != param2)
         {
            this.direction = param2;
            if(body != null && currentAvatar != null && currentAvatar.frames != null)
            {
               body.playFrames(currentAvatar.frames[param2]);
            }
         }
      }
      
      public function wearAvatar(param1:String, param2:uint, param3:int, param4:int) : void
      {
         if(this.currAvatarR.avatarURL == param1 && this.currAvatarR.avatarVersion == param3)
         {
            return;
         }
         if(!this.avatarRequest.isNull())
         {
            this.resAdapter.cancelRequest(this.avatarRequest);
         }
         this.avatarRequest.avatarType = param2;
         this.avatarRequest.avatarURL = param1;
         this.avatarRequest.avatarVersion = param3;
         this.avatarRequest.motionType = param4;
         var _loc5_:Avatar;
         if((_loc5_ = this.resAdapter.requestRes(this.avatarRequest) as Avatar) != null)
         {
            this.onGotAvatarHandler(_loc5_);
         }
      }
      
      public function useTimerSelf() : Boolean
      {
         return false;
      }
      
      override public function onRender(param1:Event) : void
      {
         if(this.hasAvatar)
         {
            super.onRender(param1);
         }
      }
      
      public function reset() : void
      {
         if(!this.avatarRequest.isNull())
         {
            this.resAdapter.cancelRequest(this.avatarRequest);
            this.resAdapter.disposeRes(currentAvatar,true);
         }
         else
         {
            this.resAdapter.disposeRes(currentAvatar,false,"unload");
         }
         if(this.currAvatarR != null)
         {
            this.currAvatarR.reset(true);
         }
         if(this.avatarRequest != null)
         {
            this.avatarRequest.reset(true);
         }
         if(body != null)
         {
            body.dispose();
         }
         if(bubble != null)
         {
            bubble.setContent(null);
         }
         currentAvatar = null;
      }
      
      override public function unload() : void
      {
         super.unload();
         this.motionEvent = null;
         this.hasAvatar = false;
         this.reset();
      }
   }
}
