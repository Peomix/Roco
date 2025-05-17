package com.QQ.angel.api.world.scene
{
   import com.QQ.angel.api.display.IDisplay;
   import flash.geom.Point;
   
   public interface IElementView extends IDisplay
   {
      
      function setXYLocation(param1:Number, param2:Number) : void;
      
      function getLocation() : Point;
      
      function setLocation(param1:Point) : void;
   }
}

