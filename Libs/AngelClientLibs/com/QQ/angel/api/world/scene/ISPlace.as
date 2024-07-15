package com.QQ.angel.api.world.scene
{
   import flash.geom.Point;
   
   public interface ISPlace
   {
       
      
      function getDirection() : int;
      
      function hasObj() : Boolean;
      
      function getCurrObj() : *;
      
      function setObj(param1:*) : void;
      
      function getPos() : Point;
      
      function getGameLeftPos() : Point;
      
      function isGamePlace() : Boolean;
      
      function getPlaceID() : uint;
      
      function getPlaceType() : int;
   }
}
