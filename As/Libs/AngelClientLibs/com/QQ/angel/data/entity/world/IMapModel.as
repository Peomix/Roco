package com.QQ.angel.data.entity.world
{
   import flash.geom.Point;
   
   public interface IMapModel
   {
       
      
      function findPath(param1:Point, param2:Point, param3:int = 0) : Array;
      
      function isWalkable(param1:Point) : Boolean;
   }
}
