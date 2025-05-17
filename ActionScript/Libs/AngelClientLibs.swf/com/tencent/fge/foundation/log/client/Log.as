package com.tencent.fge.foundation.log.client
{
   import flash.events.Event;
   import flash.events.StatusEvent;
   import flash.external.ExternalInterface;
   import flash.net.LocalConnection;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class Log implements ILog
   {
      
      private static var customOutput:ICustomOutput;
      
      private static var conn:LocalConnection;
      
      private static var outLog:Function;
      
      public static const OUT2IDE:int = 0;
      
      public static const OUT2LC:int = 1;
      
      public static const OUT2API:int = 2;
      
      public static const OUT2CUSTOM:int = 3;
      
      public static const OUT2SO:int = 4;
      
      public static const TYPE_TRACE:int = 1;
      
      public static const TYPE_DEBUG:int = 2;
      
      public static const TYPE_WARN:int = 3;
      
      public static const TYPE_ERROR:int = 4;
      
      public static var connServerName:String = "DebugServer";
      
      private static var glbTraceChanged:Boolean = false;
      
      private static var glbDebugChanged:Boolean = false;
      
      private static var glbWarnChanged:Boolean = false;
      
      private static var glbErrorChanged:Boolean = false;
      
      private static var glbFatalChanged:Boolean = false;
      
      private static var cfgChanged:Boolean = false;
      
      private static var useConfig:Boolean = false;
      
      private static var outTarget:int = OUT2IDE;
      
      private static var logList:Array = new Array();
      
      private static var logConfig:LogConfig = new LogConfig();
      
      private static var bTrace:Boolean = false;
      
      private static var bDebug:Boolean = true;
      
      private static var bWarn:Boolean = true;
      
      private static var bError:Boolean = true;
      
      private static var bThrow:Boolean = false;
      
      private static var bFatal:Boolean = true;
      
      private static var logCount:int = 0;
      
      private var bTrace:Boolean = false;
      
      private var bDebug:Boolean = true;
      
      private var bWarn:Boolean = true;
      
      private var bError:Boolean = true;
      
      private var bThrow:Boolean = false;
      
      private var bFatal:Boolean = true;
      
      private var logCount:int = 0;
      
      private var clsName:String = "*";
      
      private var funName:String = "*";
      
      private var curDate:Date;
      
      protected var version:String = "1.0.0";
      
      protected var author:String = "slicoltang,slicol@qq.com";
      
      protected var copyright:String = "腾讯计算机系统有限公司";
      
      public function Log(param1:Object = null, param2:String = null, param3:Boolean = true, param4:Boolean = true, param5:Boolean = true, param6:Boolean = true, param7:Boolean = true, param8:Boolean = true)
      {
         var _loc9_:int = 0;
         this.curDate = new Date();
         super();
         if(param1 != null)
         {
            if(param1 is String)
            {
               this.clsName = param1 as String;
            }
            else
            {
               this.clsName = getQualifiedClassName(param1);
               _loc9_ = int(this.clsName.lastIndexOf("::"));
               if(_loc9_ >= 0)
               {
                  this.clsName = this.clsName.substring(_loc9_ + 2);
               }
            }
         }
         if(param2 != null)
         {
            this.funName = param2;
         }
         if(Log.useConfig)
         {
            this.bError = logConfig.logError(this.clsName);
            this.bTrace = logConfig.logTrace(this.clsName);
            this.bDebug = logConfig.logDebug(this.clsName);
            this.bThrow = logConfig.logThrow(this.clsName);
            this.bWarn = logConfig.logWarn(this.clsName);
            this.bFatal = logConfig.logWarn(this.clsName);
         }
         else
         {
            this.bTrace = param3;
            this.bError = param4;
            this.bDebug = param5;
            this.bThrow = param6;
            this.bWarn = param7;
            this.bFatal = param8;
         }
         if(Log.outLog == null)
         {
            Log.outLog = Log.outLog2Ide;
         }
         logList.push(this);
      }
      
      public static function initialize(param1:Boolean, param2:int, param3:ICustomOutput = null, param4:Object = null) : void
      {
         if(param1)
         {
            logConfig.load();
            logConfig.addEventListener(LogConfig.EVENT_LOAD_COMPLETE,Log.onLoadConfig);
         }
         else
         {
            Log.bTrace = true;
            Log.bError = true;
            Log.bDebug = true;
            Log.bThrow = true;
            Log.bWarn = true;
            Log.bFatal = true;
         }
         Log.customOutput = param3;
         Log.useConfig = param1;
         setLogTarget(param2,param4);
      }
      
      public static function loadConfig(param1:String) : void
      {
         Log.cfgChanged = true;
         Log.useConfig = true;
         logConfig.load(param1);
         logConfig.addEventListener(LogConfig.EVENT_LOAD_COMPLETE,Log.onLoadConfig);
      }
      
      public static function loadConfigContent(param1:String) : void
      {
         Log.cfgChanged = true;
         Log.useConfig = true;
         if(logConfig.loadContent(param1))
         {
            updateGlobalFlag();
         }
      }
      
      public static function clearConfig() : void
      {
         Log.cfgChanged = false;
      }
      
      public static function getAllLogList() : Array
      {
         return logList.concat();
      }
      
      public static function setCustomOut(param1:ICustomOutput) : void
      {
         Log.customOutput = param1;
      }
      
      public static function setLogTarget(param1:int, param2:Object = null) : void
      {
         Log.outTarget = param1;
         switch(Log.outTarget)
         {
            case Log.OUT2API:
               Log.outLog = Log.outLog2Api;
               break;
            case Log.OUT2IDE:
               Log.outLog = Log.outLog2Ide;
               break;
            case Log.OUT2LC:
               Log.outLog = Log.outLog2LC;
               if(conn == null)
               {
                  conn = new LocalConnection();
                  conn.addEventListener(StatusEvent.STATUS,Log.onStatusEvent);
               }
               break;
            case Log.OUT2SO:
               Log.outLog = Log.outLog2SO;
               break;
            case Log.OUT2CUSTOM:
               Log.outLog = Log.customOutput != null ? Log.customOutput.outLog : Log.outLog2Custom;
               break;
            default:
               Log.outLog = Log.outLog2Ide;
         }
         if(Log.outTarget == Log.OUT2SO)
         {
            SOLog.ready(param2);
         }
      }
      
      public static function setTraceEnable(param1:Boolean) : void
      {
         Log.glbTraceChanged = true;
         Log.bTrace = param1;
      }
      
      public static function getTraceEnable() : Boolean
      {
         return bTrace;
      }
      
      public static function setErrorEnable(param1:Boolean) : void
      {
         Log.glbErrorChanged = true;
         Log.bError = param1;
      }
      
      public static function getErrorEnable() : Boolean
      {
         return bError;
      }
      
      public static function setThrowEnable(param1:Boolean) : void
      {
         Log.bThrow = param1;
      }
      
      public static function getThrowEnable() : Boolean
      {
         return bThrow;
      }
      
      public static function setDebugEnable(param1:Boolean) : void
      {
         Log.glbDebugChanged = true;
         Log.bDebug = param1;
      }
      
      public static function getDebugEnable() : Boolean
      {
         return bDebug;
      }
      
      public static function setWarnEnable(param1:Boolean) : void
      {
         Log.glbWarnChanged = true;
         Log.bWarn = param1;
      }
      
      public static function getWarnEnable() : Boolean
      {
         return bWarn;
      }
      
      public static function setFatalEnable(param1:Boolean) : void
      {
         Log.glbFatalChanged = true;
         Log.bFatal = param1;
      }
      
      public static function getFatalEnable() : Boolean
      {
         return bFatal;
      }
      
      private static function onStatusEvent(param1:StatusEvent) : void
      {
      }
      
      private static function onLoadConfig(param1:Event) : void
      {
         updateGlobalFlag();
      }
      
      private static function updateGlobalFlag() : void
      {
         Log.bError = logConfig.logError();
         Log.bTrace = logConfig.logTrace();
         Log.bDebug = logConfig.logDebug();
         Log.bThrow = logConfig.logThrow();
         Log.bWarn = logConfig.logWarn();
         Log.bFatal = logConfig.logFatal();
         Log.outTarget = logConfig.logOutTarget();
      }
      
      private static function outLog2Custom(param1:String, param2:String, param3:String, param4:String, param5:Array) : void
      {
         if(customOutput != null)
         {
            ++Log.logCount;
            customOutput.outLog(param1,param2,param3,param4,param5);
            Log.outLog = customOutput.outLog;
         }
         else
         {
            outLog2Ide(param1,param2,param3,param4,param5);
         }
      }
      
      private static function outLog2LC(param1:String, param2:String, param3:String, param4:String, param5:Array) : void
      {
         ++Log.logCount;
         conn.send(connServerName,"outputLog",param1,param2,param3,param4,param5);
      }
      
      private static function outLog2Api(param1:String, param2:String, param3:String, param4:String, param5:Array) : void
      {
         ++Log.logCount;
         var _loc6_:String = param3 + "." + param4 + "() " + param5.toString();
         ExternalInterface.call("API.Log",_loc6_);
      }
      
      private static function outLog2SO(param1:String, param2:String, param3:String, param4:String, param5:Array) : void
      {
         ++Log.logCount;
         var _loc6_:String = "[" + param1 + "][" + Log.logCount + "][" + param2 + "] " + param3 + "." + param4 + "() " + param5.toString();
         SOLog.out(_loc6_);
      }
      
      private static function outLog2Ide(param1:String, param2:String, param3:String, param4:String, param5:Array) : void
      {
         ++Log.logCount;
         var _loc6_:String = "[" + param1 + "][" + Log.logCount + "][" + param2 + "] " + param3 + "." + param4 + "() " + param5.toString();
         IdeLog.out(_loc6_);
      }
      
      public static function exthrow(param1:String, ... rest) : void
      {
         var _loc3_:String = null;
         if(Log.outLog != null)
         {
            Log.outLog(null,LogType.EXTHROW,"*",param1,rest);
         }
         if(Log.bThrow)
         {
            _loc3_ = "*." + param1 + "() " + rest.toString();
            throw "抛出异常：" + _loc3_;
         }
      }
      
      public static function trace(param1:String, ... rest) : void
      {
         if(Log.outLog != null && Log.bTrace)
         {
            Log.outLog(null,LogType.TRACE,"*",param1,rest);
         }
      }
      
      public static function debug(param1:String, ... rest) : void
      {
         if(Log.outLog != null && Log.bDebug)
         {
            Log.outLog(null,LogType.DEBUG,"*",param1,rest);
         }
      }
      
      public static function warn(param1:String, ... rest) : void
      {
         if(Log.outLog != null && Log.bWarn)
         {
            Log.outLog(null,LogType.WARN,"*",param1,rest);
         }
      }
      
      public static function error(param1:String, ... rest) : void
      {
         if(Log.outLog != null && Log.bError)
         {
            Log.outLog(null,LogType.ERROR,"*",param1,rest);
         }
      }
      
      public static function fatal(param1:String, ... rest) : void
      {
         if(Log.outLog != null && Log.bFatal)
         {
            Log.outLog(null,LogType.FATAL,"*",param1,rest);
         }
      }
      
      public static function log(param1:String, param2:String, param3:String, ... rest) : void
      {
         if(Log.outLog != null)
         {
            Log.outLog(null,param1,param2,param3,rest);
         }
      }
      
      public static function getLSOLogList(param1:String = null) : Dictionary
      {
         return SOLog.getLogList(param1);
      }
      
      public function attachClassName(param1:String) : void
      {
         this.clsName = param1;
         if(Log.useConfig)
         {
            this.bError = logConfig.logError(this.clsName);
            this.bTrace = logConfig.logTrace(this.clsName);
            this.bDebug = logConfig.logDebug(this.clsName);
            this.bThrow = logConfig.logThrow(this.clsName);
            this.bWarn = logConfig.logWarn(this.clsName);
            this.bFatal = logConfig.logFatal(this.clsName);
         }
      }
      
      public function getClsName() : String
      {
         return this.clsName;
      }
      
      public function getLogCount() : int
      {
         return this.logCount;
      }
      
      public function trace(param1:String, ... rest) : void
      {
         if(Log.bTrace)
         {
            if(Log.glbTraceChanged)
            {
               this._log(LogType.TRACE,param1,rest);
            }
            else if(Log.cfgChanged)
            {
               if(logConfig.logTrace(this.clsName))
               {
                  this._log(LogType.TRACE,param1,rest);
               }
            }
            else if(this.bTrace)
            {
               this._log(LogType.TRACE,param1,rest);
            }
         }
      }
      
      public function error(param1:String, ... rest) : void
      {
         if(Log.bError)
         {
            if(Log.glbErrorChanged)
            {
               this._log(LogType.ERROR,param1,rest);
            }
            else if(Log.cfgChanged)
            {
               if(logConfig.logError(this.clsName))
               {
                  this._log(LogType.ERROR,param1,rest);
               }
            }
            else if(this.bError)
            {
               this._log(LogType.ERROR,param1,rest);
            }
         }
      }
      
      public function warn(param1:String, ... rest) : void
      {
         if(Log.bWarn)
         {
            if(Log.glbWarnChanged)
            {
               this._log(LogType.WARN,param1,rest);
            }
            else if(Log.cfgChanged)
            {
               if(logConfig.logWarn(this.clsName))
               {
                  this._log(LogType.WARN,param1,rest);
               }
            }
            else if(this.bWarn)
            {
               this._log(LogType.WARN,param1,rest);
            }
         }
      }
      
      public function debug(param1:String, ... rest) : void
      {
         if(Log.bDebug)
         {
            if(Log.glbDebugChanged)
            {
               this._log(LogType.DEBUG,param1,rest);
            }
            else if(Log.cfgChanged)
            {
               if(logConfig.logDebug(this.clsName))
               {
                  this._log(LogType.DEBUG,param1,rest);
               }
            }
            else if(this.bDebug)
            {
               this._log(LogType.DEBUG,param1,rest);
            }
         }
      }
      
      public function exthrow(param1:String, ... rest) : void
      {
         var _loc4_:String = null;
         var _loc3_:Boolean = false;
         if(Log.bThrow)
         {
            if(Log.cfgChanged)
            {
               if(logConfig.logThrow(this.clsName))
               {
                  _loc3_ = true;
               }
            }
            else if(this.bThrow)
            {
               _loc3_ = true;
            }
         }
         if(_loc3_)
         {
            this._log(LogType.EXTHROW,param1,rest);
            _loc4_ = this.clsName + "." + param1 + "() " + rest.toString();
            throw "抛出异常：" + _loc4_;
         }
         if(Log.bError)
         {
            if(Log.cfgChanged)
            {
               if(logConfig.logError(this.clsName))
               {
                  this._log(LogType.ERROR,param1,rest);
               }
            }
            else if(this.bError)
            {
               this._log(LogType.ERROR,param1,rest);
            }
         }
      }
      
      public function fatal(param1:String, ... rest) : void
      {
         if(Log.bFatal)
         {
            if(Log.glbFatalChanged)
            {
               this._log(LogType.FATAL,param1,rest);
            }
            else if(Log.cfgChanged)
            {
               if(logConfig.logFatal(this.clsName))
               {
                  this._log(LogType.FATAL,param1,rest);
               }
            }
            else if(this.bFatal)
            {
               this._log(LogType.FATAL,param1,rest);
            }
         }
      }
      
      public function log(param1:String, param2:String, param3:String, ... rest) : void
      {
         ++this.logCount;
         Log.outLog(this.curDate.toTimeString(),param1,param2,param3,rest);
      }
      
      private function _log(param1:String, param2:String, param3:Array) : void
      {
         if(param2 != null)
         {
            this.funName = param2;
         }
         ++this.logCount;
         var _loc4_:Date = new Date();
         var _loc5_:String = _loc4_.hours + ":" + _loc4_.minutes + ":" + _loc4_.seconds + "." + int(_loc4_.milliseconds);
         Log.outLog(_loc5_,param1,this.clsName,this.funName,param3);
      }
   }
}

