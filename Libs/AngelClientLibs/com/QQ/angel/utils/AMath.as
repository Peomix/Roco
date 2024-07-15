package com.QQ.angel.utils
{
   import com.QQ.angel.api.world.role.Direction;
   import flash.geom.Point;
   
   public class AMath
   {
      
      public static var pi_1:Number = 1 / Math.PI;
       
      
      public function AMath()
      {
         super();
      }
      
      public static function getVector(param1:Point, param2:Point) : Object
      {
         var _loc7_:int = 0;
         var _loc3_:Number = param2.x - param1.x;
         var _loc4_:Number = param2.y - param1.y;
         var _loc6_:int;
         var _loc5_:Number;
         if((_loc6_ = (_loc5_ = Math.atan2(_loc4_,_loc3_)) * 180 * pi_1) >= 90 && _loc6_ <= 180)
         {
            _loc7_ = Direction.FRONT;
         }
         else if(_loc6_ >= 0 && _loc6_ < 90)
         {
            _loc7_ = Direction.LEFT;
         }
         else if(_loc6_ < 0 && _loc6_ >= -90)
         {
            _loc7_ = Direction.BACK;
         }
         else if(_loc6_ < -90 && _loc6_ > -180)
         {
            _loc7_ = Direction.RIGHT;
         }
         return {
            "angle":_loc6_,
            "dir":_loc7_,
            "pi":_loc5_
         };
      }
   }
}
