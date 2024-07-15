package com.QQ.angel.api.world
{
   import com.QQ.angel.api.world.action.IAction;
   import com.QQ.angel.api.world.action.IActor;
   import com.QQ.angel.api.world.role.IRole;
   import flash.geom.Point;
   
   public interface IRoleSysAPI
   {
       
      
      function getRoleByID(param1:uint) : IRole;
      
      function getMainRole() : IRole;
      
      function getRolesList() : Array;
      
      function getRoleCounts() : int;
      
      function mainRoleWalk(param1:Object) : Boolean;
      
      function distanceToMR(param1:Point) : Number;
      
      function applyActionTo(param1:uint, param2:IAction) : void;
      
      function applyActionTo2(param1:uint, param2:int, param3:Object) : void;
      
      function applyActionTo3(param1:IActor, param2:int, param3:Object) : void;
      
      function shieldAction(param1:int) : Boolean;
      
      function unshieldAction(param1:int) : Boolean;
      
      function getRoleAtPoint(param1:Number, param2:Number) : IRole;
      
      function isWalkable(param1:uint = 0) : Boolean;
      
      function getRoleModel() : Object;
   }
}
