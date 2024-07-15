package com.QQ.angel.api.net.protocol
{
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class ADFHead implements IExternalizable
   {
      
      public static const NotEnBytes:int = 0;
      
      public static const MagicError:int = -1;
      
      public static const HeadReady:int = 1;
      
      public static const HeadLen:int = 20;
      
      public static const magic:int = 38183;
       
      
      public var version:int = 0;
      
      public var cmdID:uint;
      
      public var uin:uint;
      
      public var uiSerialNum:uint = 0;
      
      public var checkSum:int = 0;
      
      public var length:int;
      
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
         this.version = param1.readUnsignedShort();
         this.cmdID = param1.readUnsignedInt();
         this.uin = param1.readUnsignedInt();
         this.uiSerialNum = param1.readUnsignedInt();
         this.checkSum = param1.readShort();
         this.length = param1.readUnsignedShort();
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
         param1.writeShort(magic);
         param1.writeShort(this.version);
         param1.writeUnsignedInt(this.cmdID);
         param1.writeUnsignedInt(this.uin);
         param1.writeUnsignedInt(this.uiSerialNum);
         param1.writeShort(this.checkSum);
         param1.writeShort(this.length);
      }
   }
}
