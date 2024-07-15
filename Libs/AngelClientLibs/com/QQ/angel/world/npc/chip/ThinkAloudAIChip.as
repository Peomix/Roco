package com.QQ.angel.world.npc.chip
{
   import com.QQ.angel.api.world.IAIChip;
   import com.QQ.angel.api.world.action.IActor;
   import com.QQ.angel.world.actions.SpeakAction;
   import flash.utils.getTimer;
   
   public class ThinkAloudAIChip implements IAIChip
   {
       
      
      protected var words:Array;
      
      protected var actor:IActor;
      
      protected var lastSpeakTime:int;
      
      protected var persistTime:int = 10000;
      
      protected var index:int = 0;
      
      public function ThinkAloudAIChip(param1:Array)
      {
         super();
         this.words = param1;
      }
      
      protected function speakNow() : void
      {
         this.lastSpeakTime = getTimer();
         if(this.actor == null)
         {
            return;
         }
         if(Math.random() > 0.2)
         {
            this.index = int(Math.random() * this.words.length);
            this.actor.act(new SpeakAction(this.words[this.index],6000));
         }
      }
      
      public function getType() : int
      {
         return 3;
      }
      
      public function attach(param1:Object) : void
      {
         this.actor = param1 as IActor;
      }
      
      public function active(param1:Object = null) : void
      {
         if(this.lastSpeakTime == 0)
         {
            this.lastSpeakTime = getTimer();
         }
         if(getTimer() - this.lastSpeakTime >= this.persistTime)
         {
            this.speakNow();
         }
      }
      
      public function dispose() : void
      {
         this.actor = null;
      }
   }
}
