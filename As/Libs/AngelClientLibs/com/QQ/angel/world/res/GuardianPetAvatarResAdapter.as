package com.QQ.angel.world.res
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.world.role.RoleMotion;
   import com.QQ.angel.res.AvatarRequest;
   import com.QQ.angel.world.render.MotionFCS;
   import com.QQ.angel.world.vo.Avatar;
   import flash.utils.Dictionary;
   
   public class GuardianPetAvatarResAdapter extends BaseAvatarResAdapter
   {
       
      
      public function GuardianPetAvatarResAdapter()
      {
         super();
         resType = Constants.GUARDIANPET_RES;
      }
      
      override public function initialize(... rest) : void
      {
         super.initialize();
         var _loc2_:Dictionary = new Dictionary();
         _loc2_[RoleMotion.STAND] = new MotionFCS(RoleMotion.STAND,[4,5]);
         _loc2_[RoleMotion.FLOAT] = new MotionFCS(RoleMotion.FLOAT,[4,4,3],null,[0,1,0]);
         _loc2_[RoleMotion.WALK] = new MotionFCS(RoleMotion.WALK,[1,2,1,2]);
         this.pools = new AvatarCachePools(SpiritAvatarCacheItem);
         this.pools.mfDefined = _loc2_;
      }
      
      override public function requestRes(... rest) : Object
      {
         var _loc2_:AvatarRequest = rest[0];
         if(_loc2_ == null)
         {
            return null;
         }
         if(_loc2_.avatarType == 0)
         {
            return null;
         }
         var _loc3_:Avatar = pools.borrowAvatar(_loc2_.avatarType,_loc2_.avatarVersion,_loc2_.motionType);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         loadAvatar(_loc2_);
         return null;
      }
      
      override protected function getAvatarURL(param1:AvatarRequest) : String
      {
         return param1.avatarURL;
      }
   }
}
