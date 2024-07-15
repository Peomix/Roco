package com.tencent.protobuf
{
   public final class Int64
   {
       
      
      public var low:uint;
      
      public var high:int;
      
      public function Int64(param1:uint = 0, param2:int = 0)
      {
         super();
         this.low = param1;
         this.high = param2;
      }
      
      public function toString() : String
      {
         var _loc1_:uint = uint(this.high);
         return "0x" + _loc1_.toString(16) + this.low.toString(16);
      }
   }
}
