package com.QQ.angel.world.scene.impl
{
   import com.QQ.angel.api.world.scene.ISPlace;
   import flash.display.DisplayObject;
   import flash.display.SimpleButton;
   import flash.geom.Point;
   
   public class SimpleButtonPlace extends SimpleButton implements ISPlace
   {
       
      
      public var placeID:int;
      
      public var hasGame:Boolean = false;
      
      public var leftGamePos:Point;
      
      public var direction:int;
      
      public var placeType:int;
      
      public var tooltip:String;
      
      public var tooltipType:int = 5;
      
      protected var atThisObj:*;
      
      public function SimpleButtonPlace(param1:DisplayObject = null, param2:DisplayObject = null, param3:DisplayObject = null, param4:DisplayObject = null)
      {
         super(param1,param2,param3,param4);
      }
      
      public function getDirection() : int
      {
         return this.direction;
      }
      
      public function hasObj() : Boolean
      {
         return this.atThisObj != null;
      }
      
      public function getCurrObj() : *
      {
         return this.atThisObj;
      }
      
      public function setObj(param1:*) : void
      {
         this.atThisObj = param1;
      }
      
      public function getPos() : Point
      {
         return new Point(x,y);
      }
      
      public function getGameLeftPos() : Point
      {
         if(this.leftGamePos == null)
         {
            return null;
         }
         return this.leftGamePos.clone();
      }
      
      public function isGamePlace() : Boolean
      {
         return this.hasGame;
      }
      
      public function getPlaceID() : uint
      {
         return this.placeID;
      }
      
      public function getPlaceType() : int
      {
         return this.placeType;
      }
   }
}
