package com.QQ.angel.api.world.action
{
   import flash.utils.getTimer;
   
   public class AbstractDurAction extends AbstractAction
   {
       
      
      protected var durTimes:int;
      
      protected var startTime:int = -1;
      
      public function AbstractDurAction(param1:int, param2:int = -1)
      {
         super(param1);
         this.durTimes = param2;
      }
      
      override public function onAct(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(this.durTimes != -1)
         {
            _loc2_ = getTimer();
            if(this.startTime == -1)
            {
               this.startTime = _loc2_;
               return;
            }
            if(this.durTimes < _loc2_ - this.startTime)
            {
               this.onTimeUp();
            }
         }
      }
      
      protected function onTimeUp() : void
      {
         giveUp();
         setFinished(true);
      }
   }
}
