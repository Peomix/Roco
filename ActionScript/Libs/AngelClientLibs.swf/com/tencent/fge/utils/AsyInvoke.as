package com.tencent.fge.utils
{
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class AsyInvoke extends Invoke
   {
      
      private static var s_lstInvoker:Array = [];
      
      protected static const version:String = "1.0.0";
      
      protected static const author:String = "slicoltang,slicol@qq.com";
      
      protected static const copyright:String = "腾讯计算机系统有限公司";
      
      private var m_asyDelay:Number = 10;
      
      private var m_autoRelease:Boolean = false;
      
      private var m_timer:Timer;
      
      public function AsyInvoke(param1:Function, ... rest)
      {
         super(param1);
         super.arg = rest;
      }
      
      public static function execute(param1:Function, param2:Number, ... rest) : void
      {
         var _loc4_:AsyInvoke = new AsyInvoke(param1,null);
         _loc4_.arg = rest;
         _loc4_.asyDelay = param2;
         _loc4_.execute();
         _loc4_.m_autoRelease = true;
      }
      
      public static function kill(param1:Function, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc5_:AsyInvoke = null;
         var _loc6_:AsyInvoke = null;
         var _loc4_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < s_lstInvoker.length)
         {
            _loc6_ = s_lstInvoker[_loc3_];
            if((Boolean(_loc6_)) && _loc6_.fun == param1)
            {
               _loc4_.push(_loc6_);
            }
            _loc3_++;
         }
         for each(_loc5_ in _loc4_)
         {
            if(param2)
            {
               _loc5_.execute();
            }
            _loc5_.release();
         }
      }
      
      public function get asyDelay() : Number
      {
         return this.m_asyDelay;
      }
      
      public function set asyDelay(param1:Number) : void
      {
         this.m_asyDelay = param1 > 10 ? param1 : 10;
      }
      
      override public function execute() : void
      {
         if(0 > s_lstInvoker.indexOf(this))
         {
            s_lstInvoker.push(this);
         }
         this.m_timer = new Timer(this.m_asyDelay,1);
         this.m_timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this.m_timer.start();
      }
      
      protected function onTimer(param1:Event) : void
      {
         this.m_timer.stop();
         this.m_timer.reset();
         this.m_timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
         super.execute();
         if(this.m_autoRelease)
         {
            this.release();
         }
      }
      
      override public function release() : void
      {
         if(this.m_timer)
         {
            this.m_timer.stop();
            this.m_timer.reset();
            this.m_timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
         }
         var _loc1_:int = int(s_lstInvoker.indexOf(this));
         if(0 <= _loc1_)
         {
            s_lstInvoker.splice(_loc1_,1);
         }
         super.release();
      }
   }
}

