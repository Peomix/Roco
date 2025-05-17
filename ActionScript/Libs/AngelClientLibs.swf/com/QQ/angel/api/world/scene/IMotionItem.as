package com.QQ.angel.api.world.scene
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public interface IMotionItem extends IElement
   {
      
      function getDirection() : int;
      
      function getMotionType() : int;
      
      function setDirection(param1:int) : void;
      
      function setMotionType(param1:int) : void;
      
      function setMotionAndDir(param1:int, param2:int) : void;
      
      function getPosition() : Point;
      
      function setPosition(param1:Point) : void;
      
      function getSpeed() : Number;
      
      function isHit(param1:Number, param2:Number) : Boolean;
      
      function isHit2(param1:DisplayObject) : Boolean;
      
      function addClickListener(param1:Object) : void;
   }
}

