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
   
   public final class PTB_0x0320FB_QueryStatus_Message_S2C extends Message implements IExternalizable
   {
      
      private var hasField$0:uint = 0;
      
      private var gift_num$field:uint;
      
      private var egg_hp$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var next_time$field:uint;
      
      public function PTB_0x0320FB_QueryStatus_Message_S2C()
      {
         super();
      }
      
      public function set nextTime(param1:uint) : void
      {
         hasField$0 |= 4;
         next_time$field = param1;
      }
      
      public function removeNextTime() : void
      {
         hasField$0 &= 4294967291;
         next_time$field = new uint();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasEggHp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,egg_hp$field);
         }
         if(hasGiftNum)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,gift_num$field);
         }
         if(hasNextTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,next_time$field);
         }
      }
      
      public function removeEggHp() : void
      {
         hasField$0 &= 4294967294;
         egg_hp$field = new uint();
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function removeGiftNum() : void
      {
         hasField$0 &= 4294967293;
         gift_num$field = new uint();
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
                     throw new IOError("Bad data format: PTB_0x0320FB_QueryStatus_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320FB_QueryStatus_Message_S2C.eggHp cannot be set twice.");
                  }
                  _loc4_++;
                  eggHp = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320FB_QueryStatus_Message_S2C.giftNum cannot be set twice.");
                  }
                  _loc5_++;
                  giftNum = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320FB_QueryStatus_Message_S2C.nextTime cannot be set twice.");
                  }
                  _loc6_++;
                  nextTime = ReadUtils.read$TYPE_UINT32(param1);
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
      
      public function get nextTime() : uint
      {
         if(!hasNextTime)
         {
            return 0;
         }
         return next_time$field;
      }
      
      public function set eggHp(param1:uint) : void
      {
         hasField$0 |= 1;
         egg_hp$field = param1;
      }
      
      public function set giftNum(param1:uint) : void
      {
         hasField$0 |= 2;
         gift_num$field = param1;
      }
      
      public function get eggHp() : uint
      {
         if(!hasEggHp)
         {
            return 0;
         }
         return egg_hp$field;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get hasNextTime() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function get hasEggHp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get giftNum() : uint
      {
         if(!hasGiftNum)
         {
            return 0;
         }
         return gift_num$field;
      }
      
      public function get hasGiftNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
   }
}

