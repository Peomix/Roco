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
   
   public final class PTB_0x032355_QueryA436Status_Message_S2C extends Message implements IExternalizable
   {
      
      private var hasField$0:uint = 0;
      
      private var gift$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var time$field:uint;
      
      public function PTB_0x032355_QueryA436Status_Message_S2C()
      {
         super();
      }
      
      public function get hasTime() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get time() : uint
      {
         if(!hasTime)
         {
            return 0;
         }
         return time$field;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc6_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc6_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032355_QueryA436Status_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032355_QueryA436Status_Message_S2C.time cannot be set twice.");
                  }
                  _loc4_++;
                  time = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032355_QueryA436Status_Message_S2C.gift cannot be set twice.");
                  }
                  _loc5_++;
                  gift = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
                  break;
            }
         }
      }
      
      public function removeGift() : void
      {
         hasField$0 &= 4294967293;
         gift$field = new uint();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,time$field);
         }
         if(hasGift)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,gift$field);
         }
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function set gift(param1:uint) : void
      {
         hasField$0 |= 2;
         gift$field = param1;
      }
      
      public function get hasGift() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get gift() : uint
      {
         if(!hasGift)
         {
            return 0;
         }
         return gift$field;
      }
      
      public function removeTime() : void
      {
         hasField$0 &= 4294967294;
         time$field = new uint();
      }
      
      public function set time(param1:uint) : void
      {
         hasField$0 |= 1;
         time$field = param1;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
   }
}

