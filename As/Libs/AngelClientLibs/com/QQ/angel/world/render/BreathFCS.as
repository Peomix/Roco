package com.QQ.angel.world.render
{
   public class BreathFCS extends MotionFCS
   {
       
      
      protected var fristRandom:int;
      
      public function BreathFCS(param1:int, param2:Array)
      {
         super(param1,param2);
         this.fristRandom = param2[0];
      }
      
      override public function reset() : void
      {
         frameTimes[0] = this.fristRandom + Math.round(this.fristRandom * Math.random());
      }
   }
}