import flash.net.SharedObject;
import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;

class IdeLog
{
   
   public function IdeLog()
   {
      super();
   }
   
   public static function out(param1:String) : void
   {
      trace(param1);
   }
}

class SOLog
{
   
   private static var ms_so:SharedObject;
   
   private static var ms_log:Array = [];
   
   public function SOLog()
   {
      super();
   }
   
   private static function getLSOName(param1:String = null) : String
   {
      var _loc2_:* = "";
      _loc2_ = getQualifiedClassName(Log);
      _loc2_ = _loc2_.replace("::",".");
      if(param1 != null && param1 != "")
      {
         _loc2_ = _loc2_ + "[" + param1 + "]";
      }
      return _loc2_;
   }
   
   public static function ready(param1:Object) : void
   {
      var list:Dictionary = null;
      var date:Date = null;
      var time:String = null;
      var keepDate:int = 0;
      var timeOld:String = null;
      var param:Object = param1;
      var name:String = "";
      if(param == null)
      {
         return;
      }
      if(param.hasOwnProperty("name"))
      {
         name = getLSOName(param["name"]);
      }
      else
      {
         name = getLSOName(null);
      }
      try
      {
         ms_so = SharedObject.getLocal(name,"/");
      }
      catch(e:Error)
      {
         return;
      }
      if(ms_so)
      {
         if(ms_so.data.hasOwnProperty("list"))
         {
            list = ms_so.data["list"];
         }
         if(list == null)
         {
            list = new Dictionary();
            ms_so.data["list"] = list;
         }
         date = new Date();
         time = getTimeString(date);
         keepDate = 0;
         if(param.hasOwnProperty("keepDate"))
         {
            keepDate = Number(param["keepDate"]);
            if(keepDate > 0)
            {
               date.date -= keepDate;
               timeOld = getTimeString(date);
               clearOldLog(list,timeOld);
            }
         }
         list[time] = ms_log;
      }
   }
   
