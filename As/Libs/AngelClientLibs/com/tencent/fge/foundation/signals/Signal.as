package com.tencent.fge.foundation.signals
{
   import com.tencent.fge.foundation.log.client.Log;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getQualifiedClassName;
   
   public class Signal implements ISignal
   {
       
      
      private var m_log:Log;
      
      private var m_logType:int;
      
      private var log:Function = null;
      
      protected var m_valueClasses:Array;
      
      protected var m_lstSlot:Array;
      
      protected var m_lstSlotOnce:Array;
      
      private var m_asyTimer:Timer;
      
      private var m_valueObjectsForAsy:*;
      
      public function Signal(... rest)
      {
         this.m_lstSlot = [];
         this.m_lstSlotOnce = [];
         this.m_valueObjectsForAsy = [];
         super();
         this.m_valueClasses = rest.length == 1 && rest[0] is Array ? rest[0] : rest;
         var _loc2_:int = int(this.m_valueClasses.length);
         while(_loc2_--)
         {
            if(!(this.m_valueClasses[_loc2_] is Class))
            {
               throw new ArgumentError("Invalid [valueClasses] Argument: " + "The " + _loc2_ + " Argument Should Be a Class,  Instead Of :<" + this.m_valueClasses[_loc2_] + ">." + getQualifiedClassName(this.m_valueClasses[_loc2_]));
            }
         }
      }
      
      public function get numListeners() : uint
      {
         return this.m_lstSlot.length;
      }
      
      public function addOnce(param1:Function) : void
      {
         var _loc2_:int = this.m_lstSlotOnce.indexOf(param1);
         if(_loc2_ < 0)
         {
            this.m_lstSlotOnce.push(param1);
         }
      }
      
      public function add(param1:Function) : void
      {
         var _loc2_:int = this.m_lstSlot.indexOf(param1);
         if(_loc2_ < 0)
         {
            this.m_lstSlot.push(param1);
         }
      }
      
      public function remove(param1:Function) : void
      {
         var _loc2_:int = this.m_lstSlot.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.m_lstSlot.splice(_loc2_,1);
         }
         _loc2_ = this.m_lstSlotOnce.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.m_lstSlotOnce.splice(_loc2_,1);
         }
      }
      
      public function removeAll() : void
      {
         this.m_lstSlot.length = 0;
         this.m_lstSlotOnce.length = 0;
      }
      
      public function setLogType(param1:int) : void
      {
         this.m_logType = param1;
         if(param1 > 0 && !this.m_log)
         {
            this.m_log = new Log(this);
            this.log = this.m_log.trace;
         }
         else
         {
            this.log = null;
         }
         switch(param1)
         {
            case Log.TYPE_TRACE:
               this.log = this.m_log.trace;
               break;
            case Log.TYPE_DEBUG:
               this.log = this.m_log.debug;
               break;
            case Log.TYPE_WARN:
               this.log = this.m_log.warn;
               break;
            case Log.TYPE_ERROR:
               this.log = this.m_log.error;
         }
      }
      
      public function dispatchAsy(... rest) : void
      {
         if(this.log != null && this.m_log != null)
         {
            this.log.apply(this.m_log,rest);
         }
         this.m_valueObjectsForAsy = rest;
         if(!this.m_asyTimer)
         {
            this.m_asyTimer = new Timer(1,1);
         }
         this.m_asyTimer.addEventListener(TimerEvent.TIMER,this.onAsyTimer);
         if(!this.m_asyTimer.running)
         {
            this.m_asyTimer.start();
         }
      }
      
      private function onAsyTimer(param1:Event) : void
      {
         this.m_asyTimer.removeEventListener(TimerEvent.TIMER,this.onAsyTimer);
         this.dispatchWorker(this.m_valueObjectsForAsy);
         this.m_valueObjectsForAsy = [];
      }
      
      public function dispatch(... rest) : *
      {
         if(this.log != null && this.m_log != null)
         {
            this.log.apply(this.m_log,rest);
         }
         this.dispatchWorker(rest);
      }
      
      private function dispatchWorker(param1:Array) : void
      {
         var _loc2_:int = int(this.m_valueClasses.length);
         var _loc3_:int = int(param1.length);
         if(_loc3_ < _loc2_)
         {
            throw new ArgumentError("Argument Count is NOT Right: " + "Need " + _loc2_ + " Arguments, But Only " + _loc3_ + ".");
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(!(param1[_loc4_] is this.m_valueClasses[_loc4_] || param1[_loc4_] === null))
            {
               throw new ArgumentError("Argument Type Error : object <" + param1[_loc4_] + "> is not an instance of <" + this.m_valueClasses[_loc4_] + ">.");
            }
            _loc4_++;
         }
         var _loc5_:Array = this.m_lstSlot.concat();
         var _loc6_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            this.execute(_loc5_[_loc6_],param1);
            _loc6_++;
         }
         _loc5_ = this.m_lstSlotOnce.concat();
         this.m_lstSlotOnce.length = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            this.execute(_loc5_[_loc6_],param1);
            _loc6_++;
         }
      }
      
      private function execute(param1:Function, param2:Array) : void
      {
         var _loc3_:int = int(param2.length);
         if(_loc3_ == 0)
         {
            param1();
         }
         else if(_loc3_ == 1)
         {
            param1(param2[0]);
         }
         else if(_loc3_ == 2)
         {
            param1(param2[0],param2[1]);
         }
         else if(_loc3_ == 3)
         {
            param1(param2[0],param2[1],param2[2]);
         }
         else
         {
            param1.apply(null,param2);
         }
      }
   }
}
