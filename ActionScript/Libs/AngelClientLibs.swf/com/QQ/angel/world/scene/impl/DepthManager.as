package com.QQ.angel.world.scene.impl
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class DepthManager
   {
      
      protected var container:DisplayObjectContainer;
      
      protected var delay:uint = 400;
      
      protected var timer:Timer;
      
      protected var children:Array;
      
      protected var depathUpdate:Boolean = false;
      
      protected var numChildren:int;
      
      protected var dirty:Boolean = false;
      
      public function DepthManager(param1:DisplayObjectContainer)
      {
         super();
         this.container = param1;
         this.timer = new Timer(this.delay);
         this.timer.addEventListener(TimerEvent.TIMER,this.timerHander);
         this.initChildren();
         this.timer.start();
      }
      
      public function setEnabled(param1:Boolean = false) : void
      {
         if(this.timer == null)
         {
            return;
         }
         if(param1)
         {
            this.timer.start();
         }
         else
         {
            this.timer.stop();
         }
      }
      
      public function dispose() : void
      {
         this.timer.removeEventListener(TimerEvent.TIMER,this.timerHander);
         this.timer.stop();
         this.container.removeEventListener(Event.ADDED,this.addChildHandler);
         this.container.removeEventListener(Event.REMOVED,this.removeChildHandler);
         this.children = null;
         this.timer = null;
      }
      
      public function addChildHandler(param1:Event) : void
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(_loc2_ == null || _loc2_.parent != this.container)
         {
            return;
         }
         this.children.push({
            "obj":_loc2_,
            "deep":this.container.getChildIndex(_loc2_)
         });
         this.numChildren = this.children.length;
      }
      
      public function removeChildHandler(param1:Event) : void
      {
         var _loc5_:Object = null;
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(_loc2_ == null || _loc2_.parent != this.container)
         {
            return;
         }
         var _loc3_:int = int(this.children.length - 1);
         var _loc4_:Boolean = true;
         while(_loc3_ >= 0)
         {
            _loc5_ = this.children[_loc3_];
            if(_loc5_.obj == _loc2_)
            {
               this.children.splice(_loc3_,1);
               _loc4_ = false;
            }
            else if(_loc4_)
            {
               --_loc5_.deep;
            }
            _loc3_--;
         }
         this.numChildren = this.children.length;
      }
      
      protected function initChildren() : void
      {
         this.children = [];
         this.numChildren = this.container.numChildren;
         var _loc1_:int = 0;
         while(_loc1_ < this.numChildren)
         {
            this.children.push({
               "obj":this.container.getChildAt(_loc1_),
               "deep":_loc1_
            });
            _loc1_++;
         }
         this.container.addEventListener(Event.ADDED,this.addChildHandler);
         this.container.addEventListener(Event.REMOVED,this.removeChildHandler);
      }
      
      protected function timerHander(param1:TimerEvent) : void
      {
         var _loc3_:Object = null;
         var _loc4_:DisplayObject = null;
         this.dirty = false;
         this.children.sort(this.sortFun);
         if(this.dirty == false)
         {
            return;
         }
         var _loc2_:int = this.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = this.children[_loc2_];
            _loc4_ = _loc3_.obj;
            if(this.container.getChildIndex(_loc4_) != _loc2_)
            {
               this.container.setChildIndex(_loc4_,_loc2_);
            }
            _loc3_.deep = _loc2_;
            _loc2_--;
         }
      }
      
      protected function sortFun(param1:Object, param2:Object) : int
      {
         var _loc3_:int = int(param1.obj.y);
         var _loc4_:int = int(param1.deep);
         var _loc5_:int = int(param2.obj.y);
         var _loc6_:int = int(param2.deep);
         if(_loc3_ > _loc5_)
         {
            if(_loc4_ < _loc6_)
            {
               this.dirty = true;
            }
            return 1;
         }
         if(_loc3_ < _loc5_)
         {
            if(_loc4_ > _loc6_)
            {
               this.dirty = true;
            }
            return -1;
         }
         if(param1.obj.name > param2.obj.name)
         {
            if(_loc4_ < _loc6_)
            {
               this.dirty = true;
            }
            return 1;
         }
         return -1;
      }
   }
}

