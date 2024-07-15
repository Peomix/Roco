package com.QQ.angel.api.world.action
{
   public class QueueAction extends AbstractAction
   {
       
      
      protected var queueActions:Array;
      
      protected var curAction:IAction;
      
      protected var index:int;
      
      public function QueueAction(... rest)
      {
         super(0);
         this.queueActions = rest as Array;
         this.index = -1;
      }
      
      protected function onLastlyAction(param1:IAction) : void
      {
      }
      
      override public function start(param1:Object) : void
      {
         ++this.index;
         if(this.queueActions == null || this.index >= this.queueActions.length)
         {
            setFinished(true);
            return;
         }
         this.curAction = this.queueActions[this.index];
         if(this.index == this.queueActions.length - 1)
         {
            this.onLastlyAction(this.curAction);
         }
         this.actionType = this.curAction.getType();
         this.curAction.start(param1);
      }
      
      override public function onAct(param1:Object) : void
      {
         if(this.curAction.isFinished())
         {
            this.start(param1);
         }
         else
         {
            this.curAction.onAct(param1);
         }
      }
      
      override public function giveUp() : Boolean
      {
         if(this.curAction)
         {
            this.curAction.giveUp();
         }
         setFinished(true);
         return true;
      }
   }
}
