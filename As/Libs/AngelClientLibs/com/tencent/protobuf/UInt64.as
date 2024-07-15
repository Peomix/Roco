package com.tencent.protobuf
{
   public final class UInt64
   {
       
      
      public var low:uint;
      
      public var high:uint;
      
      public function UInt64(param1:uint = 0, param2:uint = 0)
      {
         super();
         this.low = param1;
         this.high = param2;
      }
      
      public function toString() : String
      {
         return "0x" + this.high.toString(16) + this.low.toString(16);
      }
   }
}
