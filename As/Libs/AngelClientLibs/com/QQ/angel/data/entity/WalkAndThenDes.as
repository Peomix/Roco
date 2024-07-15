package com.QQ.angel.data.entity
{
   import com.QQ.angel.api.utils.CFunction;
   import flash.geom.Point;
   
   public class WalkAndThenDes
   {
       
      
      public var aim:Point;
      
      public var dis:int;
      
      public var callBack:CFunction;
      
      public var tellStop:CFunction;
      
      public var paths:Array;
      
      public function WalkAndThenDes()
      {
         super();
      }
   }
}
