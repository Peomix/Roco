package com.QQ.angel.plug
{
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.plug.IPlugLib;
   import com.QQ.angel.api.plug.IPlugProgram;
   import com.QQ.angel.api.res.IResLoadTaskManager;
   import com.QQ.angel.api.res.ResLoadTask;
   import com.QQ.angel.api.utils.CFunction;
   
   public class PluginFactory
   {
      
      private static var __instance:PluginFactory;
      
      public static const PLUGIN_LIB:String = "pluginLib";
      
      protected var manager:IAngelPluginManager;
      
      protected var installList:Array;
      
      protected var isRuning:Boolean = false;
      
      protected var currItem:InstallParams;
      
      protected var loadManager:IResLoadTaskManager;
      
      protected var task:ResLoadTask;
      
      protected var loadUI:PluginLoadingUI;
      
      public function PluginFactory(param1:IAngelPluginManager)
      {
         super();
         this.manager = param1;
         this.installList = [];
         this.loadUI = new PluginLoadingUI(param1.getSys());
      }
      
      public static function getInstance(param1:IAngelPluginManager = null) : PluginFactory
      {
         if(__instance == null)
         {
            __instance = new PluginFactory(param1);
         }
         return __instance;
      }
      
      protected function analyseInstallParams() : void
      {
         var _loc1_:Array = [];
         this.getRequireLoad(this.currItem.setting,_loc1_);
         this.task.paths = _loc1_;
      }
      
      protected function getRequireLoad(param1:PluginSetting, param2:Array) : void
      {
         var _loc5_:int = 0;
         var _loc6_:PluginSetting = null;
         if(this.manager.hasPlug(param1.plugName))
         {
            return;
         }
         var _loc3_:String = param1.plugSrc;
         if(param1.version)
         {
            if(_loc3_.indexOf("?") == -1)
            {
               _loc3_ += "?plugVer=" + param1.version;
            }
            else
            {
               _loc3_ += "&plugVer=" + param1.version;
            }
         }
         else
         {
            _loc3_ = DEFINE.addVersion(_loc3_);
         }
         param2.splice(0,0,_loc3_);
         var _loc4_:Array = param1.require;
         if(_loc4_ != null)
         {
            _loc5_ = int(_loc4_.length - 1);
            while(_loc5_ >= 0)
            {
               _loc6_ = this.manager.getSettingByName(_loc4_[_loc5_]);
               if(_loc6_ != null)
               {
                  this.getRequireLoad(_loc6_,param2);
               }
               _loc5_--;
            }
         }
      }
      
      private function callPluginHandler(param1:InstallParams) : void
      {
         var _loc2_:IPlugProgram = null;
         if(param1.exeDes != null)
         {
            _loc2_ = this.manager.getPlugByName(param1.plugName);
            if(_loc2_ != null)
            {
               _loc2_.call(param1.exeDes.arg);
            }
         }
      }
      
      protected function pluginLoaded(param1:LoadTaskEvent) : void
      {
         this.loadUI.end(this.currItem);
         var _loc2_:IPlugLib = param1.resData.content;
         var _loc3_:int = param1.resData.itemsLoaded;
         this.manager.installFromLib(_loc2_,null);
         if(this.currItem.handler != null)
         {
            this.currItem.handler.call(this.currItem);
         }
         this.currItem = null;
      }
      
      protected function allPluginLoaded(param1:LoadTaskEvent) : void
      {
         if(this.installList.length == 0)
         {
            this.isRuning = false;
         }
         else
         {
            this.next();
         }
      }
      
      protected function pluginLoadError(param1:LoadTaskEvent) : void
      {
         this.loadManager.delLoadTask(this.task);
         this.loadUI.end(this.currItem,true);
         this.next();
         this.currItem = null;
      }
      
      protected function getLoadManager() : IResLoadTaskManager
      {
         if(this.loadManager == null)
         {
            this.loadManager = this.manager.getSys().getResSysAPI().getResLoadTaskManager();
            this.loadManager.createVipChannel(PLUGIN_LIB);
            this.task = new ResLoadTask();
            this.task.resType = PLUGIN_LIB;
            this.task.completeHandler = new CFunction(this.pluginLoaded,this);
            this.task.allCompleteHandler = new CFunction(this.allPluginLoaded,this);
            this.task.errorHandler = new CFunction(this.pluginLoadError,this);
            this.loadUI.setLoadTask(this.task);
         }
         return this.loadManager;
      }
      
      protected function start() : void
      {
         if(this.isRuning)
         {
            return;
         }
         this.isRuning = true;
         this.next();
      }
      
      protected function next() : void
      {
         if(this.installList.length == 0)
         {
            this.isRuning = false;
            return;
         }
         var _loc1_:InstallParams = this.installList.shift();
         if(this.manager.hasPlug(_loc1_.plugName))
         {
            this.next();
            return;
         }
         this.currItem = _loc1_;
         var _loc2_:IResLoadTaskManager = this.getLoadManager();
         this.task.context = _loc1_.context;
         this.analyseInstallParams();
         if(this.currItem.loadType == PluginSetting.SYNC_LOAD)
         {
            this.loadUI.ready(this.currItem);
            this.loadUI.start(this.currItem);
         }
         _loc2_.addLoadTask(this.task);
      }
      
      public function createAndInstallAndCall(param1:InstallParams) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.handler = new CFunction(this.callPluginHandler);
         this.createAndInstall(param1);
      }
      
      public function createAndInstall(param1:InstallParams) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(this.manager.hasPlug(param1.plugName))
         {
            return;
         }
         if(param1.loadType == PluginSetting.SYNC_LOAD)
         {
            if(!this.loadUI.isUsing())
            {
               this.loadUI.ready(param1);
            }
         }
         this.installList.push(param1);
         this.start();
      }
   }
}

