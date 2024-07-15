package com.QQ.angel.world.vo
{
   import flash.geom.Point;
   
   public class VipLuluData
   {
       
      
      public var id:int;
      
      public var uin:uint;
      
      public var masterHeight:int = 100;
      
      public var direction:int = 0;
      
      public var motionType:int = 0;
      
      public var speed:Number = 1;
      
      public var locXY:Point;
      
      private var __vipLevel:int;
      
      private var __typeID:int;
      
      public function VipLuluData()
      {
         super();
      }
      
      public function set vipLevel(param1:int) : void
      {
         this.__vipLevel = param1;
         this.__typeID = int(param1 / 5 * 2);
      }
      
      public function get vipLevel() : int
      {
         return this.__vipLevel;
      }
      
      public function get typeID() : int
      {
         return this.__typeID;
      }
   }
}
