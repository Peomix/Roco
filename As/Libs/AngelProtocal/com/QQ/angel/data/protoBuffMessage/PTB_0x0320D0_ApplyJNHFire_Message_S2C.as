package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x0320D0_ApplyJNHFire_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var ret_code$field:ReturnCode_Message;
      
      public var rewardArray:Array;
      
      private var hasField$0:uint = 0;
      
      private var gift_type$field:int;
      
      public function PTB_0x0320D0_ApplyJNHFire_Message_S2C()
      {
         rewardArray = [];
         super();
      }
      
      public function set giftType(param1:int) : void
      {
         hasField$0 |= 1;
         gift_type$field = param1;
      }
      
      public function get hasGiftType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
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
                     throw new IOError("Bad data format: PTB_0x0320D0_ApplyJNHFire_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  _loc6_ = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  rewardArray.push(_loc6_);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320D0_ApplyJNHFire_Message_S2C.giftType cannot be set twice.");
                  }
                  _loc4_++;
                  giftType = ReadUtils.read$TYPE_INT32(param1);
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
      
      public function removeGiftType() : void
      {
         hasField$0 &= 4294967294;
         gift_type$field = new int();
      }
      
      public function get giftType() : int
      {
         if(!hasGiftType)
         {
            return 0;
         }
         return gift_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < rewardArray.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,rewardArray[_loc2_]);
            _loc2_++;
         }
         if(hasGiftType)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_INT32(param1,gift_type$field);
         }
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
   }
}
