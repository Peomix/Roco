package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x03230F_ApplyZLReward_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var status$field:uint;
      
      private var remain$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var ticket$field:uint;
      
      private var count_down$field:uint;
      
      public var rewardArray:Array;
      
      private var reward_index$field:uint;
      
      public function PTB_0x03230F_ApplyZLReward_Message_S2C()
      {
         rewardArray = [];
         super();
      }
      
      public function get hasTicket() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function set rewardIndex(param1:uint) : void
      {
         hasField$0 |= 16;
         reward_index$field = param1;
      }
      
      public function removeRemain() : void
      {
         hasField$0 &= 4294967291;
         remain$field = new uint();
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:uint = 0;
         var _loc10_:ItemInfoChanged32_Message = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc9_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc9_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03230F_ApplyZLReward_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03230F_ApplyZLReward_Message_S2C.status cannot be set twice.");
                  }
                  _loc4_++;
                  status = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03230F_ApplyZLReward_Message_S2C.ticket cannot be set twice.");
                  }
                  _loc5_++;
                  ticket = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03230F_ApplyZLReward_Message_S2C.remain cannot be set twice.");
                  }
                  _loc6_++;
                  remain = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03230F_ApplyZLReward_Message_S2C.countDown cannot be set twice.");
                  }
                  _loc7_++;
                  countDown = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03230F_ApplyZLReward_Message_S2C.rewardIndex cannot be set twice.");
                  }
                  _loc8_++;
                  rewardIndex = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 7:
                  _loc10_ = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  rewardArray.push(_loc10_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
                  break;
            }
         }
      }
      
      public function get ticket() : uint
      {
         if(!hasTicket)
         {
            return 0;
         }
         return ticket$field;
      }
      
      public function removeStatus() : void
      {
         hasField$0 &= 4294967294;
         status$field = new uint();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasStatus)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,status$field);
         }
         if(hasTicket)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,ticket$field);
         }
         if(hasRemain)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,remain$field);
         }
         if(hasCountDown)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,count_down$field);
         }
         if(hasRewardIndex)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,reward_index$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < rewardArray.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,7);
            WriteUtils.write$TYPE_MESSAGE(param1,rewardArray[_loc2_]);
            _loc2_++;
         }
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function get hasCountDown() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set ticket(param1:uint) : void
      {
         hasField$0 |= 2;
         ticket$field = param1;
      }
      
      public function get countDown() : uint
      {
         if(!hasCountDown)
         {
            return 0;
         }
         return count_down$field;
      }
      
      public function get rewardIndex() : uint
      {
         if(!hasRewardIndex)
         {
            return 0;
         }
         return reward_index$field;
      }
      
      public function set status(param1:uint) : void
      {
         hasField$0 |= 1;
         status$field = param1;
      }
      
      public function get hasRemain() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set remain(param1:uint) : void
      {
         hasField$0 |= 4;
         remain$field = param1;
      }
      
      public function set countDown(param1:uint) : void
      {
         hasField$0 |= 8;
         count_down$field = param1;
      }
      
      public function get hasStatus() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function removeCountDown() : void
      {
         hasField$0 &= 4294967287;
         count_down$field = new uint();
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function removeTicket() : void
      {
         hasField$0 &= 4294967293;
         ticket$field = new uint();
      }
      
      public function get status() : uint
      {
         if(!hasStatus)
         {
            return 0;
         }
         return status$field;
      }
      
      public function get remain() : uint
      {
         if(!hasRemain)
         {
            return 0;
         }
         return remain$field;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get hasRewardIndex() : Boolean
      {
         return (hasField$0 & 16) != 0;
      }
      
      public function removeRewardIndex() : void
      {
         hasField$0 &= 4294967279;
         reward_index$field = new uint();
      }
   }
}
