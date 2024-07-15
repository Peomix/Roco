package com.QQ.angel.world.scene
{
   import com.QQ.angel.api.utils.CFunction;
   import flash.geom.Point;
   
   public interface IHero
   {
       
      
      function changePosition(param1:int, param2:Array, param3:Boolean = true) : void;
      
      function moveTo(param1:Point) : void;
      
      function closedExec(param1:Point, param2:int, param3:CFunction) : void;
      
      function setVisible(param1:Boolean) : void;
      
      function getVisible() : Boolean;
      
      function getPos() : Point;
      
      function setPos(param1:Point, param2:Boolean = true) : void;
      
      function getMotionType() : int;
      
      function getData() : Object;
      
      function addListener(param1:String, param2:Function) : void;
      
      function removeListener(param1:String, param2:Function) : void;
      
      function dispose() : void;
   }
}
