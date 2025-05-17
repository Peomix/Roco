package com.QQ.angel.res.adapter
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.events.WindowEvent;
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.api.res.IResLoadTaskManager;
   import com.QQ.angel.api.res.ResData;
   import com.QQ.angel.api.res.ResLoadPriority;
   import com.QQ.angel.api.res.ResLoadTask;
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.api.ui.ILoadingView;
   import com.QQ.angel.api.ui.IWindow;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.data.entity.SysResInfo;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class AngelSystemResAdapter implements IResAdapter
   {
      
      protected var resLoadTaskManager:IResLoadTaskManager;
      
      protected var commUIManager:ICommUIManager;
      
      protected var loadTask:ResLoadTask;
      
      protected var loadResInfo:SysResInfo;
      
      protected var loadingView:ILoadingView;
      
      protected var isLoading:Boolean = false;
      
      public function AngelSystemResAdapter(param1:ICommUIManager)
      {
         super();
         this.commUIManager = param1;
         this.loadResInfo = new SysResInfo();
      }
      
      protected function onCloseWindow(param1:Event) : void
      {
         this.add_Remove_Listener(param1.target as IEventDispatcher,false);
      }
      
      protected function add_Remove_Listener(param1:IEventDispatcher, param2:Boolean = true) : void
      {
         if(param2)
         {
            param1.addEventListener(WindowEvent.CLOSED,this.onCloseWindow);
         }
         else
         {
            param1.removeEventListener(WindowEvent.CLOSED,this.onCloseWindow);
         }
      }
      
      protected function progressHandler(param1:LoadTaskEvent) : void
      {
         var _loc2_:ResData = param1.resData;
         if(this.loadingView != null)
         {
            this.loadingView.setProgress(int(_loc2_.bytesLoaded / _loc2_.bytesTotal * 100));
         }
      }
      
      protected function errorHandler(param1:LoadTaskEvent) : void
      {
         this.loadResInfo.contents.push(null);
      }
      
      protected function completedHandler(param1:LoadTaskEvent) : void
      {
         this.loadResInfo.contents.push(param1.resData.content);
      }
      
      protected function allCompleteHandler(param1:LoadTaskEvent) : void
      {
         this.isLoading = false;
         if(this.commUIManager != null && this.loadingView != null)
         {
            this.add_Remove_Listener(this.loadingView as IEventDispatcher,false);
            this.commUIManager.closeWindow(this.loadingView as IWindow);
            this.loadingView = null;
         }
         param1.resData.content = this.loadResInfo.contents;
         var _loc2_:CFunction = this.loadResInfo.callBack;
         this.loadResInfo.reset();
         this.loadTask.context = null;
         this.loadTask.paths = [];
         _loc2_.call(param1);
      }
      
      public function initialize(... rest) : void
      {
         this.loadTask = new ResLoadTask();
         this.loadTask.priority = ResLoadPriority.HIGH;
         this.loadTask.progressHandler = new CFunction(this.progressHandler,this);
         this.loadTask.completeHandler = new CFunction(this.completedHandler,this);
         this.loadTask.errorHandler = new CFunction(this.errorHandler,this);
         this.loadTask.allCompleteHandler = new CFunction(this.allCompleteHandler,this);
      }
      
      public function finalize() : void
      {
      }
      
      public function requestRes(... rest) : Object
      {
         var _loc2_:SysResInfo = null;
         if(this.isLoading)
         {
            return false;
         }
         if(rest[0] is SysResInfo)
         {
            _loc2_ = rest[0];
            if(_loc2_.callBack == null)
            {
               throw new Error("[AngelSystemResAdapter] 系统资源加载的回调不能为null!!");
            }
            this.loadTask.paths = _loc2_.contents;
            this.loadTask.context = _loc2_.context;
            this.loadResInfo.contents = [];
            this.loadResInfo.callBack = _loc2_.callBack;
            this.loadResInfo.loadingViewType = _loc2_.loadingViewType;
            this.loadResInfo.title = _loc2_.title;
            this.loadResInfo.label = _loc2_.label;
         }
         else
         {
            if(rest[1] == null)
            {
               throw new Error("[AngelSystemResAdapter] 系统资源加载的回调不能为null!!");
            }
            this.loadTask.paths = rest[0];
            this.loadTask.context = rest[5];
            this.loadResInfo.contents = [];
            this.loadResInfo.callBack = rest[1];
            this.loadResInfo.loadingViewType = rest[2];
            this.loadResInfo.title = rest[3];
            this.loadResInfo.label = rest[4];
         }
         if(this.commUIManager != null)
         {
            this.loadingView = this.commUIManager.createLoadingView(this.loadResInfo.loadingViewType,true);
            this.add_Remove_Listener(this.loadingView as IEventDispatcher);
            this.loadingView.setProgress(0);
            this.loadingView.setLabel(this.loadResInfo.label,this.loadResInfo.title);
         }
         this.isLoading = true;
         this.resLoadTaskManager.addLoadTask(this.loadTask);
         return true;
      }
      
      public function cancelRequest(... rest) : Boolean
      {
         return true;
      }
      
      public function disposeRes(... rest) : void
      {
      }
      
      public function setResLoadTaskManager(param1:IResLoadTaskManager) : void
      {
         this.resLoadTaskManager = param1;
      }
      
      public function getAdapterResType() : String
      {
         return Constants.SYS_RES;
      }
      
      public function removeAllCacheRes() : void
      {
      }
      
      public function stopAllResRequest() : void
      {
      }
   }
}

