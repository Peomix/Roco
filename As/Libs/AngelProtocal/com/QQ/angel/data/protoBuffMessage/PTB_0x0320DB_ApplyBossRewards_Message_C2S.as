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
   
   public final class PTB_0x0320DB_ApplyBossRewards_Message_C2S extends Message implements IExternalizable
   {
       
      
      private var rewards_index$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var boss_index$field:uint;
      
      public function PTB_0x0320DB_ApplyBossRewards_Message_C2S()
      {
         super();
      }
      
      public function get bossIndex() : uint
      {
         if(!hasBossIndex)
         {
            return 0;
         }
         return boss_index$field;
      }
      
      public function get hasRewardsIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRewardsIndex)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,rewards_index$field);
         }
         if(hasBossIndex)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,boss_index$field);
         }
      }
      
      public function get hasBossIndex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get rewardsIndex() : uint
      {
         if(!hasRewardsIndex)
         {
            return 0;
         }
         return rewards_index$field;
      }
      
      public function removeBossIndex() : void
      {
         hasField$0 &= 4294967293;
         boss_index$field = new uint();
      }
      
      public function set bossIndex(param1:uint) : void
      {
         hasField$0 |= 2;
         boss_index$field = param1;
      }
      
      public function removeRewardsIndex() : void
      {
         hasField$0 &= 4294967294;
         rewards_index$field = new uint();
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:uint = 0;
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
                     throw new IOError("Bad data format: PTB_0x0320DB_ApplyBossRewards_Message_C2S.rewardsIndex cannot be set twice.");
                  }
                  _loc3_++;
                  rewardsIndex = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320DB_ApplyBossRewards_Message_C2S.bossIndex cannot be set twice.");
                  }
                  _loc4_++;
                  bossIndex = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
                  break;
            }
         }
      }
      
      public function set rewardsIndex(param1:uint) : void
      {
         hasField$0 |= 1;
         rewards_index$field = param1;
      }
   }
}
