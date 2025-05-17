package com.QQ.angel.plugs.Login.view
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.utils.Timer;
   
   public class LoadingEffect extends Sprite
   {
      
      private var cubs:uint = 5;
      
      private var _step:int = 0;
      
      private var _timer:Timer = new Timer(60,0);
      
      private var blueFilter:GlowFilter;
      
      private var yellowFilter:GlowFilter;
      
      private var _spec:uint = 5;
      
      private var _side:int = 1;
      
      private var cubsArr:Array;
      
      public function LoadingEffect()
      {
         super();
         init();
      }
      
      private function createCube(param1:uint, param2:uint, param3:uint = 0, param4:Array = null) : Shape
      {
         var _loc5_:Shape = new Shape();
         _loc5_.graphics.beginFill(param3,1);
         _loc5_.graphics.drawRoundRect(0,0,param1,param2,5,5);
         _loc5_.graphics.endFill();
         _loc5_.filters = param4;
         return _loc5_;
      }
      
      public function finalize() : void
      {
         _timer.stop();
      }
      
      private function init() : void
      {
         var _loc1_:Shape = null;
         cubsArr = new Array();
         blueFilter = new GlowFilter(65535,1);
         yellowFilter = new GlowFilter(16776960,1);
         _timer.addEventListener(TimerEvent.TIMER,onTimer);
         var _loc2_:uint = 0;
         while(_loc2_ < cubs)
         {
            _loc1_ = createCube(10,10,16711884,[blueFilter]);
            _loc1_.x = _loc2_ * (_spec + _loc1_.width);
            cubsArr.push(addChild(_loc1_));
            _loc2_++;
         }
         _timer.start();
      }
      
      private function draw() : void
      {
         (cubsArr[_step] as Shape).filters = [blueFilter];
         _step += _side;
         if(_step >= 5)
         {
            _side = -1;
            _step += _side;
         }
         if(_step < 0)
         {
            _side = 1;
            _step += _side;
         }
         (cubsArr[_step] as Shape).filters = [yellowFilter];
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         draw();
      }
   }
}

