package com.QQ.angel.install.logging.protobuf
{
   public final class WriteUtils
   {
       
      
      public function WriteUtils()
      {
         super();
      }
      
      public static function write$TYPE_UINT32(param1:WritingBuffer, param2:uint) : void
      {
         while((param2 & ~127) != 0)
         {
            param1.writeByte(param2 & 127 | 128);
            param2 >>>= 7;
         }
         param1.writeByte(param2);
      }
      
      public static function write$TYPE_STRING(param1:WritingBuffer, param2:String) : void
      {
         var _loc3_:uint = param1.beginBlock();
         param1.writeUTFBytes(param2);
         param1.endBlock(_loc3_);
      }
      
      public static function writeTag(param1:WritingBuffer, param2:uint, param3:uint) : void
      {
         write$TYPE_UINT32(param1,param3 << 3 | param2);
      }
   }
}
