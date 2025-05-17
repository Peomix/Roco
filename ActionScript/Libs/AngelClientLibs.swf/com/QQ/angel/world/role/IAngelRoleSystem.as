package com.QQ.angel.world.role
{
   import com.QQ.angel.api.world.IRoleSysAPI;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.world.net.protocol.P_SubBC_Paths;
   import com.QQ.angel.world.vo.CombatResultVo;
   import com.QQ.angel.world.vo.RoleInfoData;
   import com.QQ.angel.world.vo.RoleStateData;
   
   public interface IAngelRoleSystem extends IRoleSysAPI
   {
      
      function addRole(param1:RoleData) : void;
      
      function removeRoleById(param1:uint) : void;
      
      function onOneRoleMove(param1:P_SubBC_Paths) : void;
      
      function onOneRoleStateChange(param1:RoleStateData) : void;
      
      function onOneRoleInfoChange(param1:RoleInfoData) : void;
      
      function bcRolePos(param1:int, param2:Array) : void;
      
      function onCombatResultChange(param1:CombatResultVo) : void;
   }
}

