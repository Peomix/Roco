package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x032010_QueryZoneWolfGameState_Message_S2C extends Message implements IExternalizable
   {
      
      private var hasField$0:uint = 0;
      
      private var today_time$field:uint;
      
      private var next_day_time$field:uint;
      
      public var npcHp:Array = [];
      
      private var time_left$field:uint;
      
      public var npcType:Array = [];
      
      private var winner$field:uint;
      
      private var game_id$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var round$field:uint;
      
      public var npcId:Array = [];
      
      public function PTB_0x032010_QueryZoneWolfGameState_Message_S2C()
      {
         super();
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get round() : uint
      {
         if(!hasRound)
         {
            return 0;
         }
         return round$field;
      }
      
      public function removeTodayTime() : void
      {
         hasField$0 &= 4294967279;
         today_time$field = new uint();
      }
      
      public function get hasRound() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get nextDayTime() : uint
      {
         if(!hasNextDayTime)
         {
            return 0;
         }
         return next_day_time$field;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc10_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc10_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032010_QueryZoneWolfGameState_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032010_QueryZoneWolfGameState_Message_S2C.gameId cannot be set twice.");
                  }
                  _loc4_++;
                  gameId = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032010_QueryZoneWolfGameState_Message_S2C.round cannot be set twice.");
                  }
                  _loc5_++;
                  round = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032010_QueryZoneWolfGameState_Message_S2C.winner cannot be set twice.");
                  }
                  _loc6_++;
                  winner = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if((_loc10_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,npcId);
                  }
                  else
                  {
                     npcId.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 6:
                  if((_loc10_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,npcType);
                  }
                  else
                  {
                     npcType.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 7:
                  if((_loc10_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,npcHp);
                  }
                  else
                  {
                     npcHp.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032010_QueryZoneWolfGameState_Message_S2C.timeLeft cannot be set twice.");
                  }
                  _loc7_++;
                  timeLeft = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032010_QueryZoneWolfGameState_Message_S2C.todayTime cannot be set twice.");
                  }
                  _loc8_++;
                  todayTime = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 10:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032010_QueryZoneWolfGameState_Message_S2C.nextDayTime cannot be set twice.");
                  }
                  _loc9_++;
                  nextDayTime = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
                  break;
            }
         }
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasGameId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,game_id$field);
         }
         if(hasRound)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,round$field);
         }
         if(hasWinner)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,winner$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < npcId.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,npcId[_loc2_]);
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < npcType.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,npcType[_loc3_]);
            _loc3_++;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < npcHp.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,npcHp[_loc4_]);
            _loc4_++;
         }
         if(hasTimeLeft)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,8);
            WriteUtils.write$TYPE_UINT32(param1,time_left$field);
         }
         if(hasTodayTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,9);
            WriteUtils.write$TYPE_UINT32(param1,today_time$field);
         }
         if(hasNextDayTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,10);
            WriteUtils.write$TYPE_UINT32(param1,next_day_time$field);
         }
      }
      
      public function get hasNextDayTime() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function removeTimeLeft() : void
      {
         hasField$0 &= 4294967287;
         time_left$field = new uint();
      }
      
      public function set round(param1:uint) : void
      {
         hasField$0 |= 2;
         round$field = param1;
      }
      
      public function set nextDayTime(param1:uint) : void
      {
         hasField$0 |= 32;
         next_day_time$field = param1;
      }
      
      public function get gameId() : uint
      {
         if(!hasGameId)
         {
            return 0;
         }
         return game_id$field;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get hasTodayTime() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function get hasTimeLeft() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get todayTime() : uint
      {
         if(!hasTodayTime)
         {
            return 0;
         }
         return today_time$field;
      }
      
      public function get winner() : uint
      {
         if(!hasWinner)
         {
            return 0;
         }
         return winner$field;
      }
      
      public function removeGameId() : void
      {
         hasField$0 &= 4294967294;
         game_id$field = new uint();
      }
      
      public function set gameId(param1:uint) : void
      {
         hasField$0 |= 1;
         game_id$field = param1;
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function set todayTime(param1:uint) : void
      {
         hasField$0 |= 16;
         today_time$field = param1;
      }
      
      public function get hasGameId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set timeLeft(param1:uint) : void
      {
         hasField$0 |= 8;
         time_left$field = param1;
      }
      
      public function removeRound() : void
      {
         hasField$0 &= 4294967293;
         round$field = new uint();
      }
      
      public function removeNextDayTime() : void
      {
         hasField$0 &= 4294967263;
         next_day_time$field = new uint();
      }
      
      public function get timeLeft() : uint
      {
         if(!hasTimeLeft)
         {
            return 0;
         }
         return time_left$field;
      }
      
      public function get hasWinner() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function removeWinner() : void
      {
         hasField$0 &= 4294967291;
         winner$field = new uint();
      }
      
      public function set winner(param1:uint) : void
      {
         hasField$0 |= 4;
         winner$field = param1;
      }
   }
}