   public static function getLogList(param1:String) : Dictionary
   {
      var ret:Dictionary = null;
      var so:SharedObject = null;
      var name:String = param1;
      ret = null;
      name = getLSOName(name);
      try
      {
         so = SharedObject.getLocal(name,"/");
      }
      catch(e:Error)
      {
         return ret;
      }
      if(so != null)
      {
         ret = so.data["list"];
      }
      return ret;
   }
   
   private static function getTimeString(param1:Date) : String
   {
      if(param1.date < 10)
      {
         "0" + param1.date.toString();
      }
      else
      {
         param1.date.toString();
      }
      return param1.fullYear + "." + num2string(param1.month + 1) + "." + num2string(param1.date) + "_" + num2string(param1.hours) + ":" + num2string(param1.minutes) + ":" + num2string(param1.seconds);
   }
   
   private static function num2string(param1:int) : String
   {
      return param1 < 10 ? "0" + param1.toString() : param1.toString();
   }
   
   private static function clearOldLog(param1:Dictionary, param2:String) : void
   {
      var _loc4_:String = null;
      var _loc5_:int = 0;
      var _loc3_:Array = new Array();
      for(_loc4_ in param1)
      {
         if(_loc4_ < param2)
         {
            _loc3_.push(_loc4_);
         }
      }
      _loc5_ = 0;
      while(_loc5_ < _loc3_.length)
      {
         _loc4_ = _loc3_[_loc5_];
         delete param1[_loc4_];
         _loc5_++;
      }
   }
   
   public static function out(param1:String) : void
   {
      ms_log.push(param1);
   }
}
