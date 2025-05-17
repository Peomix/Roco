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
   
   public final class PTB_0x032084_QueryStatus_Message_S2C extends Message implements IExternalizable
   {
      
      private var hasField$0:uint = 0;
      
      private var free_gotten$field:uint;
      
      private var left_time$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var own_count$field:uint;
      
      public function PTB_0x032084_QueryStatus_Message_S2C()
      {
         super();
      }
      
      public function removeFreeGotten() : void
      {
         hasField$0 &= 4294967291;
         free_gotten$field = new uint();
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function removeOwnCount() : void
      {
         hasField$0 &= 4294967293;
         own_count$field = new uint();
      }
      
      public function set ownCount(param1:uint) : void
      {
         hasField$0 |= 2;
         own_count$field = param1;
      }
      
      public function get hasFreeGotten() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc7_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc7_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032084_QueryStatus_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032084_QueryStatus_Message_S2C.leftTime cannot be set twice.");
                  }
                  _loc4_++;
                  leftTime = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032084_QueryStatus_Message_S2C.ownCount cannot be set twice.");
                  }
                  _loc5_++;
                  ownCount = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032084_QueryStatus_Message_S2C.freeGotten cannot be set twice.");
                  }
                  _loc6_++;
                  freeGotten = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
                  break;
            }
         }
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function get freeGotten() : uint
      {
         if(!hasFreeGotten)
         {
            return 0;
         }
         return free_gotten$field;
      }
      
      public function get hasOwnCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967294;
         left_time$field = new uint();
      }
      
      public function set leftTime(param1:uint) : void
      {
         hasField$0 |= 1;
         left_time$field = param1;
      }
      
      public function get ownCount() : uint
      {
         if(!hasOwnCount)
         {
            return 0;
         }
         return own_count$field;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,left_time$field);
         }
         if(hasOwnCount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,own_count$field);
         }
         if(hasFreeGotten)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,free_gotten$field);
         }
      }
      
      public function get leftTime() : uint
      {
         if(!hasLeftTime)
         {
            return 0;
         }
         return left_time$field;
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set freeGotten(param1:uint) : void
      {
         hasField$0 |= 4;
         free_gotten$field = param1;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
   }
}

