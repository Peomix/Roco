package com.QQ.angel.install.loader
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLRequestMethod;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   public class RetryLoader extends Loader
   {
      
      public static const NORMAL:int = 0;
      
      public static const STREAM:int = 1;
      
      public static const LOADER:int = 2;
      
      protected var stream:URLStream;
      
      private const MAX_TRY_TIMES:int = 3;
      
      protected var __url:String = "";
      
      protected var isByte:Boolean = false;
      
      protected var currBytes:ByteArray;
      
      private const COUNT_TIME:uint = 12;
      
      protected var __timer:Timer;
      
      protected var currLC:LoaderContext;
      
      protected var __loadState:int = 0;
      
      protected var __currTryTimes:int = 0;
      
      protected var __currTime:int = 0;
      
      public function RetryLoader(param1:Boolean = false)
      {
         super();
         isByte = param1;
         stream = new URLStream();
         currBytes = new ByteArray();
         stream.addEventListener(Event.OPEN,onStreamOpen);
         stream.addEventListener(HTTPStatusEvent.HTTP_STATUS,onHttpStatus);
         stream.addEventListener(IOErrorEvent.IO_ERROR,onStreamIOError);
         stream.addEventListener(ProgressEvent.PROGRESS,onStreamProgress);
         stream.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
         stream.addEventListener(Event.COMPLETE,onStreamComplete);
         contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaderComplete);
         contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onStreamIOError);
         __timer = new Timer(1000);
         __timer.addEventListener(TimerEvent.TIMER,onTimeOutError);
      }
      
      protected function onLoaderComplete(param1:Event) : void
      {
         __loadState = NORMAL;
         resetTimeOut(false);
         dispatchEvent(param1);
      }
      
      protected function onTimeOutError(param1:Event) : void
      {
         --__currTime;
         if(__currTime <= 0)
         {
            tryReload();
         }
      }
      
      protected function onSecurityError(param1:SecurityErrorEvent) : void
      {
         resetTimeOut(false);
         trace("[NewLoader] ##########加载安全策略错误:" + param1.text);
         dispatchEvent(param1);
      }
      
      protected function canTry(param1:Boolean = true) : Boolean
      {
         var _loc2_:IOErrorEvent = null;
         if(__currTryTimes < MAX_TRY_TIMES)
         {
            return true;
         }
         __loadState = NORMAL;
         if(param1)
         {
            _loc2_ = new IOErrorEvent(IOErrorEvent.IO_ERROR);
            _loc2_.text = "加载文件出错，您的网络环境不稳定，请稍后再试!";
            dispatchEvent(_loc2_);
         }
         return false;
      }
      
      protected function onStreamProgress(param1:ProgressEvent) : void
      {
         dispatchEvent(param1);
      }
      
      public function get bytes() : ByteArray
      {
         return currBytes;
      }
      
      override public function unload() : void
      {
         close();
         currBytes.length = 0;
         super.unload();
      }
      
      protected function onStreamComplete(param1:Event) : void
      {
         __loadState = LOADER;
         stream.readBytes(currBytes);
         trace("[NewLoader] COMPLETE事件触发，当前加载到的文件长度为:" + currBytes.length);
         if(isByte)
         {
            dispatchEvent(param1);
            return;
         }
         resetTimeOut(true,2);
         loadBytes(currBytes,currLC);
      }
      
      protected function onHttpStatus(param1:HTTPStatusEvent) : void
      {
         trace("[NewLoader] >>>>>>>>>>>>>http code:" + param1.status);
      }
      
      protected function onStreamIOError(param1:IOErrorEvent) : void
      {
         if(canTry(false))
         {
            tryReload();
         }
         else
         {
            dispatchEvent(param1);
         }
      }
      
      override public function load(param1:URLRequest, param2:LoaderContext = null) : void
      {
         unload();
         __currTryTimes = 0;
         __url = param1.url;
         currLC = param2;
         __loadState = STREAM;
         stream.load(param1);
      }
      
      protected function getReload() : void
      {
         unload();
         if(!canTry())
         {
            return;
         }
         ++__currTryTimes;
         __loadState = STREAM;
         var _loc1_:URLRequest = new URLRequest(__url);
         stream.load(_loc1_);
         trace("[NewLoader]","###加载中断，重新Get加载！url:" + __url);
      }
      
      protected function postReload() : void
      {
         unload();
         if(!canTry())
         {
            return;
         }
         ++__currTryTimes;
         __loadState = STREAM;
         var _loc1_:URLRequestHeader = new URLRequestHeader("pragma","no-cache");
         var _loc2_:URLRequest = new URLRequest(__url);
         _loc2_.data = new URLVariables("name=angel");
         _loc2_.method = URLRequestMethod.POST;
         _loc2_.requestHeaders = [_loc1_];
         stream.load(_loc2_);
         trace("[NewLoader]","###加载中断，重新post加载！url:" + __url);
      }
      
      public function setHasProgress(param1:Boolean) : void
      {
      }
      
      protected function onStreamOpen(param1:Event) : void
      {
         dispatchEvent(param1);
      }
      
      public function tryReload() : void
      {
         resetTimeOut(false);
         if(__loadState == LOADER)
         {
            postReload();
         }
         else
         {
            getReload();
         }
      }
      
      override public function close() : void
      {
         if(stream.connected)
         {
            stream.close();
         }
      }
      
      protected function resetTimeOut(param1:Boolean = true, param2:int = -1) : void
      {
         __currTime = param2 == -1 ? int(COUNT_TIME) : param2;
         __timer.reset();
         if(param1)
         {
            __timer.start();
         }
      }
   }
}

