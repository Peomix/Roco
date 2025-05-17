package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.Message;
   import com.tencent.protobuf.ReadUtils;
   import com.tencent.protobuf.WireType;
   import com.tencent.protobuf.WriteUtils;
   import com.tencent.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x032052_DreamWinnerLottery_Message_C2S extends Message implements IExternalizable
   {
      
      private var force$field:uint;
      
      private var hasField$0:uint = 0;
      
      public function PTB_0x032052_DreamWinnerLottery_Message_C2S()
      {
         super();
      }
      
      public function removeForce() : void
      {
         hasField$0 &= 4294967294;
         force$field = new uint();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasForce)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,force$field);
         }
      }
      
      public function get force() : uint
      {
         if(!hasForce)
         {
            return 0;
         }
         return force$field;
      }
      
      public function get hasForce() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc4_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc4_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032052_DreamWinnerLottery_Message_C2S.force cannot be set twice.");
                  }
                  _loc3_++;
                  force = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
                  break;
            }
         }
      }
      
      public function set force(param1:uint) : void
      {
         hasField$0 |= 1;
         force$field = param1;
      }
   }
}

