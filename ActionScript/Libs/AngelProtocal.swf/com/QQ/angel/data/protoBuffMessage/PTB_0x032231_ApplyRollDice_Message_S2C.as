package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x032231_ApplyRollDice_Message_S2C extends Message implements IExternalizable
   {
      
      private var dice_num$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var time_left$field:uint;
      
      private var pet_id$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      public var rewardArray:Array = [];
      
      private var dice_value$field:uint;
      
      private var dest_position$field:uint;
      
      public function PTB_0x032231_ApplyRollDice_Message_S2C()
      {
         super();
      }
      
      public function set petId(param1:uint) : void
      {
         hasField$0 |= 16;
         pet_id$field = param1;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get hasDiceValue() : Boolean
      {
         return (hasField$0 & 4) != 0;
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
                     throw new IOError("Bad data format: PTB_0x032231_ApplyRollDice_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032231_ApplyRollDice_Message_S2C.diceNum cannot be set twice.");
                  }
                  _loc4_++;
                  diceNum = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032231_ApplyRollDice_Message_S2C.timeLeft cannot be set twice.");
                  }
                  _loc5_++;
                  timeLeft = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032231_ApplyRollDice_Message_S2C.diceValue cannot be set twice.");
                  }
                  _loc6_++;
                  diceValue = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032231_ApplyRollDice_Message_S2C.destPosition cannot be set twice.");
                  }
                  _loc7_++;
                  destPosition = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032231_ApplyRollDice_Message_S2C.petId cannot be set twice.");
                  }
                  _loc8_++;
                  petId = ReadUtils.read$TYPE_UINT32(param1);
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
      
      public function removeDiceNum() : void
      {
         hasField$0 &= 4294967294;
         dice_num$field = new uint();
      }
      
      public function set diceValue(param1:uint) : void
      {
         hasField$0 |= 4;
         dice_value$field = param1;
      }
      
      public function removeDestPosition() : void
      {
         hasField$0 &= 4294967287;
         dest_position$field = new uint();
      }
      
      public function removeTimeLeft() : void
      {
         hasField$0 &= 4294967293;
         time_left$field = new uint();
      }
      
      public function get diceValue() : uint
      {
         if(!hasDiceValue)
         {
            return 0;
         }
         return dice_value$field;
      }
      
      public function get petId() : uint
      {
         if(!hasPetId)
         {
            return 0;
         }
         return pet_id$field;
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function set destPosition(param1:uint) : void
      {
         hasField$0 |= 8;
         dest_position$field = param1;
      }
      
      public function get hasDiceNum() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function removeDiceValue() : void
      {
         hasField$0 &= 4294967291;
         dice_value$field = new uint();
      }
      
      public function get hasPetId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set timeLeft(param1:uint) : void
      {
         hasField$0 |= 2;
         time_left$field = param1;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasDiceNum)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,dice_num$field);
         }
         if(hasTimeLeft)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,time_left$field);
         }
         if(hasDiceValue)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,dice_value$field);
         }
         if(hasDestPosition)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,dest_position$field);
         }
         if(hasPetId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,pet_id$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < rewardArray.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,7);
            WriteUtils.write$TYPE_MESSAGE(param1,rewardArray[_loc2_]);
            _loc2_++;
         }
      }
      
      public function get destPosition() : uint
      {
         if(!hasDestPosition)
         {
            return 0;
         }
         return dest_position$field;
      }
      
      public function get hasDestPosition() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get timeLeft() : uint
      {
         if(!hasTimeLeft)
         {
            return 0;
         }
         return time_left$field;
      }
      
      public function get hasTimeLeft() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function removePetId() : void
      {
         hasField$0 &= 4294967279;
         pet_id$field = new uint();
      }
      
      public function get diceNum() : uint
      {
         if(!hasDiceNum)
         {
            return 0;
         }
         return dice_num$field;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function set diceNum(param1:uint) : void
      {
         hasField$0 |= 1;
         dice_num$field = param1;
      }
   }
}

