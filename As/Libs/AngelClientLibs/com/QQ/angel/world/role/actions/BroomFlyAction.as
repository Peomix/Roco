package com.QQ.angel.world.role.actions
{
   import com.QQ.angel.data.entity.MagicSkillDes;
   import com.QQ.angel.world.actions.BeCursedAction;
   
   public class BroomFlyAction extends BeCursedAction
   {
       
      
      public function BroomFlyAction(param1:int)
      {
         var _loc2_:MagicSkillDes = new MagicSkillDes();
         _loc2_.id = param1;
         _loc2_.magicType = 4;
         _loc2_.target = 0;
         _loc2_.dur = 0;
         super(_loc2_);
      }
   }
}
