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
   
   public final class PTB_0x0300FC_QuerySpiritRaceSupport_Message_C2S extends Message implements IExternalizable
   {
       
      
      private var hasField$0:uint = 0;
      
      private var num$field:uint;
      
      public function PTB_0x0300FC_QuerySpiritRaceSupport_Message_C2S()
      {
         super();
      }
      
      public function removeNum() : void
      {
         hasField$0 &= 4294967294;
         num$field = new uint();
      }
      
      public function get num() : uint
      {
         if(!hasNum)
         {
            return 0;
         }
         return num$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNum)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,num$field);
         }
      }
      
      public function set num(param1:uint) : void
      {
         hasField$0 |= 1;
         num$field = param1;
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
                     throw new IOError("Bad data format: PTB_0x0300FC_QuerySpiritRaceSupport_Message_C2S.num cannot be set twice.");
                  }
                  _loc3_++;
                  num = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
                  break;
            }
         }
      }
      
      public function get hasNum() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
   }
}
