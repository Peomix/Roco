package com.tencent.fge.utils
{
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class AsyProcess
   {
       
      
      private var m_asyTimer:Timer;
      
      private var m_lstAsyInvoke:Array;
      
      public function AsyProcess(param1:int)
      {
         this.m_lstAsyInvoke = new Array();
         super();
         this.m_asyTimer = new Timer(param1);
         this.m_asyTimer.addEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      public function asyInvoke(param1:Function, ... rest) : void
      {
         var _loc3_:Invoke = new Invoke(param1);
         _loc3_.arg = rest;
         this.m_lstAsyInvoke.push(_loc3_);
         if(!this.m_asyTimer.running)
         {
            this.m_asyTimer.start();
         }
      }
      
      public function asyInvokeUnique(param1:Function, ... rest) : void
      {
         var _loc3_:Invoke = null;
         var _loc4_:int = 0;
         while(_loc4_ < this.m_lstAsyInvoke.length)
         {
            _loc3_ = this.m_lstAsyInvoke[_loc4_];
            if(_loc3_.fun == param1)
            {
               _loc3_.arg = rest;
               break;
            }
            _loc4_++;
         }
         if(_loc4_ >= this.m_lstAsyInvoke.length)
         {
            _loc3_ = new Invoke(param1);
            _loc3_.arg = rest;
            this.m_lstAsyInvoke.push(_loc3_);
         }
         if(!this.m_asyTimer.running)
         {
            this.m_asyTimer.start();
         }
      }
      
      private function onTimer(param1:Event) : void
      {
         var _loc4_:Invoke = null;
         var _loc2_:Array = this.m_lstAsyInvoke.concat();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            (_loc4_ = _loc2_[_loc3_]).execute();
            _loc3_++;
         }
         this.m_lstAsyInvoke = [];
      }
   }
}
