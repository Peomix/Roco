package com.tencent.protobuf
{
   import flash.utils.ByteArray;
   
   public function stringToByteArray(param1:String) : ByteArray
   {
      var _loc2_:ByteArray = new ByteArray();
      var _loc3_:uint = 0;
      while(_loc3_ < param1.length)
      {
         _loc2_.writeByte(param1.charCodeAt(_loc3_));
         _loc3_++;
      }
      return _loc2_;
   }
}
