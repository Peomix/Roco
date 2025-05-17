package com.QQ.angel.ui.core
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol411")]
   public class DMCNums extends MovieClip
   {
      
      protected var val:int = 0;
      
      protected var nextNum:DMCNums;
      
      protected var nextVal:int;
      
      public function DMCNums()
      {
         super();
         gotoAndStop(this.val + 1);
      }
      
      public function setNextNumMC(param1:DMCNums, param2:int) : void
      {
         this.nextNum = param1;
         this.nextVal = param2;
         this.gotoAndStop(1);
      }
      
      public function setValue(param1:int, param2:Boolean = false) : void
      {
         this.val = param1 % 10;
         if(param2)
         {
            this.addEventListener(Event.ENTER_FRAME,this.onCheckStop);
            this.gotoAndPlay(1);
         }
         else
         {
            gotoAndStop(this.val + 1);
         }
      }
      
      public function dispose() : void
      {
         if(hasEventListener(Event.ENTER_FRAME))
         {
            removeEventListener(Event.ENTER_FRAME,this.onCheckStop);
         }
         stop();
      }
      
      protected function onCheckStop(param1:Event) : void
      {
         if(currentFrame - 1 == this.val)
         {
            gotoAndStop(this.val + 1);
            removeEventListener(Event.ENTER_FRAME,this.onCheckStop);
            if(this.nextNum != null)
            {
               this.nextNum.setValue(this.nextVal,true);
               this.nextNum = null;
               this.nextVal = 0;
            }
         }
      }
   }
}

