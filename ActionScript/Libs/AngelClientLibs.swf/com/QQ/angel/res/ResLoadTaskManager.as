package com.QQ.angel.res
{
   import com.QQ.angel.api.res.IResLoadTaskManager;
   import com.QQ.angel.api.res.ResLoadPriority;
   import com.QQ.angel.api.res.ResLoadTask;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.utils.Dictionary;
   
   public class ResLoadTaskManager implements IResLoadTaskManager, IResLoadTaskManagerHandler
   {
      
      public static const RES_MAX:int = 1000;
      
      private static var _taskID:int = 0;
      
      private var _tasksDict:Dictionary;
      
      private var _channelNum:int;
      
      private var _normalChannel:ResNormalChannel;
      
      public function ResLoadTaskManager()
      {
         super();
         this._tasksDict = new Dictionary();
         this._channelNum = 0;
         this._normalChannel = this.createChannel(ResChannelType.NORMAL) as ResNormalChannel;
      }
      
      public function addLoadTask(param1:ResLoadTask) : int
      {
         param1.taskID = ++_taskID;
         var _loc2_:IResChannel = this._tasksDict[param1.resType] as IResChannel;
         if(_loc2_ == null)
         {
            _loc2_ = this._normalChannel;
            param1.resType = ResChannelType.NORMAL;
         }
         _loc2_.addTask(param1);
         this.startChannel(_loc2_);
         return _taskID;
      }
      
      public function delLoadTask(param1:ResLoadTask) : Boolean
      {
         var _loc2_:IResChannel = this._tasksDict[param1.resType] as IResChannel;
         if(_loc2_ != null)
         {
            return _loc2_.delTask(param1);
         }
         return false;
      }
      
      public function stopAndDelTask(param1:String = "") : void
      {
      }
      
      public function createVipChannel(param1:String) : Boolean
      {
         if(!this.hasVipChannel(param1) && this._channelNum < RES_MAX)
         {
            this.createChannel(param1);
            return true;
         }
         return false;
      }
      
      public function hasVipChannel(param1:String = null) : Boolean
      {
         var _loc2_:IResChannel = null;
         var _loc3_:String = null;
         if(param1 == null)
         {
            for(_loc3_ in this._tasksDict)
            {
               _loc2_ = this._tasksDict[_loc3_] as IResChannel;
               if(_loc2_ != null && _loc2_ != this._normalChannel)
               {
                  return true;
               }
            }
            return false;
         }
         return this._tasksDict[param1] != null && this._tasksDict[param1] != this._normalChannel;
      }
      
      private function hasVipRunningTask() : Boolean
      {
         var _loc1_:IResChannel = null;
         var _loc2_:String = null;
         for(_loc2_ in this._tasksDict)
         {
            _loc1_ = this._tasksDict[_loc2_] as IResChannel;
            if(_loc1_ != null && _loc1_ != this._normalChannel)
            {
               if(_loc1_.isRunning())
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function removeVipChannel(param1:String) : Boolean
      {
         var _loc2_:IResChannel = this._tasksDict[param1] as IResChannel;
         if(_loc2_ != null && _loc2_ != this._normalChannel)
         {
            _loc2_.clear();
            delete this._tasksDict[param1];
            _loc2_ = null;
            return true;
         }
         return false;
      }
      
      public function getVipChannelsList() : Array
      {
         var _loc2_:IResChannel = null;
         var _loc3_:String = null;
         var _loc1_:Array = [];
         for(_loc3_ in this._tasksDict)
         {
            _loc2_ = this._tasksDict[_loc3_] as IResChannel;
            if(_loc2_ != null && _loc2_ != this._normalChannel)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function hasRunningVipChannel() : Boolean
      {
         var _loc1_:IResChannel = null;
         var _loc2_:Array = this.getVipChannelsList();
         var _loc3_:int = int(_loc2_.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = _loc2_[_loc4_] as ResVIPChannel;
            if(_loc1_.isRunning())
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      private function startChannel(param1:IResChannel = null) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:IResChannel = null;
         var _loc5_:int = 0;
         if(param1 == null)
         {
            _loc2_ = this.getVipChannelsList();
            _loc3_ = int(_loc2_.length);
            if(_loc3_ > 0)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc3_)
               {
                  _loc4_ = _loc2_[_loc5_] as ResVIPChannel;
                  _loc4_.start();
                  _loc5_++;
               }
               if(this._normalChannel.hasHighPriorityTask())
               {
                  this._normalChannel.start();
               }
               else
               {
                  this._normalChannel.pause();
               }
            }
            else
            {
               this._normalChannel.start();
            }
         }
         else if(param1 != this._normalChannel)
         {
            param1.start();
         }
         else if(!this.hasVipRunningTask())
         {
            this._normalChannel.start();
         }
         else if(this._normalChannel.hasHighPriorityTask())
         {
            this._normalChannel.start();
         }
         else
         {
            this._normalChannel.pause();
         }
      }
      
      public function clear(param1:String = "") : void
      {
         var _loc2_:IResChannel = null;
         var _loc3_:String = null;
         if(param1 == "")
         {
            for(_loc3_ in this._tasksDict)
            {
               _loc2_ = this._tasksDict[_loc3_] as IResChannel;
               if(_loc2_ != null)
               {
                  _loc2_.clear();
               }
            }
         }
         else
         {
            _loc2_ = this._tasksDict[param1] as IResChannel;
            if(_loc2_ != null)
            {
               _loc2_.clear();
            }
         }
      }
      
      private function createChannel(param1:String) : IResChannel
      {
         var _loc2_:IResChannel = null;
         if(param1 != ResChannelType.NORMAL)
         {
            _loc2_ = new ResVIPChannel(this,new NormalLoader());
         }
         else
         {
            _loc2_ = new ResNormalChannel(this);
         }
         this._tasksDict[param1] = _loc2_;
         ++this._channelNum;
         return _loc2_;
      }
      
      public function onTaskProgress(param1:*, param2:ProgressEvent) : void
      {
      }
      
      public function onTaskOpen(param1:*, param2:Event) : void
      {
      }
      
      public function onTaskError(param1:*, param2:ErrorEvent) : void
      {
         if(param1 == this._normalChannel)
         {
            if(param1.getNextTaskPriority() != ResLoadPriority.HIGH && this.hasRunningVipChannel())
            {
               param1.pauseNextTask();
            }
            else
            {
               param1.startNextTask();
            }
         }
         else
         {
            param1.startNextTask();
         }
      }
      
      public function onTaskComplete(param1:*, param2:Event) : void
      {
         if(param1 == this._normalChannel)
         {
            if(param1.getNextTaskPriority() != ResLoadPriority.HIGH && this.hasRunningVipChannel())
            {
               param1.pauseNextTask();
            }
            else
            {
               param1.startNextTask();
            }
         }
         else
         {
            param1.startNextTask();
         }
      }
      
      public function onTasksAllComplete(param1:*, param2:Event) : void
      {
         if(param1 != this._normalChannel)
         {
            if(!this.hasRunningVipChannel() && this._normalChannel.isPaused())
            {
               this._normalChannel.resume();
            }
         }
      }
   }
}

