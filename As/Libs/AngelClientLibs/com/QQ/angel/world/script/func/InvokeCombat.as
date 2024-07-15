package com.QQ.angel.world.script.func
{
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.combatsys.OpenCombatDes;
   import com.QQ.angel.world.script.IInvokeFunc;
   
   public class InvokeCombat implements IInvokeFunc
   {
       
      
      public function InvokeCombat()
      {
         super();
      }
      
      public function invoke(param1:String, param2:Function) : void
      {
         var _loc3_:OpenCombatDes = new OpenCombatDes();
         _loc3_.handler = new CFunction(param2,null);
         var _loc4_:Array = param1.split("|");
         _loc3_.combatType = int(_loc4_[0]);
         _loc3_.opponentID = uint(_loc4_[1]);
         _loc3_.oppoentName = String(_loc4_[2] == null ? "" : _loc4_[2]);
         __global.openCombat(_loc3_);
      }
      
      public function setGlobal(param1:Object) : void
      {
      }
      
      public function dispose() : void
      {
      }
   }
}
