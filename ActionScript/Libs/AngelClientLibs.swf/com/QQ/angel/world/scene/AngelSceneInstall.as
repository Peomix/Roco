package com.QQ.angel.world.scene
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.res.IResLoadTaskManager;
   import com.QQ.angel.api.res.ResData;
   import com.QQ.angel.api.res.ResLoadPriority;
   import com.QQ.angel.api.res.ResLoadTask;
   import com.QQ.angel.api.ui.ILoadingView;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.SceneDes;
   import com.QQ.angel.utils.ConfigLoader;
   import com.QQ.angel.world.scene.data.AngelSceneContext;
   import com.QQ.angel.world.scene.data.AngelSceneDataProxy;
   import com.QQ.angel.world.scene.data.AngelSceneModel;
   import com.QQ.angel.world.scene.events.AngelSceneEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class AngelSceneInstall extends EventDispatcher
   {
      
      private static const MAX_LOADING_TIME:int = 80000;
      
      private var __data:AngelSceneDataProxy;
      
      private var __resLoadManger:IResLoadTaskManager;
      
      protected var contextDict:Dictionary;
      
      protected var sceneLoadTask:ResLoadTask;
      
      protected var loadingUI:ILoadingView;
      
      protected var context:AngelSceneContext;
      
      protected var isWorking:Boolean = false;
      
      protected var loadLabel:String = "";
      
      protected var npcxmlLoader:ConfigLoader;
      
      public function AngelSceneInstall()
      {
         super();
         this.contextDict = new Dictionary();
         this.npcxmlLoader = new ConfigLoader();
         this.npcxmlLoader.addEventListener(ConfigLoader.CONF_LOAD_ERROR,this.onSceneConfLoaded);
         this.npcxmlLoader.addEventListener(ConfigLoader.CONF_LOAD_OK,this.onSceneConfLoaded);
         CallbackCenter.registerCallBack(CALLBACK.AS3_ENTER_FRAME,AngelSceneInstall.checkSceneLoadingTimeout,this);
      }
      
      private static function checkSceneLoadingTimeout(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc5_:AngelSceneInstall = AngelSceneInstall(param4);
         if(!_loc5_.sceneLoadTask || !_loc5_.sceneLoadTask.startLoadingTime)
         {
            return CallbackCenter.EVENT_OK;
         }
         if(getTimer() - _loc5_.sceneLoadTask.startLoadingTime >= MAX_LOADING_TIME)
         {
            _loc5_.fireError("加载场景超时");
            _loc5_.sceneLoadTask.startLoadingTime = 0;
         }
         return CallbackCenter.EVENT_OK;
      }
      
      protected function setLoadingLabel(param1:String) : void
      {
         if(this.loadingUI != null)
         {
            this.loadingUI.setLabel(param1);
         }
      }
      
      protected function fireError(param1:String) : void
      {
         this.setLoadingLabel(param1);
         this.isWorking = false;
         this.loadManager.delLoadTask(this.sceneLoadTask);
         var _loc2_:AngelSceneEvent = new AngelSceneEvent(AngelSceneEvent.ON_INSTALL_ERROR);
         _loc2_.context = this.context;
         _loc2_.message = param1;
         this.context = null;
         dispatchEvent(_loc2_);
      }
      
      protected function onSceneDataLoaded(param1:Event) : void
      {
         this.isWorking = false;
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_NEW_SCENE_BUILDED,[__global.SysAPI.getGDataAPI().getGlobalVal(Constants.PRE_SCENE),__global.SysAPI.getGDataAPI().getGlobalVal(Constants.CUR_SCENE)]);
         var _loc2_:AngelSceneEvent = new AngelSceneEvent(AngelSceneEvent.ON_INSTALL_SUCCESS);
         _loc2_.context = this.context;
         this.context = null;
         dispatchEvent(_loc2_);
      }
      
      protected function onSceneConfLoaded(param1:Event) : void
      {
         var _loc2_:AngelSceneModel = null;
         var _loc3_:SceneDes = null;
         if(param1 == null || param1.type == ConfigLoader.CONF_LOAD_OK)
         {
            this.setLoadingLabel("正在加载场景远程数据...");
            _loc2_ = this.context.model;
            _loc3_ = this.context.des;
            if(_loc2_ == null)
            {
               this.context.model = _loc2_ = new AngelSceneModel(_loc3_,this.dataProxy);
            }
            if(param1 != null)
            {
               this.context.npcXML = this.npcxmlLoader.getConf();
               CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_NEW_SCENE_CONFIG_LOADED,this.context);
            }
            _loc2_.load(this.context);
            this.dataProxy.load(_loc3_);
            return;
         }
         this.isWorking = false;
         this.fireError("配置文件加载失败");
      }
      
      protected function sceneLoadProgress(param1:LoadTaskEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ResData = param1.resData;
         if(this.loadingUI != null && _loc2_ != null)
         {
            _loc3_ = int(_loc2_.bytesLoaded / _loc2_.bytesTotal * 100);
            this.loadingUI.setProgress(_loc3_);
            this.setLoadingLabel(this.loadLabel.replace(/\{0\}/g,_loc3_ + ""));
         }
      }
      
      protected function onSceneSwfLoaded(param1:LoadTaskEvent, param2:* = null) : void
      {
         if(param2 == null)
         {
            param2 = param1.resData.content;
         }
         this.context.logic = param2 as IAngelSceneLogic;
         if(this.context.logic == null)
         {
            this.fireError("加载进来的场景非IAngelSceneLogic类型");
            return;
         }
         if(param1 != null && param1.resData != null)
         {
            this.context.logic.setCurrDomain(param1.resData.domain);
         }
         this.sceneLoadTask.startLoadingTime = 0;
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_NEW_SCENE_SWF_LOADED,this.context);
         var _loc3_:String = this.context.des.npcConf;
         if(_loc3_ != "")
         {
            this.setLoadingLabel("正在加载场景配置文件...");
            this.npcxmlLoader.loadConf(_loc3_);
         }
         else
         {
            this.onSceneConfLoaded(null);
         }
      }
      
      protected function onSceneSwfLoadedError(param1:LoadTaskEvent) : void
      {
         trace("[AngelSceneInstall] 文件加载失败:" + param1.message);
         this.fireError(param1.message);
      }
      
      protected function get task() : ResLoadTask
      {
         if(this.sceneLoadTask == null)
         {
            this.sceneLoadTask = new ResLoadTask();
            this.sceneLoadTask.paths = [];
            this.sceneLoadTask.priority = ResLoadPriority.HIGH;
            this.sceneLoadTask.progressHandler = new CFunction(this.sceneLoadProgress,this);
            this.sceneLoadTask.completeHandler = new CFunction(this.onSceneSwfLoaded,this);
            this.sceneLoadTask.errorHandler = new CFunction(this.onSceneSwfLoadedError,this);
         }
         return this.sceneLoadTask;
      }
      
      public function get dataProxy() : AngelSceneDataProxy
      {
         if(this.__data == null)
         {
            this.__data = new AngelSceneDataProxy(__global.SysAPI.getGDataAPI().getDataProxy(Constants.SO_DATA));
            this.__data.addEventListener(Event.COMPLETE,this.onSceneDataLoaded);
         }
         return this.__data;
      }
      
      public function get loadManager() : IResLoadTaskManager
      {
         if(this.__resLoadManger == null)
         {
            this.__resLoadManger = __global.SysAPI.getResSysAPI().getResLoadTaskManager();
         }
         return this.__resLoadManger;
      }
      
      public function getContext(param1:int, param2:int = 1) : AngelSceneContext
      {
         return this.contextDict[param1 + "." + param2];
      }
      
      public function install(param1:SceneDes, param2:ILoadingView) : void
      {
         if(this.isWorking)
         {
            throw new Error("[AngelSceneInstall] 一个场景正在加载中...");
         }
         this.isWorking = true;
         this.loadingUI = param2;
         this.loadingUI.setProgress(0);
         this.context = this.contextDict[param1.sceneID + "." + param1.ver];
         if(this.context == null)
         {
            this.contextDict[param1.sceneID + "." + param1.ver] = this.context = new AngelSceneContext(param1,null,null);
         }
         else if(this.context.des == null)
         {
            this.context.des = param1;
         }
         if(this.context.logic == null)
         {
            this.loadLabel = "加载场景" + param1.sceneName + "  {0}%";
            this.setLoadingLabel(this.loadLabel.replace(/\{0\}/g,"0"));
            this.task.paths[0] = param1.sceneSrc;
            this.sceneLoadTask.startLoadingTime = 0;
            this.loadManager.addLoadTask(this.sceneLoadTask);
         }
         else
         {
            this.onSceneSwfLoaded(null,this.context.logic);
         }
      }
      
      public function uninstall(param1:AngelSceneContext) : void
      {
         param1.model.unload();
         this.npcxmlLoader.reset();
         if(param1.logic != null)
         {
            param1.logic.finalize();
            param1.logic = null;
         }
      }
   }
}

