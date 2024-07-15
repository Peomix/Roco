package com.QQ.angel.data.entity.combatsys.pool
{
   import com.QQ.angel.data.entity.combatsys.utils.*;
   import com.QQ.angel.data.entity.combatsys.vo.*;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class CombatResTimerPool
   {
      
      private static var instance:CombatResTimerPool;
      
      public static const timingPolicy:int = 30;
       
      
      private var _timePool:Dictionary;
      
      private var _timer:Timer;
      
      public function CombatResTimerPool()
      {
         this._timePool = new Dictionary();
         super();
         this._timer = new Timer(timingPolicy * 60 * 1000,0);
         this._timer.addEventListener(TimerEvent.TIMER,this.timerHandler);
      }
      
      public static function getInstance() : CombatResTimerPool
      {
         if(instance == null)
         {
            instance = new CombatResTimerPool();
         }
         return instance;
      }
      
      public function get timePool() : Dictionary
      {
         return this._timePool;
      }
      
      private function timerHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:CombatResVO = null;
         for(_loc2_ in this._timePool)
         {
            _loc3_ = this._timePool[_loc2_];
            _loc3_.display = null;
            _loc3_ = null;
            delete this._timePool[_loc2_];
         }
      }
   }
}
