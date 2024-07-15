package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x0323A3_OnCatchSpirit_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var mission_id$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var max_play_count$field:uint;
      
      private var play_count$field:uint;
      
      private var mission_status$field:uint;
      
      public var rewardArray:Array;
      
      public function PTB_0x0323A3_OnCatchSpirit_Message_S2C()
      {
         rewardArray = [];
         super();
      }
      
      public function get hasPlayCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get missionId() : uint
      {
         if(!hasMissionId)
         {
            return 0;
         }
         return mission_id$field;
      }
      
      public function get hasMissionId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set missionId(param1:uint) : void
      {
         hasField$0 |= 4;
         mission_id$field = param1;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:uint = 0;
         var _loc8_:ItemInfoChanged32_Message = null;
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
                  _loc8_ = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  rewardArray.push(_loc8_);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0323A3_OnCatchSpirit_Message_S2C.playCount cannot be set twice.");
                  }
                  _loc3_++;
                  playCount = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0323A3_OnCatchSpirit_Message_S2C.maxPlayCount cannot be set twice.");
                  }
                  _loc4_++;
                  maxPlayCount = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0323A3_OnCatchSpirit_Message_S2C.missionId cannot be set twice.");
                  }
                  _loc5_++;
                  missionId = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0323A3_OnCatchSpirit_Message_S2C.missionStatus cannot be set twice.");
                  }
                  _loc6_++;
                  missionStatus = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
                  break;
            }
         }
      }
      
      public function removePlayCount() : void
      {
         hasField$0 &= 4294967294;
         play_count$field = new uint();
      }
      
      public function removeMaxPlayCount() : void
      {
         hasField$0 &= 4294967293;
         max_play_count$field = new uint();
      }
      
      public function get missionStatus() : uint
      {
         if(!hasMissionStatus)
         {
            return 0;
         }
         return mission_status$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < rewardArray.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,rewardArray[_loc2_]);
            _loc2_++;
         }
         if(hasPlayCount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,play_count$field);
         }
         if(hasMaxPlayCount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,max_play_count$field);
         }
         if(hasMissionId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,mission_id$field);
         }
         if(hasMissionStatus)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,mission_status$field);
         }
      }
      
      public function removeMissionId() : void
      {
         hasField$0 &= 4294967291;
         mission_id$field = new uint();
      }
      
      public function get hasMissionStatus() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set maxPlayCount(param1:uint) : void
      {
         hasField$0 |= 2;
         max_play_count$field = param1;
      }
      
      public function get hasMaxPlayCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set playCount(param1:uint) : void
      {
         hasField$0 |= 1;
         play_count$field = param1;
      }
      
      public function get maxPlayCount() : uint
      {
         if(!hasMaxPlayCount)
         {
            return 0;
         }
         return max_play_count$field;
      }
      
      public function removeMissionStatus() : void
      {
         hasField$0 &= 4294967287;
         mission_status$field = new uint();
      }
      
      public function get playCount() : uint
      {
         if(!hasPlayCount)
         {
            return 0;
         }
         return play_count$field;
      }
      
      public function set missionStatus(param1:uint) : void
      {
         hasField$0 |= 8;
         mission_status$field = param1;
      }
   }
}
