package com.QQ.angel.world.res
{
   import com.QQ.angel.api.net.DEFINE;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.system.ApplicationDomain;
   import flash.utils.getQualifiedClassName;
   
   public class RoleFootprintResRequest
   {
      
      private static var loaders:Array;
      
      private static var curQueue:Array;
      
      private static var waitQueue:Array;
      
      private static var commURL:String = DEFINE.COMM_ROOT + "res/avatar/12/";
      
      private static var commURLDazzle:String = DEFINE.DAZZLE_DRESS_RES_ROOT + "26/";
      
      public static const LOADER_STATE_STOP:String = "load_stop";
      
      public static const LOADER_STATE_WAIT:String = "load_wait";
      
      public static const LOADER_STATE_RUNNING:String = "load_running";
      
      private static var MAX_LOADER_COUNT:int = 5;
      
      private static var queueNum:Number = 0;
      
      public var onCompleteHandler:Function;
      
      public var state:String = "load_stop";
      
      public var queueIndex:Number = -1;
      
      public var loadIndex:Number = -1;
      
      public var resID:int;
      
      private var m_isDazzle:Boolean;
      
      public function RoleFootprintResRequest()
      {
         super();
      }
      
      private static function runWaitQueue() : void
      {
         var _loc1_:RoleFootprintResRequest = null;
         if(waitQueue.length == 0)
         {
            return;
         }
         if(curQueue == null)
         {
            curQueue = [];
         }
         if(curQueue.length < MAX_LOADER_COUNT)
         {
            _loc1_ = waitQueue.shift();
            _loc1_.state = LOADER_STATE_RUNNING;
            curQueue.push(_loc1_);
            runLoaders();
         }
      }
      
      private static function runLoaders() : void
      {
         var _loc1_:Object = null;
         if(loaders == null)
         {
            loaders = [];
         }
         if(loaders.length < curQueue.length)
         {
            _loc1_ = {};
            _loc1_.loader = new AvatarExtraResLoader();
            _loc1_.loader.index = curQueue.length - 1;
            addEvent(_loc1_.loader);
            loaders.push(_loc1_);
         }
         var _loc2_:int = 0;
         while(_loc2_ < loaders.length)
         {
            if(loaders[_loc2_].reqTarget == null)
            {
               _loc1_ = loaders[_loc2_];
               _loc1_.reqTarget = curQueue[curQueue.length - 1];
               _loc1_.reqTarget.loadIndex = _loc1_.loader.index;
               break;
            }
            _loc2_++;
         }
         if(RoleFootprintResRequest(_loc1_.reqTarget).m_isDazzle)
         {
            _loc1_.loader.load(commURLDazzle + RoleFootprintResRequest(_loc1_.reqTarget).resID + "_scene.swf?" + DEFINE.AVATAR_VERSION);
         }
         else
         {
            _loc1_.loader.load(commURL + RoleFootprintResRequest(_loc1_.reqTarget).resID + ".swf?" + DEFINE.AVATAR_VERSION);
         }
      }
      
      private static function completeFun(param1:Event, param2:AvatarExtraResLoader) : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:Class = null;
         var _loc3_:Object = loaders[param2.index];
         var _loc4_:RoleFootprintResRequest = _loc3_.reqTarget;
         if(_loc4_ != null && _loc4_.state == LOADER_STATE_RUNNING)
         {
            _loc4_.queueIndex = -1;
            _loc4_.loadIndex = -1;
            _loc4_.state = LOADER_STATE_STOP;
            _loc5_ = param1.target.loader.content as MovieClip;
            _loc6_ = getClass(getQualifiedClassName(_loc5_.mc),_loc5_.loaderInfo.applicationDomain);
            _loc4_.onCompleteHandler(_loc6_);
            _loc3_.reqTarget = null;
            curQueue.splice(param2.index,1);
         }
         runWaitQueue();
      }
      
      public static function getClass(param1:String, param2:ApplicationDomain = null) : Class
      {
         var _loc3_:Class = null;
         if(null == param2)
         {
            param2 = ApplicationDomain.currentDomain;
         }
         try
         {
            _loc3_ = param2.getDefinition(param1) as Class;
         }
         catch(error:Error)
         {
         }
         return _loc3_;
      }
      
      private static function handleError(param1:IOErrorEvent, param2:AvatarExtraResLoader) : void
      {
         var _loc3_:Object = loaders[param2.index];
         var _loc4_:RoleFootprintResRequest = _loc3_.reqTarget;
         if(_loc4_ != null && _loc4_.state == LOADER_STATE_RUNNING)
         {
            _loc4_.queueIndex = -1;
            _loc4_.loadIndex = -1;
            _loc4_.state = LOADER_STATE_STOP;
            _loc4_.onCompleteHandler(null);
            _loc3_.reqTarget = null;
            curQueue.splice(param2.index,1);
         }
         runWaitQueue();
      }
      
      private static function addEvent(param1:AvatarExtraResLoader) : void
      {
         param1.dataHandler = completeFun;
         param1.errorHandler = handleError;
      }
      
      private static function delEvent(param1:AvatarExtraResLoader) : void
      {
         param1.dataHandler = null;
         param1.errorHandler = null;
      }
      
      public function loadByID(param1:int, param2:Boolean) : void
      {
         this.m_isDazzle = param2;
         this.resID = param1;
         if(this.state != LOADER_STATE_STOP)
         {
            this.cancle();
         }
         if(waitQueue == null)
         {
            waitQueue = [];
         }
         ++queueNum;
         this.queueIndex = queueNum;
         waitQueue.push(this);
         runWaitQueue();
      }
      
      public function cancle() : void
      {
         var _loc2_:int = 0;
         var _loc3_:RoleFootprintResRequest = null;
         var _loc1_:String = this.state;
         this.state = LOADER_STATE_STOP;
         if(_loc1_ == LOADER_STATE_WAIT)
         {
            _loc2_ = 0;
            while(_loc2_ < waitQueue.length)
            {
               if(RoleFootprintResRequest(waitQueue[_loc2_]).loadIndex == this.loadIndex)
               {
                  _loc3_ = waitQueue.splice(_loc2_,1)[0];
                  _loc3_.loadIndex = -1;
                  return;
               }
               _loc2_++;
            }
         }
         if(_loc1_ == LOADER_STATE_RUNNING)
         {
            _loc2_ = 0;
            while(_loc2_ < curQueue.length)
            {
               if(RoleFootprintResRequest(curQueue[_loc2_]).loadIndex == this.loadIndex)
               {
                  _loc3_ = curQueue.splice(_loc2_,1)[0] as RoleFootprintResRequest;
                  loaders[_loc3_.loadIndex].reqTarget = null;
                  _loc3_.loadIndex = -1;
                  _loc3_.queueIndex = -1;
                  return;
               }
               _loc2_++;
            }
         }
      }
   }
}

