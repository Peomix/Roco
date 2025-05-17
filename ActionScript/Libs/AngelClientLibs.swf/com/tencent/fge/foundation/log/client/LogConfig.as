package com.tencent.fge.foundation.log.client
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class LogConfig extends EventDispatcher
   {
      
      public static const EVENT_LOAD_COMPLETE:String = "EventLoadComplete";
      
      public static const EVENT_LOAD_ERROR:String = "EventLoadError";
      
      private var urlLoader:URLLoader;
      
      private var urlConfig:String = "Debug.xml";
      
      private var cfgList:Dictionary;
      
      private var allError:Boolean = true;
      
      private var allTrace:Boolean = false;
      
      private var allDebug:Boolean = true;
      
      private var allThrow:Boolean = true;
      
      private var allWarn:Boolean = true;
      
      private var allFatal:Boolean = true;
      
      private var outTarget:int = 0;
      
      protected var version:String = "1.0.0";
      
      protected var author:String = "slicoltang,slicol@qq.com";
      
      protected var copyright:String = "腾讯计算机系统有限公司";
      
      public function LogConfig()
      {
         super();
         this.urlLoader = new URLLoader();
      }
      
      public function load(param1:String = null) : Boolean
      {
         if(param1 == null || param1.length == 0)
         {
            param1 = this.urlConfig;
         }
         this.urlLoader.load(new URLRequest(param1));
         this.urlLoader.addEventListener(Event.COMPLETE,this.onConfigLoaded);
         this.urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this.urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         return true;
      }
      
      private function unload() : void
      {
         this.urlLoader.removeEventListener(Event.COMPLETE,this.onConfigLoaded);
         this.urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this.urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
      }
      
      public function loadContent(param1:String) : Boolean
      {
         var xmlList:XMLList;
         var len:int;
         var i:int;
         var tmpXML:XML = null;
         var name:String = null;
         var error:Boolean = false;
         var trace:Boolean = false;
         var debug:Boolean = false;
         var warn:Boolean = false;
         var exthrow:Boolean = false;
         var fatal:Boolean = false;
         var o:Object = null;
         var content:String = param1;
         try
         {
            tmpXML = new XML(content);
         }
         catch(e:Error)
         {
            return false;
         }
         xmlList = tmpXML.children();
         len = int(xmlList.length());
         this.cfgList = new Dictionary();
         this.allError = tmpXML.@error != "false";
         this.allTrace = tmpXML.@trace == "true";
         this.allDebug = tmpXML.@debug != "false";
         this.allThrow = tmpXML.@exthrow == "true";
         this.allWarn = tmpXML.@warn != "false";
         this.allFatal = tmpXML.@fatal != "false";
         this.outTarget = tmpXML.@target;
         i = 0;
         while(i < len)
         {
            name = xmlList[i].@name;
            error = xmlList[i].@error != "false";
            trace = xmlList[i].@trace == "true";
            debug = xmlList[i].@debug != "false";
            warn = xmlList[i].@warn != "false";
            exthrow = xmlList[i].@exthrow == "true";
            fatal = xmlList[i].@fatal == "true";
            o = new Object();
            o.name = name;
            o.error = error;
            o.trace = trace;
            o.debug = debug;
            o.exthrow = exthrow;
            o.warn = warn;
            o.fatal = fatal;
            this.cfgList[o.name] = o;
            i++;
         }
         return true;
      }
      
      private function onConfigLoaded(param1:Event) : void
      {
         var _loc2_:Boolean = this.loadContent(param1.currentTarget.data);
         this.unload();
         if(_loc2_)
         {
            this.dispatchEvent(new Event(EVENT_LOAD_COMPLETE));
         }
         else
         {
            this.dispatchEvent(new Event(EVENT_LOAD_ERROR));
         }
      }
      
      private function onError(param1:Event) : void
      {
         this.unload();
         this.dispatchEvent(new Event(EVENT_LOAD_ERROR));
      }
      
      public function logError(param1:String = null) : Boolean
      {
         var _loc2_:Object = null;
         if(param1 == null || this.cfgList == null)
         {
            return this.allError;
         }
         _loc2_ = this.cfgList[param1];
         if(_loc2_ == null)
         {
            _loc2_ = this.cfgList["Default"];
         }
         if(_loc2_ == null)
         {
            return this.allError;
         }
         return _loc2_.error;
      }
      
      public function logWarn(param1:String = null) : Boolean
      {
         var _loc2_:Object = null;
         if(param1 == null || this.cfgList == null)
         {
            return this.allWarn;
         }
         _loc2_ = this.cfgList[param1];
         if(_loc2_ == null)
         {
            _loc2_ = this.cfgList["Default"];
         }
         if(_loc2_ == null)
         {
            return this.allWarn;
         }
         return _loc2_.warn;
      }
      
      public function logTrace(param1:String = null) : Boolean
      {
         var _loc2_:Object = null;
         if(param1 == null || this.cfgList == null)
         {
            return this.allTrace;
         }
         _loc2_ = this.cfgList[param1];
         if(_loc2_ == null)
         {
            _loc2_ = this.cfgList["Default"];
         }
         if(_loc2_ == null)
         {
            return this.allTrace;
         }
         return _loc2_.trace;
      }
      
      public function logDebug(param1:String = null) : Boolean
      {
         var _loc2_:Object = null;
         if(param1 == null || this.cfgList == null)
         {
            return this.allDebug;
         }
         _loc2_ = this.cfgList[param1];
         if(_loc2_ == null)
         {
            _loc2_ = this.cfgList["Default"];
         }
         if(_loc2_ == null)
         {
            return this.allDebug;
         }
         return _loc2_.debug;
      }
      
      public function logThrow(param1:String = null) : Boolean
      {
         var _loc2_:Object = null;
         if(param1 == null || this.cfgList == null)
         {
            return this.allThrow;
         }
         _loc2_ = this.cfgList[param1];
         if(_loc2_ == null)
         {
            _loc2_ = this.cfgList["Default"];
         }
         if(_loc2_ == null)
         {
            return this.allThrow;
         }
         return _loc2_.exthrow;
      }
      
      public function logFatal(param1:String = null) : Boolean
      {
         var _loc2_:Object = null;
         if(param1 == null || this.cfgList == null)
         {
            return this.allFatal;
         }
         _loc2_ = this.cfgList[param1];
         if(_loc2_ == null)
         {
            _loc2_ = this.cfgList["Default"];
         }
         if(_loc2_ == null)
         {
            return this.allFatal;
         }
         return _loc2_.fatal;
      }
      
      public function logOutTarget() : int
      {
         return this.outTarget;
      }
   }
}

