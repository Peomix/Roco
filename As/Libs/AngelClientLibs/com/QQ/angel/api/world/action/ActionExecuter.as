package com.QQ.angel.api.world.action
{
   public class ActionExecuter implements IActor
   {
       
      
      protected var actor:IActor;
      
      protected var actions:Array;
      
      public function ActionExecuter(param1:IActor)
      {
         super();
         this.actor = param1;
         this.actions = [];
      }
      
      public function onTick(... rest) : void
      {
         var _loc2_:IAction = null;
         var _loc3_:int = int(this.actions.length - 1);
         while(_loc3_ >= 0)
         {
            _loc2_ = this.actions[_loc3_];
            if(_loc2_.isFinished())
            {
               this.actions.splice(_loc3_,1);
            }
            else
            {
               _loc2_.onAct(this.actor);
            }
            _loc3_--;
         }
      }
      
      public function canExecAction(param1:int) : Boolean
      {
         var _loc2_:IAction = null;
         var _loc3_:int = int(this.actions.length - 1);
         while(_loc3_ >= 0)
         {
            _loc2_ = this.actions[_loc3_];
            if(_loc2_.isLockedType(param1))
            {
               return false;
            }
            _loc3_--;
         }
         return true;
      }
      
      public function act(param1:IAction) : Boolean
      {
         this.tryReplace(param1);
         param1.start(this.actor);
         if(!param1.isFinished())
         {
            this.actions.push(param1);
         }
         return true;
      }
      
      public function getID() : uint
      {
         return 0;
      }
      
      public function clear() : void
      {
         var _loc1_:IAction = null;
         var _loc2_:int = int(this.actions.length - 1);
         while(_loc2_ >= 0)
         {
            _loc1_ = this.actions[_loc2_];
            _loc1_.giveUp();
            _loc2_--;
         }
         this.actions = [];
      }
      
      protected function tryReplace(param1:IAction) : void
      {
         var _loc2_:IAction = null;
         var _loc3_:int = int(this.actions.length - 1);
         while(_loc3_ >= 0)
         {
            _loc2_ = this.actions[_loc3_];
            if(_loc2_.getType() == 8 && _loc2_.isFinished())
            {
               this.actions.splice(_loc3_,1);
            }
            else if(_loc2_.replace(param1))
            {
               this.actions.splice(_loc3_,1);
               return;
            }
            _loc3_--;
         }
      }
   }
}
