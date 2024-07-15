package com.QQ.angel.world.role.actions
{
   import com.QQ.angel.data.entity.MagicSkillDes;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.world.actions.AddEffectAction;
   import com.QQ.angel.world.magic.ICanAddedEffect;
   import com.QQ.angel.world.vo.RoleStateData;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class AddBlebEffect extends AddEffectAction
   {
       
      
      protected var roleData:RoleData;
      
      public function AddBlebEffect(param1:Object)
      {
         super(param1);
      }
      
      override public function start(param1:Object) : void
      {
         super.start(param1);
         this.roleData = element.getData() as RoleData;
      }
      
      override protected function applyAction(param1:Event = null) : Boolean
      {
         eContainer = element.getView() as ICanAddedEffect;
         if(mvDes.hasOwnProperty("mc"))
         {
            mv = mvDes.mc;
         }
         else
         {
            mv = resSysApi.borrowObj(mvDes.id,mvDes is MagicSkillDes ? 0 : 1) as MovieClip;
         }
         if(_isDazzle)
         {
            mv.width = 160;
            mv.height = 160;
         }
         else
         {
            mv.width = 100;
            mv.height = 100;
         }
         eContainer.addEffect(mv);
         return true;
      }
      
      override public function onAct(param1:Object) : void
      {
         _isDazzle = param1.getData().dazzleAvatar;
         if(_isDazzle)
         {
            mv.width = 160;
            mv.height = 160;
         }
         else
         {
            mv.width = 100;
            mv.height = 100;
         }
         if(this.roleData.swimItem != RoleStateData.SWIM_BLEB)
         {
            onTimeUp();
         }
      }
   }
}
