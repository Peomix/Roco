package com.QQ.angel.utils
{
   import com.QQ.angel.api.net.DEFINE;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class ConfigLoader extends EventDispatcher
   {
      
      public static const CONF_LOAD_OK:String = "confLoadOk";
      
      public static const CONF_LOAD_ERROR:String = "confLoadError";
      
      public static var MAX_TRY_TIMES:int = 3;
       
      
      protected var ready:Boolean = false;
      
      protected var urlLoader:URLLoader;
      
      protected var currURL:String = "";
      
      protected var currTimes:int = 0;
      
      protected var conf:String;
      
      public function ConfigLoader(param1:Object = null)
      {
         super();
         this.analyse(param1);
         this.urlLoader = new URLLoader();
         this.urlLoader.addEventListener(Event.COMPLETE,this.onConfStatesHandler);
         this.urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onConfStatesHandler);
         this.urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onConfStatesHandler);
      }
      
      protected function onConfStatesHandler(param1:Event) : void
      {
         var _loc2_:ErrorEvent = null;
         if(param1.type == Event.COMPLETE)
         {
            this.currURL = "";
            this.currTimes = 0;
            if(this.analyse(this.urlLoader.data))
            {
               dispatchEvent(new Event(CONF_LOAD_OK));
               return;
            }
         }
         if(!this.reload())
         {
            this.currURL = "";
            this.currTimes = 0;
            _loc2_ = new ErrorEvent(CONF_LOAD_ERROR);
            _loc2_.text = "配置文件加载失败!";
            dispatchEvent(_loc2_);
         }
      }
      
      protected function reload() : Boolean
      {
         ++this.currTimes;
         if(this.currTimes > MAX_TRY_TIMES)
         {
            return false;
         }
         this.urlLoader.load(new URLRequest(DEFINE.formatFileVersion(this.currURL)));
         return true;
      }
      
      public function isReady() : Boolean
      {
         return this.ready;
      }
      
      public function analyse(param1:Object) : Boolean
      {
         this.conf = param1 as String;
         return true;
      }
      
      public function loadConf(param1:String) : void
      {
         this.currTimes = 0;
         this.currURL = param1;
         this.conf = "";
         this.reload();
      }
      
      public function getConf() : String
      {
         return this.conf;
      }
      
      public function reset() : void
      {
         this.currTimes = 0;
         this.currURL = "";
         this.conf = "";
      }
      
      public function dispose() : void
      {
         if(this.urlLoader)
         {
            this.urlLoader.removeEventListener(Event.COMPLETE,this.onConfStatesHandler);
            this.urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onConfStatesHandler);
            this.urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onConfStatesHandler);
            this.urlLoader = null;
         }
         this.currTimes = 0;
         this.currURL = null;
         this.conf = null;
      }
   }
}
