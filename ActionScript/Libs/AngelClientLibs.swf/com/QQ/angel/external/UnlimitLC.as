package com.QQ.angel.external
{
   import flash.events.AsyncErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.SecurityErrorEvent;
   import flash.events.StatusEvent;
   import flash.events.TimerEvent;
   import flash.net.LocalConnection;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class UnlimitLC extends EventDispatcher
   {
      
      private static var __maxBytes:uint = 35 * 1024;
      
      private var __lc:LocalConnection;
      
      private var __client:Object;
      
      private var __innercExecCache:Dictionary;
      
      private var __cSend:Object;
      
      private var __sendList:Array;
      
      private var __isWorking:Boolean;
      
      private var __splitTime:int;
      
      private var __timer:Timer;
      
      public function UnlimitLC(param1:int = 50)
      {
         super();
         this.__lc = new LocalConnection();
         this.__lc.addEventListener(StatusEvent.STATUS,this.eventHandler);
         this.__lc.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.eventHandler);
         this.__lc.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.eventHandler);
         this.__sendList = new Array();
         this.__isWorking = false;
         this.__timer = new Timer(param1 || 100);
         this.__timer.addEventListener(TimerEvent.TIMER,this.onTimeHandler);
      }
      
      public function connect(param1:String) : void
      {
         this.__lc.connect(param1);
      }
      
      public function allowDomain(... rest) : void
      {
         var _loc2_:Function = this.__lc.allowDomain;
         _loc2_.apply(this.__lc,rest);
      }
      
      public function allowInsecureDomain(... rest) : void
      {
         var _loc2_:Function = this.__lc.allowInsecureDomain;
         _loc2_.apply(this.__lc,rest);
      }
      
      public function close() : void
      {
         this.__lc.close();
      }
      
      public function send(param1:String, param2:String, ... rest) : void
      {
         this.__sendList.push({
            "name":param1,
            "method":param2,
            "args":rest
         });
         this.sending();
      }
      
      public function get domain() : String
      {
         return this.__lc.domain;
      }
      
      public function set client(param1:Object) : void
      {
         this.__client = param1;
         this.__lc.client = this;
      }
      
      public function get client() : Object
      {
         return this.__client;
      }
      
      private function get __cExecCache() : Dictionary
      {
         if(this.__innercExecCache == null)
         {
            this.__innercExecCache = new Dictionary();
         }
         return this.__innercExecCache;
      }
      
      public function onCallBegin(param1:String, param2:int) : void
      {
         this.__cExecCache[param1] = {
            "name":param1,
            "argsNum":param2,
            "args":new Array()
         };
      }
      
      public function onArgData(param1:String, param2:ByteArray, param3:int, param4:Number, param5:Number) : void
      {
         var _loc7_:ByteArray = null;
         if(this.__cExecCache[param1] == null)
         {
            return;
         }
         var _loc6_:Object = this.__cExecCache[param1];
         if(_loc6_.args[param3] == null)
         {
            _loc7_ = _loc6_.args[param3] = new ByteArray();
         }
         _loc7_.writeBytes(param2,0,param2.bytesAvailable);
      }
      
      public function onArgEnd(param1:String, param2:int) : void
      {
         if(this.__cExecCache[param1] == null)
         {
            return;
         }
         var _loc3_:Object = this.__cExecCache[param1];
         var _loc4_:ByteArray = _loc3_.args[param2] as ByteArray;
         if(_loc4_ == null)
         {
            _loc3_.args[param2] = null;
         }
         else
         {
            _loc4_.position = 0;
            _loc3_.args[param2] = _loc4_.readObject();
         }
      }
      
      public function onCallEnd(param1:String) : void
      {
         if(this.client == null || this.client[param1] == null)
         {
            return;
         }
         var _loc2_:Function = this.client[param1];
         _loc2_.apply(this.client,this.__cExecCache[param1].args);
         this.__cExecCache[param1] = null;
         delete this.__cExecCache[param1];
      }
      
      private function eventHandler(param1:Event) : void
      {
         dispatchEvent(param1);
      }
      
      private function sending() : void
      {
         if(this.__isWorking)
         {
            return;
         }
         if(this.__sendList.length == 0)
         {
            this.__isWorking = false;
            return;
         }
         this.__isWorking = true;
         this.__cSend = this.__sendList.shift();
         this.__lc.send(this.__cSend.name,"onCallBegin",this.__cSend.method,this.__cSend.args.length);
         this.sendArgs();
      }
      
      private function sendArgs() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:Array = null;
         if(this.__cSend.cargList != null && this.__cSend.cargList.length != 0)
         {
            _loc2_ = this.__cSend.cargList as Array;
            _loc1_ = _loc2_.shift();
            _loc2_["sendBytes"] += _loc1_.length;
            this.__lc.send(this.__cSend.name,"onArgData",this.__cSend.method,_loc1_,this.__cSend["index"],_loc2_["sendBytes"],_loc2_["totalBytes"]);
         }
         else
         {
            if(this.__cSend.args == null || this.__cSend.args.length == 0)
            {
               this.__timer.stop();
               this.__lc.send(this.__cSend.name,"onCallEnd",this.__cSend.method);
               this.__cSend = null;
               this.__isWorking = false;
               this.sending();
               return;
            }
            if(this.__cSend.cargList != null)
            {
               this.__lc.send(this.__cSend.name,"onArgEnd",this.__cSend.method,this.__cSend["index"]);
            }
            this.__cSend.cargList = this.splitBytes(this.__cSend.args.shift());
            if(this.__cSend["index"] != null)
            {
               this.__cSend["index"] += 1;
            }
            else
            {
               this.__cSend["index"] = 0;
            }
            this.__cSend.cargList["sendBytes"] = 0;
            this.__timer.start();
         }
      }
      
      private function splitBytes(param1:Object) : Array
      {
         var _loc4_:ByteArray = null;
         var _loc2_:Array = new Array();
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeObject(param1);
         _loc3_.position = 0;
         _loc2_["totalBytes"] = _loc3_.bytesAvailable;
         while(_loc3_.bytesAvailable > 0)
         {
            _loc4_ = new ByteArray();
            _loc3_.readBytes(_loc4_,0,Math.min(_loc3_.bytesAvailable,__maxBytes));
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public function onTimeHandler(param1:TimerEvent) : void
      {
         this.sendArgs();
      }
      
      public function debug(param1:String) : void
      {
      }
   }
}

