package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x032018_onNotifyGameState_Message_S2C extends Message implements IExternalizable
   {
      
      private var hasField$0:uint = 0;
      
      private var game_time$field:uint;
      
      private var game_i_d$field:uint;
      
      private var game_state$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      public var posReward:Array = [];
      
      public var posUin:Array = [];
      
      public var posAnswer:Array = [];
      
      public function PTB_0x032018_onNotifyGameState_Message_S2C()
      {
         super();
      }
      
      public function removeGameTime() : void
      {
         hasField$0 &= 4294967291;
         game_time$field = new uint();
      }
      
      public function get hasGameState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get hasGameID() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get gameID() : uint
      {
         if(!hasGameID)
         {
            return 0;
         }
         return game_i_d$field;
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
                     throw new IOError("Bad data format: PTB_0x032018_onNotifyGameState_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032018_onNotifyGameState_Message_S2C.gameID cannot be set twice.");
                  }
                  _loc4_++;
                  gameID = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032018_onNotifyGameState_Message_S2C.gameState cannot be set twice.");
                  }
                  _loc5_++;
                  gameState = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if((_loc7_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,posAnswer);
                  }
                  else
                  {
                     posAnswer.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 5:
                  if((_loc7_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,posReward);
                  }
                  else
                  {
                     posReward.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 6:
                  if((_loc7_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,posUin);
                  }
                  else
                  {
                     posUin.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032018_onNotifyGameState_Message_S2C.gameTime cannot be set twice.");
                  }
                  _loc6_++;
                  gameTime = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
                  break;
            }
         }
      }
      
      public function set gameTime(param1:uint) : void
      {
         hasField$0 |= 4;
         game_time$field = param1;
      }
      
      public function get hasGameTime() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function removeGameState() : void
      {
         hasField$0 &= 4294967293;
         game_state$field = new uint();
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function get gameTime() : uint
      {
         if(!hasGameTime)
         {
            return 0;
         }
         return game_time$field;
      }
      
      public function set gameID(param1:uint) : void
      {
         hasField$0 |= 1;
         game_i_d$field = param1;
      }
      
      public function removeGameID() : void
      {
         hasField$0 &= 4294967294;
         game_i_d$field = new uint();
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
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
         if(hasGameID)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,game_i_d$field);
         }
         if(hasGameState)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,game_state$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < posAnswer.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,posAnswer[_loc2_]);
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < posReward.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,posReward[_loc3_]);
            _loc3_++;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < posUin.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,posUin[_loc4_]);
            _loc4_++;
         }
         if(hasGameTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,game_time$field);
         }
      }
      
      public function set gameState(param1:uint) : void
      {
         hasField$0 |= 2;
         game_state$field = param1;
      }
      
      public function get gameState() : uint
      {
         if(!hasGameState)
         {
            return 0;
         }
         return game_state$field;
      }
   }
}

