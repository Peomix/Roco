package com.QQ.angel.world.res
{
   import flash.system.ApplicationDomain;
   
   public class SpiritAvatarCacheItem extends AvatarCacheItem
   {
       
      
      public function SpiritAvatarCacheItem(param1:int, param2:int, param3:int = 10000, param4:Boolean = false)
      {
         super(param1,param2,15000,param4);
      }
      
      override public function setDomain(param1:ApplicationDomain, param2:Array = null, param3:Array = null) : void
      {
         super.setDomain(param1,param2);
         if(param3 != null)
         {
            avatarAssets_WH = param3;
         }
      }
   }
}
