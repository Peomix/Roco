package com.QQ.angel.world.actions
{
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.api.world.scene.IMotionItem;
   import com.QQ.angel.data.entity.WalkAndThenDes;
   import flash.geom.Point;
   
   public class WalkAndThenAction extends WalkAction
   {
       
      
      protected var dis:int = 0;
      
      protected var dis2:int;
      
      protected var lastAim:Point;
      
      protected var callBack:CFunction;
      
      protected var tellStop:CFunction;
      
      public function WalkAndThenAction(param1:WalkAndThenDes)
      {
         super(param1.paths);
         if(param1 == null)
         {
            throw new Error("[WalkAndThenAction] WalkAndThenAction的参数WalkAndThenDes为NULL!!");
         }
         this.dis = param1.dis;
         this.dis2 = this.dis * this.dis;
         this.callBack = param1.callBack;
         this.tellStop = param1.tellStop;
         this.lastAim = paths[pathLength - 1];
      }
      
      protected function thenCall() : void
      {
         if(this.tellStop != null)
         {
            this.tellStop.params.push([currentPos,currentPos]);
            this.tellStop.invoke();
            this.tellStop = null;
         }
         if(this.callBack != null)
         {
            this.callBack.invoke();
            this.callBack = null;
         }
      }
      
      override public function start(param1:Object) : void
      {
         var _loc2_:IMotionItem = param1 as IMotionItem;
         currentPos = _loc2_.getPosition();
         var _loc3_:Number = currentPos.x - this.lastAim.x;
         var _loc4_:Number = currentPos.y - this.lastAim.y;
         if(_loc3_ * _loc3_ + _loc4_ * _loc4_ > this.dis2)
         {
            super.start(param1);
         }
         else
         {
            this.thenCall();
         }
      }
      
      override public function onAct(param1:Object) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         super.onAct(param1);
         var _loc2_:Boolean = false;
         if(isLastIndex && disAim2 != 4294967295)
         {
            if(disAim2 <= this.dis2)
            {
               _loc2_ = true;
            }
         }
         else
         {
            _loc3_ = currentPos.x - this.lastAim.x;
            _loc4_ = currentPos.y - this.lastAim.y;
            if(_loc3_ * _loc3_ + _loc4_ * _loc4_ <= this.dis2)
            {
               _loc2_ = true;
            }
         }
         if(_loc2_)
         {
            finishMove();
            this.thenCall();
         }
      }
   }
}
