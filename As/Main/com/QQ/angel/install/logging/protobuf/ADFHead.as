package com.QQ.angel.install.logging.protobuf
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class ADFHead implements IExternalizable
   {
      
      public static const HeadReady:int = 1;
      
      public static const magic:int = 38183;
      
      public static const HeadLen:int = 20;
      
      public static const MagicError:int = -1;
      
      public static const NotEnBytes:int = 0;
       
      
      public var checkSum:int = 0;
      
      public var length:int;
      
      public var cmdID:uint;
      
      public var version:int = 0;
      
      public var uin:uint;
      
      public var uiSerialNum:uint = 0;
      
      public function ADFHead()
      {
         super();
      }
      
      public static function canRead(param1:IDataInput) : int
      {
         if(param1.bytesAvailable < HeadLen)
         {
            return NotEnBytes;
         }
         if(param1.readUnsignedByte() != magic >> 8)
         {
            return MagicError;
         }
         if(param1.readUnsignedByte() != (magic & 255))
         {
            return MagicError;
         }
         return HeadReady;
      }
      
      public function readExternal(param1:IDataInput) : void
      {
         version = param1.readUnsignedShort();
         cmdID = param1.readUnsignedInt();
         uin = param1.readUnsignedInt();
         uiSerialNum = param1.readUnsignedInt();
         checkSum = param1.readShort();
         length = param1.readUnsignedShort();
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
         param1.writeShort(magic);
         param1.writeShort(version);
         param1.writeUnsignedInt(cmdID);
         param1.writeUnsignedInt(uin);
         param1.writeUnsignedInt(uiSerialNum);
         param1.writeShort(checkSum);
         param1.writeShort(length);
      }
   }
}
