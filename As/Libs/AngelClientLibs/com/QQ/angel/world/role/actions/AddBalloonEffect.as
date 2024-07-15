package com.QQ.angel.world.role.actions
{
   import com.QQ.angel.api.world.role.Direction;
   import com.QQ.angel.api.world.role.IRoleView;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.world.actions.AddEffectAction;
   import com.QQ.angel.world.events.ElementViewEvent;
   import com.QQ.angel.world.vo.RoleStateData;
   
   public class AddBalloonEffect extends AddEffectAction
   {
       
      
      protected var roleData:RoleData;
      
      protected var roleView:IRoleView;
      
      public function AddBalloonEffect(param1:Object)
      {
         super(param1);
      }
      
      protected function onDirChange(param1:ElementViewEvent) : void
      {
         switch(this.roleData.direction)
         {
            case Direction.FRONT:
               eContainer.effectToBody(mv,true);
               mv.scaleX = 1;
               break;
            case Direction.BACK:
               eContainer.effectToBody(mv,false);
               mv.scaleX = -1;
               break;
            case Direction.LEFT:
               eContainer.effectToBody(mv,true);
               mv.scaleX = -1;
               break;
            case Direction.RIGHT:
               eContainer.effectToBody(mv,false);
               mv.scaleX = 1;
         }
      }
      
      override public function start(param1:Object) : void
      {
         super.start(param1);
         this.roleData = element.getData() as RoleData;
         this.roleView = element.getView() as IRoleView;
         this.roleView.addEventListener(ElementViewEvent.ON_DIR_CHANGE,this.onDirChange);
         mv.gotoAndStop(1);
         this.onDirChange(null);
      }
      
      override public function onAct(param1:Object) : void
      {
         if(this.roleData.flyItem != RoleStateData.FLY_BALLOON)
         {
            onTimeUp();
         }
      }
      
      override public function giveUp() : Boolean
      {
         this.roleView.removeEventListener(ElementViewEvent.ON_DIR_CHANGE,this.onDirChange);
         this.roleView = null;
         return super.giveUp();
      }
   }
}
