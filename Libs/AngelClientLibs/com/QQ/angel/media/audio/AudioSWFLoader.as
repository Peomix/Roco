package com.QQ.angel.media.audio
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.res.IResLoadTaskManager;
   import com.QQ.angel.api.res.ResLoadPriority;
   import com.QQ.angel.api.res.ResLoadTask;
   import com.QQ.angel.api.utils.CFunction;
   
   public class AudioSWFLoader implements IAngelSysAPIAware
   {
       
      
      public var onLoaded:Function;
      
      private var _sysApi:IAngelSysAPI;
      
      private var _task:ResLoadTask;
      
      private var _resLoadManager:IResLoadTaskManager;
      
      public function AudioSWFLoader()
      {
         super();
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this._sysApi = param1;
      }
      
      public function load(param1:String) : void
      {
         if(this._sysApi == null)
         {
            return;
         }
         if(this._resLoadManager == null)
         {
            this._resLoadManager = this._sysApi.getResSysAPI().getResLoadTaskManager();
         }
         var _loc2_:ResLoadTask = new ResLoadTask();
         _loc2_.priority = ResLoadPriority.LOW;
         _loc2_.paths = [param1];
         if(this.onSWFProgress != null)
         {
            _loc2_.progressHandler = new CFunction(this.onSWFProgress,this);
         }
         if(this.onSWFError != null)
         {
            _loc2_.errorHandler = new CFunction(this.onSWFError,this);
         }
         if(this.onSWFComplete != null)
         {
            _loc2_.completeHandler = new CFunction(this.onSWFComplete,this);
         }
         if(this.onSWFAllComplete != null)
         {
            _loc2_.allCompleteHandler = new CFunction(this.onSWFAllComplete,this);
         }
         this._task = _loc2_;
         this._resLoadManager.addLoadTask(_loc2_);
      }
      
      public function stop() : void
      {
         if(this._resLoadManager == null || this._task == null)
         {
            return;
         }
         var _loc1_:Boolean = this._resLoadManager.delLoadTask(this._task);
         this._task = null;
         this._resLoadManager = null;
      }
      
      private function onSWFProgress(param1:LoadTaskEvent) : void
      {
      }
      
      private function onSWFError(param1:LoadTaskEvent) : void
      {
      }
      
      private function onSWFComplete(param1:LoadTaskEvent) : void
      {
         if(this.onLoaded != null)
         {
            this.onLoaded(param1.resData);
         }
      }
      
      private function onSWFAllComplete(param1:LoadTaskEvent) : void
      {
      }
   }
}
