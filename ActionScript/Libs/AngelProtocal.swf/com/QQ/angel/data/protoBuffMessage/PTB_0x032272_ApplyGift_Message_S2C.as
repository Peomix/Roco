package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x032272_ApplyGift_Message_S2C extends Message implements IExternalizable
   {
      
      private var ret_code$field:ReturnCode_Message;
      
      private var gift$field:uint;
      
      private var hasField$0:uint = 0;
      
      public var rewardArray:Array = [];
      
      public function PTB_0x032272_ApplyGift_Message_S2C()
      {
         super();
      }
      
      public function set gift(param1:uint) : void
      {
         hasField$0 |= 1;
         gift$field = param1;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
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
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:ItemInfoChanged32_Message = null;
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
                     throw new IOError("Bad data format: PTB_0x032272_ApplyGift_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032272_ApplyGift_Message_S2C.gift cannot be set twice.");
                  }
                  _loc4_++;
                  gift = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  _loc6_ = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  rewardArray.push(_loc6_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
                  break;
            }
         }
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get hasGift() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasGift)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,gift$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < rewardArray.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_MESSAGE(param1,rewardArray[_loc2_]);
            _loc2_++;
         }
      }
      
      public function removeGift() : void
      {
         hasField$0 &= 4294967294;
         gift$field = new uint();
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
   }
}

