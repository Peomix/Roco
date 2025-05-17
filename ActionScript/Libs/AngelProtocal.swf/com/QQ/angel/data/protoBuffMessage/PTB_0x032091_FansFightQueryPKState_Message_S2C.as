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
   
   public final class PTB_0x032091_FansFightQueryPKState_Message_S2C extends Message implements IExternalizable
   {
      
      private var hasField$0:uint = 0;
      
      private var score_dimo$field:uint;
      
      private var score_duck$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var got_reward$field:uint;
      
      private var star$field:uint;
      
      public function PTB_0x032091_FansFightQueryPKState_Message_S2C()
      {
         super();
      }
      
      public function removeScoreDuck() : void
      {
         hasField$0 &= 4294967293;
         score_duck$field = new uint();
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get star() : uint
      {
         if(!hasStar)
         {
            return 0;
         }
         return star$field;
      }
      
      public function get hasStar() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set scoreDuck(param1:uint) : void
      {
         hasField$0 |= 2;
         score_duck$field = param1;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasStar)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,star$field);
         }
         if(hasScoreDuck)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,score_duck$field);
         }
         if(hasScoreDimo)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,score_dimo$field);
         }
         if(hasGotReward)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,got_reward$field);
         }
      }
      
      public function get gotReward() : uint
      {
         if(!hasGotReward)
         {
            return 0;
         }
         return got_reward$field;
      }
      
      public function get hasScoreDimo() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function get scoreDimo() : uint
      {
         if(!hasScoreDimo)
         {
            return 0;
         }
         return score_dimo$field;
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function set star(param1:uint) : void
      {
         hasField$0 |= 1;
         star$field = param1;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc8_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc8_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032091_FansFightQueryPKState_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032091_FansFightQueryPKState_Message_S2C.star cannot be set twice.");
                  }
                  _loc4_++;
                  star = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032091_FansFightQueryPKState_Message_S2C.scoreDuck cannot be set twice.");
                  }
                  _loc5_++;
                  scoreDuck = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032091_FansFightQueryPKState_Message_S2C.scoreDimo cannot be set twice.");
                  }
                  _loc6_++;
                  scoreDimo = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032091_FansFightQueryPKState_Message_S2C.gotReward cannot be set twice.");
                  }
                  _loc7_++;
                  gotReward = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
                  break;
            }
         }
      }
      
      public function get scoreDuck() : uint
      {
         if(!hasScoreDuck)
         {
            return 0;
         }
         return score_duck$field;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get hasScoreDuck() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set scoreDimo(param1:uint) : void
      {
         hasField$0 |= 4;
         score_dimo$field = param1;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function removeScoreDimo() : void
      {
         hasField$0 &= 4294967291;
         score_dimo$field = new uint();
      }
      
      public function removeStar() : void
      {
         hasField$0 &= 4294967294;
         star$field = new uint();
      }
      
      public function removeGotReward() : void
      {
         hasField$0 &= 4294967287;
         got_reward$field = new uint();
      }
      
      public function get hasGotReward() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set gotReward(param1:uint) : void
      {
         hasField$0 |= 8;
         got_reward$field = param1;
      }
   }
}

