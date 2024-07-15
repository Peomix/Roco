package com.QQ.angel.api.world.action
{
   public class AbstractAction implements IAction
   {
       
      
      protected var finished:Boolean;
      
      protected var actionType:int = 0;
      
      public function AbstractAction(param1:int)
      {
         super();
         this.actionType = param1;
         this.finished = true;
      }
      
      public function start(param1:Object) : void
      {
      }
      
      public function replace(param1:IAction) : Boolean
      {
         var _loc2_:Boolean = this.canReplace(param1);
         if(_loc2_)
         {
            this.doReplace(param1);
         }
         return _loc2_;
      }
      
      public function isLockedType(param1:int) : Boolean
      {
         return false;
      }
      
      public function canReplace(param1:IAction) : Boolean
      {
         var _loc2_:* = param1.getType() & this.getType();
         return _loc2_ > 0 && _loc2_ < 16384;
      }
      
      protected function doReplace(param1:IAction) : void
      {
         this.giveUp();
      }
      
      public function getType() : int
      {
         return this.actionType;
      }
      
      public function giveUp() : Boolean
      {
         this.setFinished(true);
         return true;
      }
      
      public function setFinished(param1:Boolean) : void
      {
         this.finished = param1;
      }
      
      public function isFinished() : Boolean
      {
         return this.finished;
      }
      
      public function onAct(param1:Object) : void
      {
      }
   }
}
