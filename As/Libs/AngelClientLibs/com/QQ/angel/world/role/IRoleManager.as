package com.QQ.angel.world.role
{
   import com.QQ.angel.api.world.role.IRole;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.world.vo.RoleInfoData;
   import com.QQ.angel.world.vo.RoleStateData;
   
   public interface IRoleManager
   {
       
      
      function addRole(param1:RoleData) : IRole;
      
      function removeRoleById(param1:uint) : IRole;
      
      function roleStateChange(param1:RoleStateData) : void;
      
      function roleInfoChange(param1:RoleInfoData) : void;
      
      function getRoleByID(param1:uint) : IRole;
      
      function getRoleList() : Array;
      
      function getRoleCounts() : int;
      
      function getRoleAtPoint(param1:Number, param2:Number) : IRole;
      
      function removeAll() : void;
   }
}