import com.QQ.angel.api.IAngelSysAPI;
import com.QQ.angel.api.events.LoadTaskEvent;
import com.QQ.angel.api.res.ResData;
import com.QQ.angel.api.res.ResLoadTask;
import com.QQ.angel.api.ui.ICommUIManager;
import com.QQ.angel.api.ui.ILoadingView;
import com.QQ.angel.api.ui.IWindow;
import com.QQ.angel.api.utils.CFunction;

class PluginLoadingUI
{
   
   protected var sys:IAngelSysAPI;
   
   protected var commUI:ICommUIManager;
   
   protected var loadingView:ILoadingView;
   
   protected var params:InstallParams;
   
   protected var task:ResLoadTask;
   
   protected var progressHandler:CFunction;
   
   public function PluginLoadingUI(param1:IAngelSysAPI)
   {
      super();
      this.sys = param1;
      this.progressHandler = new CFunction(this.onProgress,this);
   }
   
   protected function createLoadingView() : void
   {
      if(this.commUI == null)
      {
         this.commUI = this.sys.getUISysAPI().commUIManager;
      }
      if(this.loadingView == null)
      {
         this.loadingView = this.commUI.createLoadingView(5,true);
      }
   }
   
   public function setLoadTask(param1:ResLoadTask) : void
   {
      this.task = param1;
   }
   
   public function isUsing() : InstallParams
   {
      return this.params;
   }
   
   public function ready(param1:InstallParams) : void
   {
      this.params = param1;
      this.createLoadingView();
      this.loadingView.setProgress(0);
      this.loadingView.setLabel("插件系统准备中...");
   }
   
   public function start(param1:InstallParams) : void
   {
      if(this.params == null)
      {
         return;
      }
      if(this.params != param1)
      {
         return;
      }
      this.loadingView.setLabel("正在加载" + this.params.setting.plugLabel + "及其依赖插件");
      if(this.task != null)
      {
         this.task.progressHandler = this.progressHandler;
      }
   }
   
   public function onProgress(param1:LoadTaskEvent) : void
   {
      var _loc2_:ResData = param1.resData;
      if(_loc2_ == null || this.loadingView == null)
      {
         return;
      }
      var _loc3_:int = int(_loc2_.bytesLoaded / _loc2_.bytesTotal * 100);
      this.loadingView.setLabel("正在加载" + this.params.setting.plugLabel + "及其依赖插件 (" + _loc2_.itemsLoaded + "/" + _loc2_.itemsTotal + ")");
      this.loadingView.setProgress(_loc3_);
   }
   
   public function end(param1:InstallParams, param2:Boolean = false) : void
   {
      if(this.params == null)
      {
         return;
      }
      if(this.params != param1)
      {
         return;
      }
      this.params = null;
      if(this.task != null)
      {
         this.task.progressHandler = null;
      }
      if(this.loadingView != null)
      {
         this.commUI.closeWindow(this.loadingView as IWindow);
         this.loadingView = null;
      }
      if(param2)
      {
         this.commUI.alert("","由于某种原因插件装载失败!");
      }
   }
}
