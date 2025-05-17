package com.tencent.protobuf
{
   import flash.errors.IllegalOperationError;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import flash.utils.IDataOutput;
   
   public final class WritingBuffer extends ByteArray
   {
      
      private const slices:ByteArray = new ByteArray();
      
      public function WritingBuffer()
      {
         super();
         endian = Endian.LITTLE_ENDIAN;
      }
      
      public function beginBlock() : uint
      {
         this.slices.writeUnsignedInt(position);
         var _loc1_:uint = this.slices.length;
         if(_loc1_ % 8 != 4)
         {
            throw new IllegalOperationError();
         }
         this.slices.writeDouble(0);
         this.slices.writeUnsignedInt(position);
         return _loc1_;
      }
      
      public function endBlock(param1:uint) : void
      {
         if(this.slices.length % 8 != 0)
         {
            throw new IllegalOperationError();
         }
         this.slices.writeUnsignedInt(position);
         this.slices.position = param1 + 8;
         var _loc2_:uint = this.slices.readUnsignedInt();
         this.slices.position = param1;
         this.slices.writeUnsignedInt(position);
         WriteUtils.write$TYPE_UINT32(this,position - _loc2_);
         this.slices.writeUnsignedInt(position);
         this.slices.position = this.slices.length;
         this.slices.writeUnsignedInt(position);
      }
      
      public function toNormal(param1:IDataOutput) : void
      {
         var _loc3_:uint = 0;
         if(this.slices.length % 8 != 0)
         {
            throw new IllegalOperationError();
         }
         this.slices.position = 0;
         var _loc2_:uint = 0;
         while(this.slices.bytesAvailable > 0)
         {
            _loc3_ = this.slices.readUnsignedInt();
            if(_loc3_ > _loc2_)
            {
               param1.writeBytes(this,_loc2_,_loc3_ - _loc2_);
            }
            else if(_loc3_ < _loc2_)
            {
               throw new IllegalOperationError();
            }
            _loc2_ = this.slices.readUnsignedInt();
         }
         if(_loc2_ < length)
         {
            param1.writeBytes(this,_loc2_);
         }
      }
   }
}

