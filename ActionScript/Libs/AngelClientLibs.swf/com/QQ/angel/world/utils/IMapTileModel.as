package com.QQ.angel.world.utils
{
   import flash.geom.Point;
   
   public interface IMapTileModel
   {
      
      function isBlock(param1:int, param2:int, param3:int, param4:int) : Boolean;
      
      function isWalkable(param1:int, param2:int) : Boolean;
      
      function isWalkable2(param1:Point) : Boolean;
      
      function isLineConnected(param1:Point, param2:Point, param3:int = 1) : Boolean;
      
      function toTilePos(param1:Point, param2:Boolean = false) : Point;
      
      function compressArrPoints(param1:Array) : Array;
      
      function arrToLocations(param1:Array, param2:Point = null, param3:Boolean = false) : Array;
      
      function getMapData() : Array;
      
      function dispose() : void;
   }
}

