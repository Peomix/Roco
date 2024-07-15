package com.QQ.angel.world.scene.impl
{
   import com.QQ.angel.api.world.scene.ISPlace;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class SpritePlace extends Sprite implements ISPlace
   {
       
      
      public var placeID:int;
      
      public var hasGame:Boolean = false;
      
      public var leftGamePos:Point;
      
      public var direction:int;
      
      public var placeType:int;
      
      public var tooltip:String;
      
      public var tooltipType:int = 4;
      
      protected var atThisObj:*;
      
      public function SpritePlace()
      {
         super();
         buttonMode = true;
         useHandCursor = true;
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
