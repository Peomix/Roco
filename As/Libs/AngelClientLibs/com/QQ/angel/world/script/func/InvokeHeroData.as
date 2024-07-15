package com.QQ.angel.world.script.func
{
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.world.script.IInvokeFunc;
   
   public class InvokeHeroData implements IInvokeFunc
   {
       
      
      public function InvokeHeroData()
      {
         super();
      }
      
      public function setGlobal(param1:Object) : void
      {
      }
      
      public function invoke(param1:String, param2:Function) : void
      {
         var _loc3_:RoleData = __global.MainRoleData;
         if(_loc3_.hasOwnProperty(param1))
         {
            param2(_loc3_[param1]);
         }
         else
         {
            param2(0);
         }
      }
      
      public function dispose() : void
      {
      }
   }
}
