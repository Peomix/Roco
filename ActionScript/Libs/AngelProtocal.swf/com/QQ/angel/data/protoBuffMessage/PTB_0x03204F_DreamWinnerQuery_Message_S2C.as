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
   
   public final class PTB_0x03204F_DreamWinnerQuery_Message_S2C extends Message implements IExternalizable
   {
      
      private var hasField$0:uint = 0;
      
      private var dice_count$field:uint;
      
      private var invited$field:uint;
      
      private var daily_present$field:uint;
      
      private var dice_step$field:uint;
      
      private var game_count$field:uint;
      
      private var game_state$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var card_count$field:uint;
      
      public function PTB_0x03204F_DreamWinnerQuery_Message_S2C()
      {
         super();
      }
      
      public function removeDiceCount() : void
      {
         hasField$0 &= 4294967263;
         dice_count$field = new uint();
      }
      
      public function removeDailyPresent() : void
      {
         hasField$0 &= 4294967293;
         daily_present$field = new uint();
      }
      
      public function get hasInvited() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc11_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc11_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03204F_DreamWinnerQuery_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03204F_DreamWinnerQuery_Message_S2C.gameCount cannot be set twice.");
                  }
                  _loc4_++;
                  gameCount = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03204F_DreamWinnerQuery_Message_S2C.dailyPresent cannot be set twice.");
                  }
                  _loc5_++;
                  dailyPresent = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03204F_DreamWinnerQuery_Message_S2C.invited cannot be set twice.");
                  }
                  _loc6_++;
                  invited = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03204F_DreamWinnerQuery_Message_S2C.cardCount cannot be set twice.");
                  }
                  _loc7_++;
                  cardCount = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03204F_DreamWinnerQuery_Message_S2C.gameState cannot be set twice.");
                  }
                  _loc8_++;
                  gameState = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03204F_DreamWinnerQuery_Message_S2C.diceCount cannot be set twice.");
                  }
                  _loc9_++;
                  diceCount = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03204F_DreamWinnerQuery_Message_S2C.diceStep cannot be set twice.");
                  }
                  _loc10_++;
                  diceStep = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
                  break;
            }
         }
      }
      
      public function get diceStep() : uint
      {
         if(!hasDiceStep)
         {
            return 0;
         }
         return dice_step$field;
      }
      
      public function removeGameCount() : void
      {
         hasField$0 &= 4294967294;
         game_count$field = new uint();
      }
      
      public function removeGameState() : void
      {
         hasField$0 &= 4294967279;
         game_state$field = new uint();
      }
      
      public function get hasDailyPresent() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasGameCount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,game_count$field);
         }
         if(hasDailyPresent)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,daily_present$field);
         }
         if(hasInvited)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,invited$field);
         }
         if(hasCardCount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,card_count$field);
         }
         if(hasGameState)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,game_state$field);
         }
         if(hasDiceCount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,dice_count$field);
         }
         if(hasDiceStep)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,8);
            WriteUtils.write$TYPE_UINT32(param1,dice_step$field);
         }
      }
      
      public function set diceStep(param1:uint) : void
      {
         hasField$0 |= 64;
         dice_step$field = param1;
      }
      
      public function get diceCount() : uint
      {
         if(!hasDiceCount)
         {
            return 0;
         }
         return dice_count$field;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get hasDiceCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function removeDiceStep() : void
      {
         hasField$0 &= 4294967231;
         dice_step$field = new uint();
      }
      
      public function removeCardCount() : void
      {
         hasField$0 &= 4294967287;
         card_count$field = new uint();
      }
      
      public function get gameCount() : uint
      {
         if(!hasGameCount)
         {
            return 0;
         }
         return game_count$field;
      }
      
      public function set cardCount(param1:uint) : void
      {
         hasField$0 |= 8;
         card_count$field = param1;
      }
      
      public function get gameState() : uint
      {
         if(!hasGameState)
         {
            return 0;
         }
         return game_state$field;
      }
      
      public function get hasGameCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set dailyPresent(param1:uint) : void
      {
         hasField$0 |= 2;
         daily_present$field = param1;
      }
      
      public function get hasGameState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get hasDiceStep() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set diceCount(param1:uint) : void
      {
         hasField$0 |= 32;
         dice_count$field = param1;
      }
      
      public function removeInvited() : void
      {
         hasField$0 &= 4294967291;
         invited$field = new uint();
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function get cardCount() : uint
      {
         if(!hasCardCount)
         {
            return 0;
         }
         return card_count$field;
      }
      
      public function get dailyPresent() : uint
      {
         if(!hasDailyPresent)
         {
            return 0;
         }
         return daily_present$field;
      }
      
      public function get hasCardCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set gameCount(param1:uint) : void
      {
         hasField$0 |= 1;
         game_count$field = param1;
      }
      
      public function get invited() : uint
      {
         if(!hasInvited)
         {
            return 0;
         }
         return invited$field;
      }
      
      public function set invited(param1:uint) : void
      {
         hasField$0 |= 4;
         invited$field = param1;
      }
      
      public function set gameState(param1:uint) : void
      {
         hasField$0 |= 16;
         game_state$field = param1;
      }
   }
}

