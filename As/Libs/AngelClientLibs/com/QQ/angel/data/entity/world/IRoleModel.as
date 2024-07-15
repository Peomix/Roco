package com.QQ.angel.data.entity.world
{
   import com.QQ.angel.data.entity.RoleData;
   import flash.events.IEventDispatcher;
   
   public interface IRoleModel extends IEventDispatcher
   {
       
      
      function addRole(param1:RoleData) : void;
      
      function removeRole(param1:uint) : void;
      
      function roleMove(param1:uint, param2:Array) : void;
      
      function changeRoleState(param1:uint, param2:Object) : void;
   }
}
