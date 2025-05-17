package com.QQ.angel.api.world.action
{
   import com.QQ.angel.api.events.ITickListener;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class TickManager extends EventDispatcher implements ITickListener
   {
      
      protected var ticksList:Array;
      
      public function TickManager()
      {
         super();
         this.ticksList = [];
      }
      
      public function addTick(param1:ITick) : void
      {
         if(this.ticksList.indexOf(param1) != -1)
         {
            return;
         }
         this.ticksList.push(param1);
      }
      
      public function removeTick(param1:ITick) : void
      {
         var _loc2_:int = int(this.ticksList.indexOf(param1));
         if(_loc2_ != -1)
         {
            this.ticksList.splice(_loc2_,1);
         }
      }
      
      public function removeTickByID(param1:uint) : ITick
      {
         var _loc3_:ITick = null;
         var _loc2_:int = int(this.ticksList.length - 1);
         while(_loc2_ >= 0)
         {
            _loc3_ = this.ticksList[_loc2_];
            if(_loc3_.getID() == param1)
            {
               this.ticksList.splice(_loc2_,1);
               return _loc3_;
            }
            _loc2_--;
         }
         return null;
      }
      
      public function getTickByID(param1:uint) : ITick
      {
         var _loc3_:ITick = null;
         var _loc2_:int = int(this.ticksList.length - 1);
         while(_loc2_ >= 0)
         {
            _loc3_ = this.ticksList[_loc2_];
            if(_loc3_.getID() == param1)
            {
               return _loc3_;
            }
            _loc2_--;
         }
         return null;
      }
      
      public function onTickEvent(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = int(this.ticksList.length);
         while(_loc2_ < _loc3_)
         {
            (this.ticksList[_loc2_] as ITick).onTick();
            _loc2_++;
         }
      }
      
      public function clear() : void
      {
         this.ticksList = [];
      }
   }
}

