package com.QQ.angel.install.config
{
   import com.QQ.angel.install.loader.RetrySecretLoaderCutFile;
   import com.QQ.angel.install.logging.log;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class AngelLibsLoader
   {
       
      
      protected var loadContext:LoaderContext;
      
      protected var currComplete:Function;
      
      protected var currLibs:Array;
      
      protected var loadingUI:InstallLoadingBar;
      
      protected var totalLibs:int;
      
      protected var libLoader:RetrySecretLoaderCutFile;
      
      protected var currLoadItem:Object;
      
      public function AngelLibsLoader(param1:InstallLoadingBar)
      {
         super();
         this.loadingUI = param1;
         this.libLoader = new RetrySecretLoaderCutFile();
         this.libLoader.setHasProgress(true);
         this.loadContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         libLoader.addEventListener(Event.COMPLETE,onLibLoaded);
         libLoader.addEventListener(ProgressEvent.PROGRESS,onProgress);
         libLoader.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
      }
      
      protected function onIOError(param1:IOErrorEvent) : void
      {
         this.loadingUI.msg_txt.text = "加载文件出错，请刷新页面!";
         var _loc2_:int = int(this.currLibs.length);
         log(5 - _loc2_,2);
      }
      
      protected function nextLibLoading() : void
      {
         currLoadItem = currLibs.shift();
         this.libLoader.load(new URLRequest(currLoadItem.src),loadContext);
         updateMSGTxt(0,1);
      }
      
      protected function onProgress(param1:ProgressEvent) : void
      {
         updateMSGTxt(param1.bytesLoaded,param1.bytesTotal);
      }
      
      protected function onLibLoaded(param1:Event) : void
      {
         if(currLibs.length == 0)
         {
            this.loadingUI.msg_txt.text = "加载完毕";
            this.currComplete();
            this.currLibs = null;
            this.totalLibs = 0;
            this.currComplete = null;
            this.loadingUI.visible = false;
            return;
         }
         this.libLoader.unload();
         nextLibLoading();
      }
      
      public function loadLibs(param1:Array, param2:Function) : void
      {
         if(this.currLibs != null)
         {
            trace("[AngelInstallHelp] 上一个类库加载未完成!!");
            return;
         }
         if(param1 == null || param1.length == 0)
         {
            param2(null);
            return;
         }
         this.currLibs = param1;
         this.totalLibs = param1.length;
         this.currComplete = param2;
         this.loadingUI.visible = true;
         this.nextLibLoading();
      }
      
      protected function updateMSGTxt(param1:int, param2:int) : void
      {
         var _loc3_:int = int(param1 / param2 * 100);
         var _loc4_:int = totalLibs - currLibs.length;
         this.loadingUI.msg_txt.text = "努力加载中 " + _loc3_ + "%";
         this.loadingUI.bar.gotoAndStop(_loc3_);
      }
   }
}
