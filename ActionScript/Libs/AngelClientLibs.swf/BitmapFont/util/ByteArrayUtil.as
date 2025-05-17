package BitmapFont.util
{
   import flash.utils.ByteArray;
   
   public class ByteArrayUtil
   {
      
      public function ByteArrayUtil()
      {
         super();
      }
      
      public static function writeUnsignedByteOrShort(param1:ByteArray, param2:uint) : void
      {
         ASSERT(param2 <= 65535);
         if(param2 >= 255)
         {
            param1.writeByte(255);
            param1.writeShort(param2);
         }
         else
         {
            param1.writeByte(param2 & 0xFF);
         }
      }
      
      public static function writeUnsignedShortOrInt(param1:ByteArray, param2:uint) : void
      {
         if(param2 >= 65535)
         {
            param1.writeShort(65535);
            param1.writeInt(param2);
         }
         else
         {
            param1.writeShort(param2);
         }
      }
      
      public static function writeShortOrInt(param1:ByteArray, param2:int) : void
      {
         if(param2 < -32768 || param2 > 32767 || param2 == -1)
         {
            param1.writeShort(65535);
            param1.writeInt(param2);
         }
         else
         {
            param1.writeShort(param2);
         }
      }
      
      public static function readUnsignedShortOrInt(param1:ByteArray) : uint
      {
         var _loc2_:uint = param1.readUnsignedShort();
         if(_loc2_ != 65535)
         {
            return _loc2_;
         }
         return param1.readInt();
      }
      
      public static function readUnsignedByteOrShort(param1:ByteArray) : uint
      {
         var _loc2_:uint = param1.readUnsignedByte();
         if(_loc2_ != 255)
         {
            return _loc2_;
         }
         return param1.readUnsignedShort();
      }
      
      public static function readShortOrInt(param1:ByteArray) : int
      {
         var _loc2_:int = param1.readShort();
         if((_loc2_ & 0xFFFF) != 65535)
         {
            return _loc2_;
         }
         return param1.readInt();
      }
   }
}

