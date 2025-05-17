package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x032011_ZoneWolfNotifyGameState_Message_S2C extends Message implements IExternalizable
   {
      
      public var npcHp:Array = [];
      
      private var hasField$0:uint = 0;
      
      public var actId:Array = [];
      
      private var time_left$field:uint;
      
      private var winner$field:uint;
      
      private var game_id$field:uint;
      
      public var npcId:Array = [];
      
      private var round$field:uint;
      
      public var passiveCount:Array = [];
      
      public var damage:Array = [];
      
      public var npcType:Array = [];
      
      public function PTB_0x032011_ZoneWolfNotifyGameState_Message_S2C()
      {
         super();
      }
      
      public function get round() : uint
      {
         if(!hasRound)
         {
            return 0;
         }
         return round$field;
      }
      
      public function removeGameId() : void
      {
         hasField$0 &= 4294967294;
         game_id$field = new uint();
      }
      
      public function get hasRound() : Boolean
      {
         return (hasField$0 & 2) != 0;
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
                     throw new IOError("Bad data format: PTB_0x032011_ZoneWolfNotifyGameState_Message_S2C.gameId cannot be set twice.");
                  }
                  _loc3_++;
                  gameId = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032011_ZoneWolfNotifyGameState_Message_S2C.round cannot be set twice.");
                  }
                  _loc4_++;
                  round = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032011_ZoneWolfNotifyGameState_Message_S2C.winner cannot be set twice.");
                  }
                  _loc5_++;
                  winner = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if((_loc7_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,npcId);
                  }
                  else
                  {
                     npcId.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 5:
                  if((_loc7_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,npcType);
                  }
                  else
                  {
                     npcType.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 6:
                  if((_loc7_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,npcHp);
                  }
                  else
                  {
                     npcHp.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 7:
                  if((_loc7_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,actId);
                  }
                  else
                  {
                     actId.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 8:
                  if((_loc7_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,passiveCount);
                  }
                  else
                  {
                     passiveCount.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 9:
                  if((_loc7_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,damage);
                  }
                  else
                  {
                     damage.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 10:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032011_ZoneWolfNotifyGameState_Message_S2C.timeLeft cannot be set twice.");
                  }
                  _loc6_++;
                  timeLeft = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
                  break;
            }
         }
      }
      
      public function set gameId(param1:uint) : void
      {
         hasField$0 |= 1;
         game_id$field = param1;
      }
      
      public function set round(param1:uint) : void
      {
         hasField$0 |= 2;
         round$field = param1;
      }
      
      public function removeTimeLeft() : void
      {
         hasField$0 &= 4294967287;
         time_left$field = new uint();
      }
      
      public function get hasGameId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGameId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,game_id$field);
         }
         if(hasRound)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,round$field);
         }
         if(hasWinner)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,winner$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < npcId.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,npcId[_loc2_]);
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < npcType.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,npcType[_loc3_]);
            _loc3_++;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < npcHp.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,npcHp[_loc4_]);
            _loc4_++;
         }
         var _loc5_:uint = 0;
         while(_loc5_ < actId.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,actId[_loc5_]);
            _loc5_++;
         }
         var _loc6_:uint = 0;
         while(_loc6_ < passiveCount.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,8);
            WriteUtils.write$TYPE_UINT32(param1,passiveCount[_loc6_]);
            _loc6_++;
         }
         var _loc7_:uint = 0;
         while(_loc7_ < damage.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,9);
            WriteUtils.write$TYPE_UINT32(param1,damage[_loc7_]);
            _loc7_++;
         }
         if(hasTimeLeft)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,10);
            WriteUtils.write$TYPE_UINT32(param1,time_left$field);
         }
      }
      
      public function get gameId() : uint
      {
         if(!hasGameId)
         {
            return 0;
         }
         return game_id$field;
      }
      
      public function get hasTimeLeft() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function removeRound() : void
      {
         hasField$0 &= 4294967293;
         round$field = new uint();
      }
      
      public function removeWinner() : void
      {
         hasField$0 &= 4294967291;
         winner$field = new uint();
      }
      
      public function get timeLeft() : uint
      {
         if(!hasTimeLeft)
         {
            return 0;
         }
         return time_left$field;
      }
      
      public function set timeLeft(param1:uint) : void
      {
         hasField$0 |= 8;
         time_left$field = param1;
      }
      
      public function get hasWinner() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set winner(param1:uint) : void
      {
         hasField$0 |= 4;
         winner$field = param1;
      }
      
      public function get winner() : uint
      {
         if(!hasWinner)
         {
            return 0;
         }
         return winner$field;
      }
   }
}

