package com.QQ.angel.world.res
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.world.role.RoleMotion;
   import com.QQ.angel.data.entity.GotAvatarImgDes;
   import com.QQ.angel.res.AvatarRequest;
   import com.QQ.angel.world.render.MotionFCS;
   import com.QQ.angel.world.vo.Avatar;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   
   public class MountResAdapter extends BaseAvatarResAdapter
   {
      
      protected static var MOUNT_WIDTH:int = 200;
      
      protected static var MOUNT_HEIGHT:int = 200;
      
      public function MountResAdapter()
      {
         super();
         resType = Constants.MOUNT_RES;
      }
      
      override protected function onAvatarLoaded(param1:LoadTaskEvent, param2:Boolean = false) : void
      {
         var _loc3_:ApplicationDomain = param1.resData.domain;
         var _loc4_:Object = param1.resData.content;
         var _loc5_:uint = currentLoadArgs.avatarType;
         var _loc6_:uint = uint(currentLoadArgs.avatarVersion);
         var _loc7_:Class = _loc3_.getDefinition("Assets_1") as Class;
         var _loc8_:Class = _loc3_.getDefinition("Assets_2") as Class;
         var _loc9_:BitmapData = new _loc7_(10 * MOUNT_WIDTH,2 * MOUNT_HEIGHT) as BitmapData;
         var _loc10_:BitmapData = new BitmapData(2 * MOUNT_WIDTH,2 * MOUNT_HEIGHT);
         _loc10_.copyPixels(_loc9_,new Rectangle(0,0,2 * MOUNT_WIDTH,2 * MOUNT_HEIGHT),new Point(0,0));
         var _loc11_:BitmapData = new BitmapData(4 * MOUNT_WIDTH,2 * MOUNT_HEIGHT);
         _loc11_.copyPixels(_loc9_,new Rectangle(2 * MOUNT_WIDTH,0,4 * MOUNT_WIDTH,2 * MOUNT_HEIGHT),new Point(0,0));
         var _loc12_:BitmapData = new BitmapData(4 * MOUNT_WIDTH,2 * MOUNT_HEIGHT);
         _loc12_.copyPixels(_loc9_,new Rectangle(6 * MOUNT_WIDTH,0,4 * MOUNT_WIDTH,2 * MOUNT_HEIGHT),new Point(0,0));
         pools.addNewTypeAvatar(_loc3_,_loc5_,1,param2,[_loc10_,_loc11_,_loc12_]);
         var _loc13_:BitmapData = new _loc8_(10 * MOUNT_WIDTH,2 * MOUNT_HEIGHT) as BitmapData;
         var _loc14_:BitmapData = new BitmapData(2 * MOUNT_WIDTH,2 * MOUNT_HEIGHT);
         _loc14_.copyPixels(_loc13_,new Rectangle(0,0,2 * MOUNT_WIDTH,2 * MOUNT_HEIGHT),new Point(0,0));
         var _loc15_:BitmapData = new BitmapData(4 * MOUNT_WIDTH,2 * MOUNT_HEIGHT);
         _loc15_.copyPixels(_loc13_,new Rectangle(2 * MOUNT_WIDTH,0,4 * MOUNT_WIDTH,2 * MOUNT_HEIGHT),new Point(0,0));
         var _loc16_:BitmapData = new BitmapData(4 * MOUNT_WIDTH,2 * MOUNT_HEIGHT);
         _loc16_.copyPixels(_loc13_,new Rectangle(6 * MOUNT_WIDTH,0,4 * MOUNT_WIDTH,2 * MOUNT_HEIGHT),new Point(0,0));
         pools.addNewTypeAvatar(_loc3_,_loc5_,2,param2,[_loc14_,_loc15_,_loc16_]);
         var _loc17_:Avatar = new Avatar();
         _loc17_.styleID = _loc5_;
         _loc17_.version = _loc6_;
         currentLoadArgs.avatarLoadedCall(_loc17_);
         currentLoadArgs.clear();
         currentLoadArgs = null;
         loadAvatar();
      }
      
      override public function requestRes(... rest) : Object
      {
         var _loc4_:GotAvatarImgDes = null;
         if(rest[0] is GotAvatarImgDes)
         {
            _loc4_ = rest[0];
            return pools.getCustomAvatarImg(_loc4_.uin,_loc4_.avatarVer,_loc4_.motionType);
         }
         var _loc2_:AvatarRequest = rest[0];
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:Avatar = pools.borrowAvatar(_loc2_.avatarType,_loc2_.avatarVersion,_loc2_.motionType,false);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         _loc2_.taskID = 1;
         loadAvatar(_loc2_);
         return null;
      }
      
      override public function initialize(... rest) : void
      {
         super.initialize();
         this.pools = new AvatarCachePools();
         var _loc2_:Dictionary = new Dictionary();
         _loc2_[RoleMotion.STAND] = new MotionFCS(RoleMotion.STAND,[12,12]);
         _loc2_[RoleMotion.FLOAT] = new MotionFCS(RoleMotion.FLOAT,[3,3,3,3]);
         _loc2_[RoleMotion.WALK] = new MotionFCS(RoleMotion.WALK,[2,2,2,2]);
         this.pools.mfDefined = _loc2_;
      }
      
      override protected function getAvatarURL(param1:AvatarRequest) : String
      {
         return DEFINE.DAZZLE_MOUNT_RES_ROOT + param1.avatarType + ".swf";
      }
   }
}

