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
   
   public final class PTB_0x032095_FansFightSetFans_Message_C2S extends Message implements IExternalizable
   {
       
      
      private var fan$field:uint;
      
      private var hasField$0:uint = 0;
      
      public function PTB_0x032095_FansFightSetFans_Message_C2S()
      {
         super();
      }
      
      public function set fan(param1:uint) : void
      {
         hasField$0 |= 1;
         fan$field = param1;
      }
      
      public function removeFan() : void
      {
         hasField$0 &= 4294967294;
         fan$field = new uint();
      }
      
      public function get fan() : uint
      {
         if(!hasFan)
         {
            return 0;
         }
         return fan$field;
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
                     throw new IOError("Bad data format: PTB_0x032095_FansFightSetFans_Message_C2S.fan cannot be set twice.");
                  }
                  _loc3_++;
                  fan = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
                  break;
            }
         }
      }
      
      public function get hasFan() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasFan)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,fan$field);
         }
      }
   }
}
