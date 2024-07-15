package com.QQ.angel.world.actions
{
   import com.QQ.angel.api.world.action.AbstractAction;
   import com.QQ.angel.api.world.action.IAction;
   import com.QQ.angel.api.world.role.RoleMotion;
   import com.QQ.angel.api.world.scene.IMotionItem;
   import com.QQ.angel.utils.AMath;
   import com.QQ.angel.world.events.ElementEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class WalkAction extends AbstractAction
   {
      
      public static var quotiety:Number = 0.04;
       
      
      public var paths:Array;
      
      protected var pathIndex:int = 0;
      
      protected var pathLength:int = 0;
      
      protected var currentPos:Point;
      
      protected var aimPoint:Point;
      
      protected var disAim2:uint;
      
      protected var isLastIndex:Boolean = false;
      
      protected var velocity:Point;
      
      protected var absSpeed:Number;
      
      protected var params:Object;
      
      protected var moveLogic:Function;
      
      protected var moveReady:Function = null;
      
      protected var motionItem:IMotionItem;
      
      public var lastTime:int = -1;
      
      public function WalkAction(param1:Array)
      {
         this.velocity = new Point();
         this.moveLogic = this.runWalking;
         super(ActionsIntro.WalkAction);
         this.paths = param1;
         this.pathLength = param1.length;
         this.pathIndex = int(param1["position"]);
      }
      
      protected function nextPathMoving() : void
      {
         ++this.pathIndex;
         this.paths["position"] = this.pathIndex;
         this.aimPoint = this.paths[this.pathIndex];
         var _loc1_:Point = this.currentPos;
         var _loc2_:Object = AMath.getVector(_loc1_,this.aimPoint);
         var _loc3_:Number = Number(_loc2_.pi);
         this.velocity.x = Math.cos(_loc3_);
         this.velocity.y = Math.sin(_loc3_);
         this.motionItem.setDirection(_loc2_.dir);
         if(this.pathIndex == this.pathLength - 1)
         {
            this.isLastIndex = true;
         }
         this.disAim2 = 4294967295;
         if(this.moveReady != null)
         {
            this.moveReady();
         }
      }
      
      protected function fireItemEvent(param1:Boolean = true) : void
      {
         var _loc2_:ElementEvent = null;
         if(param1)
         {
            _loc2_ = new ElementEvent(ElementEvent.ON_MOVE_START);
            _loc2_.data = this.paths;
         }
         else
         {
            _loc2_ = new ElementEvent(ElementEvent.ON_MOVE_FINISHED);
         }
         this.motionItem.dispatchEvent(_loc2_);
      }
      
      protected function finishMove() : void
      {
         if(this.motionItem.getMotionType() == RoleMotion.WALK)
         {
            this.motionItem.setMotionType(RoleMotion.STAND);
         }
         setFinished(true);
      }
      
      override protected function doReplace(param1:IAction) : void
      {
         var _loc2_:WalkAction = null;
         if(param1 is WalkAction)
         {
            _loc2_ = param1 as WalkAction;
            _loc2_.lastTime = this.lastTime;
            setFinished(true);
         }
         else
         {
            this.giveUp();
         }
      }
      
      protected function runWalking() : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc1_:int = getTimer() - this.lastTime;
         this.lastTime = getTimer();
         var _loc2_:Number = _loc1_ * this.absSpeed;
         var _loc3_:Boolean = false;
         while(_loc2_ >= 0)
         {
            _loc5_ = this.currentPos.x - this.aimPoint.x;
            _loc6_ = this.currentPos.y - this.aimPoint.y;
            this.disAim2 = _loc5_ * _loc5_ + _loc6_ * _loc6_;
            if(_loc2_ * _loc2_ < this.disAim2)
            {
               break;
            }
            this.currentPos.x = this.aimPoint.x;
            this.currentPos.y = this.aimPoint.y;
            _loc4_ = Math.sqrt(this.disAim2);
            _loc2_ -= _loc4_;
            if(this.isLastIndex)
            {
               _loc2_ = 0;
               this.disAim2 = 0;
               _loc3_ = true;
               break;
            }
            this.nextPathMoving();
         }
         if(_loc2_ > 0)
         {
            this.currentPos.x += _loc2_ * this.velocity.x;
            this.currentPos.y += _loc2_ * this.velocity.y;
         }
         this.motionItem.setPosition(this.currentPos);
         if(_loc3_)
         {
            this.finishMove();
         }
      }
      
      protected function flyReady() : void
      {
         var _loc1_:Number = this.aimPoint.x - this.currentPos.x;
         var _loc2_:Number = this.aimPoint.y - this.currentPos.y;
         var _loc3_:Number = Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_);
         var _loc4_:int = _loc3_ * 0.067;
         this.params = [0,this.currentPos.x,this.currentPos.y,_loc1_,_loc2_,_loc4_];
      }
      
      protected function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if((param1 = param1 / (param4 / 2)) < 1)
         {
            return param3 / 2 * param1 * param1 * param1 * param1 + param2;
         }
         return -param3 / 2 * ((param1 = param1 - 2) * param1 * param1 * param1 - 2) + param2;
      }
      
      protected function runFlying() : void
      {
         this.currentPos.x += (this.aimPoint.x - this.currentPos.x) * 0.15;
         this.currentPos.y += (this.aimPoint.y - this.currentPos.y) * 0.15;
         var _loc1_:Number = this.aimPoint.x - this.currentPos.x;
         var _loc2_:Number = this.aimPoint.y - this.currentPos.y;
         this.disAim2 = _loc1_ * _loc1_ + _loc2_ * _loc2_;
         if(this.disAim2 < 10)
         {
            this.currentPos.x = this.aimPoint.x;
            this.currentPos.y = this.aimPoint.y;
            this.motionItem.setPosition(this.currentPos);
            if(!this.isLastIndex)
            {
               this.nextPathMoving();
            }
            else
            {
               this.finishMove();
            }
         }
         else
         {
            this.motionItem.setPosition(this.currentPos);
         }
      }
      
      override public function start(param1:Object) : void
      {
         var _loc2_:Number = NaN;
         this.motionItem = param1 as IMotionItem;
         if(this.pathLength == 1)
         {
            this.currentPos = this.paths[0];
            this.motionItem.setPosition(this.currentPos);
            return;
         }
         this.currentPos = this.motionItem.getPosition();
         if(!this.isLastIndex)
         {
            setFinished(false);
            _loc2_ = this.motionItem.getSpeed();
            if(this.motionItem.getMotionType() != RoleMotion.FLOAT)
            {
               this.motionItem.setMotionType(RoleMotion.WALK);
            }
            else
            {
               this.moveLogic = this.runFlying;
            }
            this.absSpeed = _loc2_ * quotiety;
            if(this.lastTime == -1)
            {
               this.lastTime = getTimer();
            }
            this.nextPathMoving();
            this.fireItemEvent();
         }
      }
      
      override public function onAct(param1:Object) : void
      {
         this.moveLogic();
      }
      
      override public function giveUp() : Boolean
      {
         this.finishMove();
         return true;
      }
   }
}
