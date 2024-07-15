package com.QQ.angel.world.actions
{
   import com.QQ.angel.api.world.IRoleSysAPI;
   import com.QQ.angel.api.world.action.AbstractAction;
   import com.QQ.angel.api.world.action.IActor;
   import com.QQ.angel.api.world.role.IRole;
   import com.QQ.angel.api.world.role.IRoleView;
   import com.QQ.angel.api.world.role.RoleMotion;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.MakeMagicDes;
   import com.QQ.angel.utils.AMath;
   import flash.events.Event;
   
   public class MakeMagicAction extends AbstractAction
   {
       
      
      protected var mmdes:MakeMagicDes;
      
      protected var role:IRole;
      
      public function MakeMagicAction(param1:MakeMagicDes)
      {
         super(ActionsIntro.MakeMagicAction);
         this.mmdes = param1;
      }
      
      protected function startNotRender(param1:Object) : Boolean
      {
         if(__global.SysAPI.getIsRender())
         {
            return false;
         }
         this.onMagicACTHandler(null);
         return true;
      }
      
      override public function start(param1:Object) : void
      {
         var _loc4_:Object = null;
         if(this.startNotRender(param1))
         {
            return;
         }
         this.role = param1 as IRole;
         var _loc2_:IRoleView = this.role.getRoleView();
         _loc2_.addLabelEvent(this.onMagicACTHandler);
         _loc2_.addEndFrameEvent(this.onMagicMVEnd);
         var _loc3_:int = this.role.getMotionType() == RoleMotion.FLOAT ? RoleMotion.F_MAGIC : RoleMotion.S_MAGIC;
         if(this.mmdes.userPos.equals(this.mmdes.aimPos))
         {
            this.role.setMotionType(_loc3_);
         }
         else
         {
            _loc4_ = AMath.getVector(this.mmdes.userPos,this.mmdes.aimPos);
            this.role.setMotionAndDir(_loc3_,_loc4_.dir);
         }
         setFinished(false);
      }
      
      protected function onMagicMVEnd(param1:Event) : void
      {
         this.role.getRoleView().removeEndFrameEvent(this.onMagicMVEnd);
         this.role.setMotionType(this.role.getMotionType() == RoleMotion.S_MAGIC ? RoleMotion.STAND : RoleMotion.FLOAT);
         setFinished(true);
      }
      
      protected function onMagicACTHandler(param1:Event) : void
      {
         var _loc3_:IActor = null;
         var _loc5_:int = 0;
         var _loc2_:IRole = this.mmdes.aimRole;
         var _loc4_:IRoleSysAPI = __global.SysAPI.getWorldAPI().getRoleSysAPI();
         if(_loc2_ != null)
         {
            if(_loc2_.getID() != 0)
            {
               _loc3_ = _loc2_.getActor();
            }
         }
         else
         {
            _loc3_ = this.mmdes.aimElement as IActor;
         }
         if(this.role != null)
         {
            this.role.getRoleView().removeLabelEvent(this.onMagicACTHandler);
         }
         if(_loc3_ != null)
         {
            if(this.mmdes.isClient)
            {
               _loc5_ = this.mmdes.openMSDes.actionType;
            }
            else
            {
               _loc5_ = this.mmdes.useMS.actionType;
            }
            _loc4_.applyActionTo3(_loc3_,_loc5_,this.mmdes);
         }
         this.mmdes = null;
      }
      
      override public function giveUp() : Boolean
      {
         if(this.role != null)
         {
            this.role.getRoleView().removeLabelEvent(this.onMagicACTHandler);
            this.role.getRoleView().removeEndFrameEvent(this.onMagicMVEnd);
            this.role = null;
         }
         this.mmdes = null;
         return true;
      }
      
      override public function isLockedType(param1:int) : Boolean
      {
         return param1 == ActionsIntro.WalkAction || param1 == ActionsIntro.WalkAndThenAction;
      }
   }
}
