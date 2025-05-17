package com.QQ.angel.world.npc.chip
{
   import com.QQ.angel.api.world.IAIChip;
   import com.QQ.angel.api.world.action.IActor;
   import com.QQ.angel.api.world.role.Direction;
   import com.QQ.angel.api.world.scene.IElementView;
   import com.QQ.angel.api.world.scene.IMotionItem;
   import com.QQ.angel.data.entity.WalkAndThenDes;
   import com.QQ.angel.world.actions.StopWalkAction;
   import com.QQ.angel.world.actions.WalkAndThenAction;
   import com.QQ.angel.world.events.ElementEvent;
   import com.QQ.angel.world.events.ElementViewEvent;
   import flash.geom.Point;
   
   public class FollowAIChip implements IAIChip
   {
      
      protected var master:IMotionItem;
      
      protected var masterView:IElementView;
      
      protected var instance:IMotionItem;
      
      protected var isMasterMove:Boolean = false;
      
      protected var wtdes:WalkAndThenDes = new WalkAndThenDes();
      
      protected var masterPaths:Array;
      
      public function FollowAIChip()
      {
         super();
         this.wtdes.dis = 50;
      }
      
      protected function onMotionChange(param1:ElementViewEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.data as int;
         if(_loc2_ == 0 || _loc2_ == 2)
         {
            _loc3_ = this.instance.getMotionType();
            if(_loc2_ == 2 && _loc3_ != 2 || _loc2_ != 2 && _loc3_ == 2)
            {
               this.instance.setMotionType(_loc2_);
            }
         }
      }
      
      protected function onItemMove(param1:ElementEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         if(_loc2_.length < 2)
         {
            return;
         }
         var _loc3_:Point = this.instance.getPosition();
         var _loc4_:Point = _loc2_[_loc2_.length - 1];
         var _loc5_:Number = _loc3_.x - _loc4_.x;
         var _loc6_:Number = _loc3_.y - _loc4_.y;
         if(_loc5_ * _loc5_ + _loc6_ * _loc6_ < 3000)
         {
            (this.instance as IActor).act(new StopWalkAction(null));
            return;
         }
         this.wtdes.paths = _loc2_.concat();
         this.wtdes.paths.unshift(_loc3_);
         (this.instance as IActor).act(new WalkAndThenAction(this.wtdes));
      }
      
      protected function masterNewPosition(param1:ElementEvent) : void
      {
         var _loc2_:Point = this.master.getPosition();
         switch(this.master.getDirection())
         {
            case Direction.FRONT:
               _loc2_.x += 50;
               break;
            case Direction.BACK:
               _loc2_.x -= 50;
               break;
            case Direction.LEFT:
               _loc2_.x -= 50;
               _loc2_.y -= 50;
               break;
            default:
               _loc2_.y += 50;
         }
         (this.instance as IActor).act(new StopWalkAction(_loc2_));
      }
      
      public function getType() : int
      {
         return 2;
      }
      
      public function setMaster(param1:IMotionItem) : void
      {
         this.master = param1;
         this.master.addEventListener(ElementEvent.ON_MOVE_START,this.onItemMove);
         this.master.addEventListener(ElementEvent.ON_NEW_POSITION,this.masterNewPosition);
         this.masterView = param1.getView() as IElementView;
         this.masterView.addEventListener(ElementViewEvent.ON_MOTION_CHANGE,this.onMotionChange);
      }
      
      public function attach(param1:Object) : void
      {
         this.instance = param1 as IMotionItem;
         this.masterNewPosition(null);
      }
      
      public function active(param1:Object = null) : void
      {
      }
      
      public function dispose() : void
      {
         this.master.removeEventListener(ElementEvent.ON_MOVE_START,this.onItemMove);
         this.master.removeEventListener(ElementEvent.ON_NEW_POSITION,this.masterNewPosition);
         this.masterView.removeEventListener(ElementViewEvent.ON_MOTION_CHANGE,this.onMotionChange);
         this.master = null;
         this.masterView = null;
         this.masterPaths = null;
      }
   }
}

