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
   
   public final class PTB_0x032271_OnStatus_Message_S2C extends Message implements IExternalizable
   {
      
      private var gift$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var times$field:int;
      
      public function PTB_0x032271_OnStatus_Message_S2C()
      {
         super();
      }
      
      public function set gift(param1:uint) : void
      {
         hasField$0 |= 2;
         gift$field = param1;
      }
      
      public function removeTimes() : void
      {
         hasField$0 &= 4294967294;
         times$field = new int();
      }
      
      public function get times() : int
      {
         if(!hasTimes)
         {
            return 0;
         }
         return times$field;
      }
      
      public function set times(param1:int) : void
      {
         hasField$0 |= 1;
         times$field = param1;
      }
      
      public function get gift() : uint
      {
         if(!hasGift)
         {
            return 0;
         }
         return gift$field;
      }
      
      public function get hasGift() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc5_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc5_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032271_OnStatus_Message_S2C.times cannot be set twice.");
                  }
                  _loc3_++;
                  times = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032271_OnStatus_Message_S2C.gift cannot be set twice.");
                  }
                  _loc4_++;
                  gift = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
                  break;
            }
         }
      }
      
      public function get hasTimes() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function removeGift() : void
      {
         hasField$0 &= 4294967293;
         gift$field = new uint();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTimes)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_INT32(param1,times$field);
         }
         if(hasGift)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,gift$field);
         }
      }
   }
}

