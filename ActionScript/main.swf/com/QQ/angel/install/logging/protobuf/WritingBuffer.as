package com.QQ.angel.install.logging.protobuf
{
   import flash.errors.IllegalOperationError;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import flash.utils.IDataOutput;
   
   public final class WritingBuffer extends ByteArray
   {
      
      public static const VARINT:uint = 0;
      
      public static const FIXED_64_BIT:uint = 1;
      
      public static const LENGTH_DELIMITED:uint = 2;
      
      public static const FIXED_32_BIT:uint = 5;
      
      private const slices:ByteArray = new ByteArray();
      
      public function WritingBuffer()
      {
         super();
         endian = Endian.LITTLE_ENDIAN;
      }
      
      public function toNormal(param1:IDataOutput) : void
      {
         var _loc3_:uint = 0;
         if(slices.length % 8 != 0)
         {
            throw new IllegalOperationError();
         }
         slices.position = 0;
         var _loc2_:uint = 0;
         while(slices.bytesAvailable > 0)
         {
            _loc3_ = slices.readUnsignedInt();
            if(_loc3_ > _loc2_)
            {
               param1.writeBytes(this,_loc2_,_loc3_ - _loc2_);
            }
            else if(_loc3_ < _loc2_)
            {
               throw new IllegalOperationError();
            }
            _loc2_ = slices.readUnsignedInt();
         }
         if(_loc2_ < length)
         {
            param1.writeBytes(this,_loc2_);
         }
      }
      
      public function beginBlock() : uint
      {
         slices.writeUnsignedInt(position);
         var _loc1_:uint = slices.length;
         if(_loc1_ % 8 != 4)
         {
            throw new IllegalOperationError();
         }
         slices.writeDouble(0);
         slices.writeUnsignedInt(position);
         return _loc1_;
      }
      
      public function endBlock(param1:uint) : void
      {
         if(slices.length % 8 != 0)
         {
            throw new IllegalOperationError();
         }
         slices.writeUnsignedInt(position);
         slices.position = param1 + 8;
         var _loc2_:uint = slices.readUnsignedInt();
         slices.position = param1;
         slices.writeUnsignedInt(position);
         WriteUtils.write$TYPE_UINT32(this,position - _loc2_);
         slices.writeUnsignedInt(position);
         slices.position = slices.length;
         slices.writeUnsignedInt(position);
      }
   }
}

