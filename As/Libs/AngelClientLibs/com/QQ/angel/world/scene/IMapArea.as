package com.QQ.angel.world.scene
{
   import flash.geom.Rectangle;
   
   public interface IMapArea
   {
       
      
      function open() : void;
      
      function close() : void;
      
      function isOpen() : Boolean;
      
      function getLocalRect() : Rectangle;
      
      function dispose() : void;
   }
}
