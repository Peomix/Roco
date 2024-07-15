package com.QQ.angel.world.actions
{
   import com.QQ.angel.api.world.action.AbstractAction;
   import com.QQ.angel.api.world.role.RoleMotion;
   import com.QQ.angel.api.world.scene.IMotionItem;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.world.role.AbstractARole;
   import flash.geom.Point;
   
   public class StopWalkAction extends AbstractAction
   {
       
      
      protected var aimPos:Point;
      
      public function StopWalkAction(param1:Point)
      {
         super(ActionsIntro.WalkAction);
         this.aimPos = param1;
      }
      
      override public function start(param1:Object) : void
      {
         var _loc2_:RoleData = null;
         var _loc3_:IMotionItem = null;
         if(param1 is AbstractARole)
         {
            _loc2_ = param1.getData() as RoleData;
            if(_loc2_.motionType == RoleMotion.S_MAGIC)
            {
               param1.setMotionType(RoleMotion.STAND);
            }
            else if(_loc2_.motionType == RoleMotion.F_MAGIC)
            {
               param1.setMotionType(RoleMotion.FLOAT);
            }
         }
         if(this.aimPos != null)
         {
            _loc3_ = param1 as IMotionItem;
            _loc3_.setPosition(this.aimPos);
            this.aimPos = null;
         }
      }
   }
}
