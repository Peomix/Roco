package com.QQ.angel.utils
{
   import com.QQ.angel.api.net.DEFINE;
   import flash.display.Loader;
   import flash.events.Event;
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
   
   public class NewLoader extends Loader
   {
      
      public static const NORMAL:int = 0;
      
      public static const STREAM:int = 1;
      
      public static const LOADER:int = 2;
       
      
      protected var stream:URLStream;
      
      protected var currBytes:ByteArray;
      
      protected var currLC:LoaderContext;
      
      protected var isByte:Boolean = false;
      
      protected var __currTime:int = 0;
      
      protected var __timer:Timer;
      
      protected var __url:String = "";
      
      protected var __currTryTimes:int = 0;
      
      protected var __loadState:int = 0;
      
      private const COUNT_TIME:uint = 12;
      
      private const MAX_TRY_TIMES:int = 3;
      
      public function NewLoader(param1:Boolean = false)
      {
         super();
         this.isByte = param1;
         this.stream = new URLStream();
         this.currBytes = new ByteArray();
         this.stream.addEventListener(Event.OPEN,this.onStreamOpen);
         this.stream.addEventListener(IOErrorEvent.IO_ERROR,this.onStreamIOError);
         this.stream.addEventListener(ProgressEvent.PROGRESS,this.onStreamProgress);
         this.stream.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this.stream.addEventListener(Event.COMPLETE,this.onStreamComplete);
         contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaderComplete);
         contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onStreamIOError);
         this.__timer = new Timer(1000);
         this.__timer.addEventListener(TimerEvent.TIMER,this.onTimeOutError);
      }
      
      public function get url() : String
      {
         return this.__url;
      }
      
      protected function canTry(param1:Boolean = true) : Boolean
      {
         var _loc2_:IOErrorEvent = null;
         if(this.__currTryTimes < this.MAX_TRY_TIMES)
         {
            return true;
         }
         this.__loadState = NORMAL;
         if(param1)
         {
            _loc2_ = new IOErrorEvent(IOErrorEvent.IO_ERROR);
            _loc2_.text = "加载文件出错，您的网络环境不稳定，请稍后再试!";
            dispatchEvent(_loc2_);
         }
         return false;
      }
      
      protected function onTimeOutError(param1:Event) : void
      {
         --this.__currTime;
         if(this.__currTime <= 0)
         {
            this.tryReload();
         }
      }
      
      protected function resetTimeOut(param1:Boolean = true, param2:int = -1) : void
      {
         this.__currTime = param2 == -1 ? int(this.COUNT_TIME) : param2;
         this.__timer.reset();
         if(param1)
         {
            this.__timer.start();
         }
      }
      
      protected function onLoaderComplete(param1:Event) : void
      {
         this.__loadState = NORMAL;
         this.resetTimeOut(false);
         dispatchEvent(param1);
      }
      
      protected function onStreamOpen(param1:Event) : void
      {
         dispatchEvent(param1);
      }
      
      protected function onStreamIOError(param1:IOErrorEvent) : void
      {
         if(this.canTry(false))
         {
            this.tryReload();
         }
         else
         {
            dispatchEvent(param1);
         }
      }
      
      protected function onSecurityError(param1:SecurityErrorEvent) : void
      {
         this.resetTimeOut(false);
         trace("[NewLoader] ##########加载安全策略错误:" + param1.text);
         dispatchEvent(param1);
      }
      
      protected function onStreamProgress(param1:ProgressEvent) : void
      {
         dispatchEvent(param1);
      }
      
      protected function onStreamComplete(param1:Event) : void
      {
         this.__loadState = LOADER;
         this.stream.readBytes(this.currBytes);
         if(this.isByte)
         {
            dispatchEvent(param1);
            return;
         }
         this.resetTimeOut(true,2);
         loadBytes(this.currBytes,this.currLC);
      }
      
      protected function getReload() : void
      {
         this.unload();
         if(!this.canTry())
         {
            return;
         }
         ++this.__currTryTimes;
         this.__loadState = STREAM;
         var _loc1_:URLRequest = new URLRequest(this.__url);
         this.stream.load(_loc1_);
      }
      
      protected function postReload() : void
      {
         this.unload();
         if(!this.canTry())
         {
            return;
         }
         ++this.__currTryTimes;
         this.__loadState = STREAM;
         var _loc1_:URLRequestHeader = new URLRequestHeader("pragma","no-cache");
         var _loc2_:URLRequest = new URLRequest(this.__url);
         _loc2_.data = new URLVariables("name=angel");
         _loc2_.method = URLRequestMethod.POST;
         _loc2_.requestHeaders = [_loc1_];
         this.stream.load(_loc2_);
         trace("[NewLoader]","###加载中断，重新post加载！url:" + this.__url);
      }
      
      public function setHasProgress(param1:Boolean) : void
      {
      }
      
      public function get bytes() : ByteArray
      {
         return this.currBytes;
      }
      
      public function tryReload() : void
      {
         this.resetTimeOut(false);
         if(this.__loadState == LOADER)
         {
            this.postReload();
         }
         else
         {
            this.getReload();
         }
      }
      
      override public function load(param1:URLRequest, param2:LoaderContext = null) : void
      {
         this.unload();
         this.__currTryTimes = 0;
         this.__url = param1.url;
         this.__url = DEFINE.formatFileVersion(param1.url);
         param1.url = this.__url;
         this.currLC = param2;
         this.__loadState = STREAM;
         this.stream.load(param1);
      }
      
      override public function close() : void
      {
         if(this.stream.connected)
         {
            this.stream.close();
         }
      }
      
      override public function unload() : void
      {
         this.close();
         this.currBytes.length = 0;
         super.unload();
      }
   }
}
