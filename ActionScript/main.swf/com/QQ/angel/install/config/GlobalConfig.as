package com.QQ.angel.install.config
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class GlobalConfig extends EventDispatcher
   {
      
      public static const CONF_LOAD_OK:String = "confLoadOk";
      
      public static const CONF_LOAD_ERROR:String = "confLoadError";
      
      public var IS_DEBUG:Boolean = false;
      
      protected var urlLoader:URLLoader;
      
      protected var ready:Boolean = false;
      
      protected var globalConf:Object;
      
      protected var allConfs:Object;
      
      public function GlobalConfig(param1:Object = null)
      {
         super();
         if(!analyse(param1))
         {
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE,onConfStatesHandler);
         }
      }
      
      public function getInstallPlugins(param1:int) : Array
      {
         return globalConf.Installs[param1];
      }
      
      protected function onConfStatesHandler(param1:Event) : void
      {
         if(param1.type == Event.COMPLETE)
         {
            if(analyse(urlLoader.data))
            {
               dispatchEvent(new Event(CONF_LOAD_OK));
               return;
            }
         }
      }
      
      public function get LogServer() : Object
      {
         return globalConf.ServerInfo.LogServer;
      }
      
      public function getLibsPath(param1:int) : Array
      {
         return globalConf.Libs[param1];
      }
      
      public function get CrossDomain() : Object
      {
         return globalConf.ServerInfo.CrossDomain;
      }
      
      public function get DirServer() : Object
      {
         return globalConf.ServerInfo.DirServer;
      }
      
      public function isReady() : Boolean
      {
         return ready;
      }
      
      public function getGlobalConf() : Object
      {
         return globalConf;
      }
      
      public function getAllConfs() : Object
      {
         return this.allConfs;
      }
      
      public function loadConf(param1:String) : void
      {
         urlLoader.load(new URLRequest(param1));
      }
      
      public function get Confs() : Array
      {
         return globalConf.Confs;
      }
      
      public function setAllConfs(param1:Object) : void
      {
         this.allConfs = param1;
      }
      
      public function getBBSrc() : String
      {
         return globalConf.bbSrc;
      }
      
      public function analyse(param1:Object) : Boolean
      {
         var _loc14_:XML = null;
         var _loc15_:XML = null;
         var _loc16_:XML = null;
         var _loc17_:XML = null;
         if(param1 == null)
         {
            return false;
         }
         globalConf = {};
         var _loc2_:String = String(param1);
         var _loc3_:XML = new XML(_loc2_);
         globalConf.bbSrc = _loc3_.BB[0].@src;
         globalConf.DEFINE = [];
         var _loc4_:XMLList = _loc3_.DEFINE[0].ATTR;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length())
         {
            _loc14_ = _loc4_[_loc5_];
            globalConf.DEFINE.push({
               "name":_loc14_.@name,
               "value":_loc14_.@value
            });
            if("IS_DEBUG" == _loc14_.@name && "1" == _loc14_.@value)
            {
               IS_DEBUG = true;
            }
            _loc5_++;
         }
         var _loc6_:XML = _loc3_.ServerInfo[0];
         globalConf.ServerInfo = {
            "DirServer":{},
            "CrossDomain":{},
            "LogServer":{}
         };
         var _loc7_:XML = _loc6_.DirServer[0];
         globalConf.ServerInfo.DirServer.host = _loc7_.@host;
         globalConf.ServerInfo.DirServer.port = _loc7_.@port;
         var _loc8_:XML = _loc6_.CrossDomain[0];
         globalConf.ServerInfo.CrossDomain.host = _loc8_.@host;
         globalConf.ServerInfo.CrossDomain.port = _loc8_.@port;
         var _loc9_:XML = _loc6_.LogServer[0];
         globalConf.ServerInfo.LogServer.host = _loc9_.@host;
         globalConf.ServerInfo.LogServer.port = _loc9_.@port;
         globalConf.Confs = [];
         var _loc10_:XMLList = _loc3_.Confs[0].Conf;
         _loc5_ = 0;
         while(_loc5_ < _loc10_.length())
         {
            _loc15_ = _loc10_[_loc5_];
            globalConf.Confs.push({
               "name":String(_loc15_.@name),
               "src":String(_loc15_.@src),
               "compress":Boolean(String(_loc15_.@compress))
            });
            _loc5_++;
         }
         globalConf.Libs = [[],[]];
         var _loc11_:XMLList = _loc3_.Libs[0].Lib;
         var _loc12_:String = String(_loc3_.Libs[0].@src);
         _loc5_ = 0;
         while(_loc5_ < _loc11_.length())
         {
            _loc16_ = _loc11_[_loc5_];
            globalConf.Libs[_loc16_.@step].push({
               "name":_loc16_.@name,
               "src":_loc12_ + _loc16_.@src,
               "step":_loc16_.@step
            });
            _loc5_++;
         }
         globalConf.Installs = [[],[]];
         var _loc13_:XMLList = _loc3_.Installs[0].Install;
         _loc5_ = 0;
         while(_loc5_ < _loc13_.length())
         {
            _loc17_ = _loc13_[_loc5_];
            globalConf.Installs[_loc17_.@step].push({
               "name":_loc17_.@name,
               "step":_loc17_.@step
            });
            _loc5_++;
         }
         return true;
      }
      
      public function get DEFINE() : Array
      {
         return globalConf.DEFINE;
      }
      
      public function get PluginConfs() : Array
      {
         return globalConf.PluginConfs;
      }
   }
}

