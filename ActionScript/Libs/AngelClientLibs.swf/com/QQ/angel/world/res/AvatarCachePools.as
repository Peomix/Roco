package com.QQ.angel.world.res
{
   import com.QQ.angel.world.vo.Avatar;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   
   public class AvatarCachePools
   {
      
      public var mfDefined:Dictionary;
      
      public var mfDazzleDefined:Dictionary;
      
      protected var items:Dictionary;
      
      protected var itemCls:Class;
      
      public function AvatarCachePools(param1:Class = null)
      {
         super();
         this.items = new Dictionary();
         this.itemCls = param1 == null ? AvatarCacheItem : param1;
      }
      
      protected function findItem(param1:uint, param2:int) : AvatarCacheItem
      {
         var _loc3_:String = param1 + "?" + param2;
         return this.items[_loc3_];
      }
      
      protected function onItemRemoved(param1:Event) : void
      {
         this.removeNewTypeAvatar(0,-1,param1.target as AvatarCacheItem);
      }
      
      public function addNewTypeAvatar(param1:ApplicationDomain, param2:uint, param3:int, param4:Boolean = false, param5:Array = null, param6:Array = null) : void
      {
         var _loc7_:String = param2 + "?" + param3;
         if(this.items[_loc7_] != null)
         {
            throw new Error("居然已经存在一个AVATAR缓存:" + _loc7_);
         }
         var _loc8_:AvatarCacheItem = new this.itemCls(param2,param3,10000,param4) as AvatarCacheItem;
         if(!param1.hasDefinition("Assets_5") && this.mfDazzleDefined != null)
         {
            _loc8_.setMFrameDefined(this.mfDazzleDefined);
         }
         else
         {
            _loc8_.setMFrameDefined(this.mfDefined);
         }
         _loc8_.setDomain(param1,param5,param6);
         this.items[_loc7_] = _loc8_;
         _loc8_.addEventListener(Event.REMOVED,this.onItemRemoved);
      }
      
      public function removeNewTypeAvatar(param1:uint, param2:int, param3:AvatarCacheItem = null) : void
      {
         var _loc4_:String = null;
         if(param3 == null && param2 != -1)
         {
            _loc4_ == param1 + "?" + param2;
            param3 = this.items[_loc4_];
         }
         else
         {
            _loc4_ = param3.styleID + "?" + param3.version;
         }
         if(param3 == null || param3.isStatic)
         {
            return;
         }
         param3.removeEventListener(Event.REMOVED,this.onItemRemoved);
         param3.dispose();
         delete this.items[_loc4_];
         trace("[AvatarCachePools] ######从内存中彻底清除:",_loc4_);
      }
      
      public function borrowAvatar(param1:uint, param2:int, param3:int, param4:Boolean = true) : Avatar
      {
         var _loc5_:AvatarCacheItem = this.findItem(param1,param2);
         if(_loc5_ == null)
         {
            return null;
         }
         return _loc5_.borrow(param3,param4);
      }
      
      public function giveBackAvatar(param1:Avatar, param2:Boolean = false) : void
      {
         var _loc3_:AvatarCacheItem = this.findItem(param1.styleID,param1.version);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.giveBack(param1,param2);
      }
      
      public function getCustomAvatarImg(param1:uint, param2:int, param3:int) : BitmapData
      {
         var _loc4_:AvatarCacheItem = this.findItem(param1,param2);
         if(_loc4_ == null)
         {
            return null;
         }
         return _loc4_.getAvatarImg(param3);
      }
   }
}

