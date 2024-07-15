package com.QQ.angel.media.audio
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class AudioTimer
   {
       
      
      public var onTimeUp:Function;
      
      private var _timer:Timer;
      
      public function AudioTimer(param1:Function = null)
      {
         super();
         this.onTimeUp = param1;
         this._timer = new Timer(0,1);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      public function dispose() : void
      {
         if(this._timer == null)
         {
            return;
         }
         this._timer.reset();
         this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
         this._timer = null;
      }
      
      public function reset() : void
      {
         this._timer.reset();
      }
      
      public function start() : void
      {
         this._timer.start();
      }
      
      public function stop() : void
      {
         this._timer.stop();
      }
      
      public function get delay() : int
      {
         return Math.floor(this._timer.delay / 1000);
      }
      
      public function set delay(param1:int) : void
      {
         var seconds:int = param1;
         try
         {
            this._timer.delay = seconds * 1000;
         }
         catch(e:Error)
         {
         }
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         if(this.onTimeUp != null)
         {
            this.onTimeUp();
         }
      }
   }
}
