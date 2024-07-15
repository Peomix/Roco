package com.QQ.angel.res
{
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.res.ResData;
   import com.QQ.angel.api.res.ResLoadTask;
   import com.QQ.angel.utils.AString;
   import flash.display.Bitmap;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   
   public class ResVIPChannel extends EventDispatcher implements IResChannel
   {
      
      public static const channelType:String = ResChannelType.VIP;
       
      
      private var _manager:IResLoadTaskManagerHandler;
      
      private var _resLoaderType:int;
      
      private var _resLoader:IResLoader;
      
      private var _tasks:Array;
      
      private var _currentTask:ResLoadTask;
      
      private var _taskItemIdx:int;
      
      private var _resData:ResData;
      
      private var _state:int;
      
      public function ResVIPChannel(param1:IResLoadTaskManagerHandler = null, param2:IResLoader = null)
      {
         super();
         this._manager = param1;
         this._resLoaderType = param2.type;
         this._resLoader = param2;
         this._tasks = [];
         this._currentTask = null;
         this._taskItemIdx = 0;
         this._resData = null;
         this._state = ResChannelState.READY;
         this.registerLoader();
         if(this._resLoader == null)
         {
            throw new Error("[ResVIPChannel] IResLoader为空!!");
         }
      }
      
      public function addTask(param1:ResLoadTask) : int
      {
         if(param1 == null)
         {
            return -1;
         }
         this._tasks.push(param1);
         return param1.taskID;
      }
      
      public function delTask(param1:ResLoadTask) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:ResLoadTask = null;
         if(param1 == null)
         {
            return false;
         }
         if(param1 == this._currentTask)
         {
            this._currentTask = null;
            if(this._state == ResChannelState.RUNNING)
            {
               this.cancelLoadingTask();
            }
            this._taskItemIdx = 0;
            this._state = ResChannelState.READY;
            this.start();
            return true;
         }
         _loc2_ = int(this._tasks.length);
         _loc3_ = false;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            if((_loc5_ = this._tasks[_loc4_]) == param1)
            {
               this._tasks.splice(_loc4_,1);
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function isEmpty() : Boolean
      {
         return this._currentTask == null && this._tasks.length == 0;
      }
      
      public function isReady() : Boolean
      {
         return this._currentTask != null && this._state == ResChannelState.READY;
      }
      
      public function isRunning() : Boolean
      {
         return this._currentTask != null && this._state == ResChannelState.RUNNING;
      }
      
      public function isPaused() : Boolean
      {
         return this._state == ResChannelState.PAUSED;
      }
      
      public function start() : void
      {
         switch(this._state)
         {
            case ResChannelState.EMPTY:
            case ResChannelState.RUNNING:
               break;
            case ResChannelState.PAUSED:
               this.resume();
               break;
            case ResChannelState.READY:
               this.loadTask();
         }
      }
      
      public function pause() : void
      {
         this._state = ResChannelState.PAUSED;
      }
      
      public function resume() : void
      {
         if(this.isPaused())
         {
            this.loadTask();
         }
      }
      
      public function clear() : void
      {
         if(this._currentTask != null)
         {
            this.cancelLoadingTask();
         }
         this._tasks = [];
         this._currentTask = null;
         this._taskItemIdx = 0;
         this._resData = null;
         this._state = ResChannelState.READY;
      }
      
      public function cancelLoadingTask() : void
      {
         try
         {
            if(this._resLoader.getURL() != null)
            {
               this._resLoader.close();
            }
         }
         catch(e:Error)
         {
         }
         this._resLoader.unload();
      }
      
      public function getCurrentTask() : ResLoadTask
      {
         return this._currentTask;
      }
      
      public function getNextTaskPriority() : String
      {
         if(this._currentTask != null && this._tasks.length > 0)
         {
            return (this._tasks[0] as ResLoadTask).priority;
         }
         return null;
      }
      
      public function pauseNextTask() : void
      {
         if(this._currentTask != null && this._taskItemIdx < this._currentTask.paths.length - 1)
         {
            ++this._taskItemIdx;
            this.pause();
         }
         else
         {
            this._currentTask = null;
            this._taskItemIdx = 0;
            this.pause();
         }
      }
      
      public function startNextTask() : void
      {
         if(this._currentTask != null && this._taskItemIdx < this._currentTask.paths.length - 1)
         {
            ++this._taskItemIdx;
            this.loadSubTask();
         }
         else
         {
            this._currentTask = null;
            this._taskItemIdx = 0;
            this.loadTask();
         }
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      private function registerLoader() : void
      {
         this._resLoader.getED().addEventListener(ProgressEvent.PROGRESS,this.onLoaderProgress);
         this._resLoader.getED().addEventListener(Event.OPEN,this.onLoaderOpen);
         this._resLoader.getED().addEventListener(IOErrorEvent.IO_ERROR,this.onLoaderError);
         this._resLoader.getED().addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoaderError);
         this._resLoader.getED().addEventListener(Event.COMPLETE,this.onLoaderComplete);
      }
      
      private function unregisterLoader() : void
      {
         this._resLoader.getED().removeEventListener(ProgressEvent.PROGRESS,this.onLoaderProgress);
         this._resLoader.getED().removeEventListener(Event.OPEN,this.onLoaderOpen);
         this._resLoader.getED().removeEventListener(IOErrorEvent.IO_ERROR,this.onLoaderError);
         this._resLoader.getED().removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoaderError);
         this._resLoader.getED().removeEventListener(Event.COMPLETE,this.onLoaderComplete);
      }
      
      private function loadTask() : void
      {
         if(this.isEmpty())
         {
            this._state = ResChannelState.READY;
            return;
         }
         if(this._currentTask == null)
         {
            this._currentTask = this._tasks.shift() as ResLoadTask;
            this._taskItemIdx = 0;
            this._resData = null;
            this._state = ResChannelState.RUNNING;
            this.loadSubTask();
            return;
         }
      }
      
      private function loadSubTask() : void
      {
         var _loc2_:Object = null;
         var _loc1_:String = "";
         if(this._currentTask != null)
         {
            _loc2_ = this._currentTask.paths[this._taskItemIdx];
            if(_loc2_ is String)
            {
               _loc1_ = _loc2_ as String;
            }
            else if(_loc2_ != null && _loc2_.hasOwnProperty("url"))
            {
               _loc1_ = _loc2_["url"] as String;
            }
         }
         this._resData = new ResData();
         this._resData.obj = _loc2_;
         this._resLoader.load(new URLRequest(_loc1_),this._currentTask.context);
      }
      
      private function onLoaderProgress(param1:ProgressEvent) : void
      {
         var _loc2_:LoadTaskEvent = null;
         if(this._currentTask == null)
         {
            return;
         }
         if(this._currentTask.progressHandler != null)
         {
            _loc2_ = new LoadTaskEvent(LoadTaskEvent.TASK_PROGRESS);
            this._resData.itemsLoaded = this._taskItemIdx;
            this._resData.itemsTotal = this._currentTask.paths.length;
            this._resData.bytesLoaded = param1.bytesLoaded;
            this._resData.bytesTotal = param1.bytesTotal;
            this._resData.content = this._resLoader.getContent();
            _loc2_.data = this._resData;
            _loc2_.taskID = this._currentTask.taskID;
            this._currentTask.progressHandler.call(_loc2_);
         }
         if(this._manager != null)
         {
            this._manager.onTaskProgress(this,param1);
         }
      }
      
      private function onLoaderOpen(param1:Event) : void
      {
         var _loc2_:LoadTaskEvent = null;
         if(this._currentTask == null)
         {
            return;
         }
         if(this._currentTask.openHandler != null)
         {
            _loc2_ = new LoadTaskEvent(LoadTaskEvent.TASK_BEGIN);
            this._resData.content = this._resLoader.getContent();
            _loc2_.data = this._resData;
            _loc2_.taskID = this._currentTask.taskID;
            this._currentTask.openHandler.call(_loc2_);
         }
         if(this._manager != null)
         {
            this._manager.onTaskOpen(this,param1);
         }
      }
      
      private function onLoaderError(param1:ErrorEvent) : void
      {
         var _loc2_:LoadTaskEvent = null;
         if(param1 is SecurityErrorEvent)
         {
            trace("##################### VIPLoader捕捉到的异常:" + param1.text);
         }
         if(this._currentTask == null)
         {
            return;
         }
         if(this._currentTask.errorHandler != null)
         {
            _loc2_ = new LoadTaskEvent(LoadTaskEvent.TASK_ERROR);
            _loc2_.message = param1.text;
            _loc2_.taskID = this._currentTask.taskID;
            this._currentTask.errorHandler.call(_loc2_);
         }
         if(this._currentTask != null && this._taskItemIdx < this._currentTask.paths.length - 1)
         {
            if(this._manager != null)
            {
               this._manager.onTaskError(this,param1);
            }
         }
         else
         {
            if(this._currentTask != null && this._currentTask.allCompleteHandler != null)
            {
               _loc2_ = new LoadTaskEvent(LoadTaskEvent.TASK_COMPLETE);
               this._resData.content = this._resLoader.getContent();
               _loc2_.data = this._resData;
               _loc2_.taskID = this._currentTask.taskID;
               this._currentTask.allCompleteHandler.call(_loc2_);
            }
            if(this._manager != null)
            {
               this._manager.onTaskError(this,param1);
               this._manager.onTasksAllComplete(this,param1);
            }
         }
      }
      
      private function isNotCurrentURL() : Boolean
      {
         var _loc4_:Bitmap = null;
         var _loc1_:String = this._currentTask.paths[this._taskItemIdx];
         var _loc2_:String = this._resLoader.getURL();
         var _loc3_:String = AString.getFileName(_loc1_);
         if(_loc2_ == null || _loc2_.indexOf(_loc3_) == -1)
         {
            if((_loc4_ = this._resLoader.getContent() as Bitmap) != null && _loc4_.bitmapData != null)
            {
               _loc4_.bitmapData.dispose();
            }
            _loc4_ = null;
            this._resLoader.unload();
            this.loadSubTask();
            return true;
         }
         return false;
      }
      
      private function onLoaderComplete(param1:Event) : void
      {
         if(this._currentTask == null)
         {
            return;
         }
         var _loc2_:LoadTaskEvent = new LoadTaskEvent(LoadTaskEvent.TASK_COMPLETE);
         this._resData.content = this._resLoader.getContent();
         this._resData.domain = this._resLoader.getContentDomain();
         _loc2_.data = this._resData;
         _loc2_.taskID = this._currentTask.taskID;
         this._resLoader.unload();
         this._resData = null;
         if(this._taskItemIdx < this._currentTask.paths.length - 1)
         {
            if(this._currentTask.completeHandler != null)
            {
               this._currentTask.completeHandler.call(_loc2_);
            }
            if(this._manager != null)
            {
               this._manager.onTaskComplete(this,param1);
            }
         }
         else
         {
            if(this._currentTask.completeHandler != null)
            {
               this._currentTask.completeHandler.call(_loc2_);
            }
            if(this._currentTask.allCompleteHandler != null)
            {
               this._currentTask.allCompleteHandler.call(_loc2_);
            }
            if(this._manager != null)
            {
               this._manager.onTaskComplete(this,param1);
               this._manager.onTasksAllComplete(this,param1);
            }
         }
      }
   }
}
