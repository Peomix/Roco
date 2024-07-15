package com.QQ.angel.world.npc.chip
{
   import com.QQ.angel.api.world.IAIChip;
   import com.QQ.angel.api.world.action.IActor;
   import com.QQ.angel.api.world.scene.IMotionItem;
   import com.QQ.angel.world.actions.WalkAction;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class RandomMoveAIChip implements IAIChip
   {
       
      
      protected var instance:IMotionItem;
      
      protected var area:Rectangle;
      
      protected var minPos:Point;
      
      protected var maxPos:Point;
      
      protected var lastMoveTime:int;
      
      protected var persistTime:int = 7000;
      
      protected var maxLen:int = 150;
      
      public function RandomMoveAIChip(param1:Rectangle)
      {
         super();
         this.area = param1;
         this.minPos = new Point(param1.x,param1.y);
         this.maxPos = new Point(param1.x + param1.width,param1.y + param1.height);
         this.lastMoveTime = getTimer() - 6000 - 1000 * Math.random();
         this.persistTime += int(5000 * Math.random());
      }
      
      protected function randomMoveNow() : void
      {
         this.lastMoveTime = getTimer();
         var _loc1_:Point = this.instance.getPosition();
         var _loc2_:Point = new Point();
         var _loc3_:Number = Math.random() * Math.PI * 2;
         var _loc4_:Number = this.maxLen * Math.random();
         _loc2_.x = int(_loc1_.x + _loc4_ * Math.cos(_loc3_));
         _loc2_.y = int(_loc1_.y + _loc4_ * Math.sin(_loc3_));
         if(this.inRect(_loc2_))
         {
            (this.instance as IActor).act(new WalkAction([_loc1_,_loc2_]));
         }
      }
      
      protected function inRect(param1:Point) : Boolean
      {
         if(param1 == null || this.area == null)
         {
            return false;
         }
         if(param1.x < this.maxPos.x && param1.y < this.maxPos.y && param1.x > this.minPos.x && param1.y > this.minPos.y)
         {
            return true;
         }
         return false;
      }
      
      public function getType() : int
      {
         return 1;
      }
      
      public function attach(param1:Object) : void
      {
         this.instance = param1 as IMotionItem;
      }
      
      public function active(param1:Object = null) : void
      {
         if(this.instance == null)
         {
            return;
         }
         if(getTimer() - this.lastMoveTime > this.persistTime)
         {
            this.randomMoveNow();
         }
      }
      
      public function dispose() : void
      {
      }
   }
}
