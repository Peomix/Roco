package com.QQ.angel.world.res
{
   import com.QQ.angel.world.render.BDFrame;
   import com.QQ.angel.world.vo.Avatar;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class AvatarCacheItem extends EventDispatcher
   {
      
      public static const defMotionDBs_WH:Array = [[200,200],[400,200],[300,200],[300,200],[100,200],[300,200]];
      
      public static const defMotionDazzleDBs_WH:Array = [[300,300],[600,300],[300,300],[600,300],[300,300]];
      
      public var styleID:uint;
      
      public var version:int;
      
      protected var avatarAssets:Array;
      
      protected var avatarAssets_WH:Array = defMotionDBs_WH;
      
      protected var dazzleAssets_WH:Array = defMotionDazzleDBs_WH;
      
      protected var domain:ApplicationDomain;
      
      protected var motionAvatars:Array;
      
      protected var counts:int = 0;
      
      protected var cacheTimer:Timer;
      
      protected var size:int = 6;
      
      protected var cacheTime:int;
      
      protected var timeUpVal:int;
      
      protected var mtFramesCounts:Dictionary;
      
      public var isStatic:Boolean = false;
      
      private const mtChanger:Array = [4,3,1,2,-1,0];
      
      public function AvatarCacheItem(param1:uint, param2:int, param3:int = 15000, param4:Boolean = false)
      {
         super();
         this.styleID = param1;
         this.version = param2;
         this.cacheTime = param3;
         this.isStatic = param4;
         this.motionAvatars = new Array(this.size);
         if(param4 == false)
         {
            this.cacheTimer = new Timer(param3);
            this.cacheTimer.addEventListener(TimerEvent.TIMER,this.onCacheTimer);
            this.cacheTime = param3 - 500;
         }
      }
      
      protected function onCacheTimer(param1:TimerEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:Avatar = null;
         var _loc2_:int = getTimer();
         if(this.counts > 0)
         {
            _loc3_ = true;
            _loc4_ = 0;
            while(_loc4_ < this.size)
            {
               _loc5_ = this.motionAvatars[_loc4_];
               if(_loc5_ != null && _loc5_.useCounts == 0)
               {
                  if(_loc2_ - _loc5_.timer >= this.cacheTime)
                  {
                     this.disposeAvatar(_loc5_);
                  }
                  else
                  {
                     _loc3_ = false;
                  }
               }
               _loc4_++;
            }
            if(_loc3_)
            {
               this.cacheTimer.stop();
            }
         }
         else if(_loc2_ >= this.timeUpVal)
         {
            this.cacheTimer.stop();
            dispatchEvent(new Event(Event.REMOVED));
         }
      }
      
      protected function disposeAvatar(param1:Avatar) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:BDFrame = null;
         if(param1 == null)
         {
            return;
         }
         this.motionAvatars[param1.motionType] = null;
         --this.counts;
         var _loc2_:int = int(param1.frames.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.frames[_loc3_];
            _loc5_ = int(_loc4_.length);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc7_ = _loc4_[_loc6_] as BDFrame;
               _loc7_.img.dispose();
               _loc7_.img = null;
               _loc4_[_loc6_] = null;
               _loc6_++;
            }
            _loc3_++;
         }
      }
      
      protected function clearAvatars() : Boolean
      {
         var _loc3_:Avatar = null;
         if(this.counts == 0)
         {
            return true;
         }
         var _loc1_:Boolean = true;
         var _loc2_:int = 0;
         while(_loc2_ < this.size)
         {
            _loc3_ = this.motionAvatars[_loc2_];
            if(_loc3_ != null)
            {
               if(_loc3_.useCounts != 0)
               {
                  _loc1_ = false;
               }
               else
               {
                  this.disposeAvatar(_loc3_);
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      protected function createAvatar(param1:int, param2:Boolean) : Avatar
      {
         var _loc3_:BitmapData = this.getAvatarImg(param1);
         var _loc4_:Avatar = AvatarAssetProcess.processToAvatar(_loc3_,param1,this.mtFramesCounts,param2);
         _loc4_.styleID = this.styleID;
         _loc4_.version = this.version;
         _loc4_.useCounts = 1;
         this.motionAvatars[param1] = _loc4_;
         ++this.counts;
         return _loc4_;
      }
      
      public function setDomain(param1:ApplicationDomain, param2:Array = null, param3:Array = null) : void
      {
         var _loc5_:String = null;
         this.domain = param1;
         if(param2 != null && (param2.length == 6 || param2.length == 3))
         {
            this.avatarAssets = param2;
            return;
         }
         this.avatarAssets = new Array(this.size);
         var _loc4_:int = 0;
         while(_loc4_ < this.size)
         {
            _loc5_ = "Assets_" + _loc4_;
            if(param1.hasDefinition(_loc5_))
            {
               this.avatarAssets[_loc4_] = param1.getDefinition(_loc5_);
            }
            _loc4_++;
         }
      }
      
      public function setMFrameDefined(param1:Dictionary) : void
      {
         this.mtFramesCounts = param1;
      }
      
      public function getAvatarImg(param1:int) : BitmapData
      {
         var _loc2_:Array = this.avatarAssets_WH[param1];
         if(this.avatarAssets[5] == null && this.avatarAssets[4] != null)
         {
            param1 = int(this.mtChanger[param1]);
            _loc2_ = this.dazzleAssets_WH[param1];
         }
         if(this.avatarAssets[param1] is BitmapData)
         {
            return (this.avatarAssets[param1] as BitmapData).clone();
         }
         var _loc3_:Class = this.avatarAssets[param1];
         if(_loc3_ == null)
         {
            return null;
         }
         return new _loc3_(_loc2_[0],_loc2_[1]) as BitmapData;
      }
      
      public function borrow(param1:int, param2:Boolean) : Avatar
      {
         var _loc3_:Avatar = this.motionAvatars[param1];
         if(_loc3_ != null)
         {
            _loc3_.useCounts += 1;
            return _loc3_;
         }
         return this.createAvatar(param1,param2);
      }
      
      public function giveBack(param1:Avatar, param2:Boolean = false) : void
      {
         --param1.useCounts;
         if(this.isStatic)
         {
            return;
         }
         if(param2)
         {
            if(!this.clearAvatars())
            {
               return;
            }
            this.timeUpVal = getTimer() + 12 * this.cacheTime;
         }
         else
         {
            if(param1.useCounts > 0)
            {
               return;
            }
            param1.timer = getTimer();
         }
         if(!this.cacheTimer.running)
         {
            this.cacheTimer.start();
         }
      }
      
      public function dispose() : void
      {
         this.cacheTimer.stop();
         this.cacheTimer.removeEventListener(TimerEvent.TIMER,this.onCacheTimer);
         this.clearAvatars();
         this.cacheTimer = null;
         this.avatarAssets = null;
         this.avatarAssets_WH = null;
         this.mtFramesCounts = null;
         this.motionAvatars = null;
         this.domain = null;
      }
   }
}

