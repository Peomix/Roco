package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x0320DA_QueryBossStatus_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var ret_code$field:ReturnCode_Message;
      
      private var hasField$0:uint = 0;
      
      public var bossRewards:Array;
      
      private var today_rewards$field:uint;
      
      public function PTB_0x0320DA_QueryBossStatus_Message_S2C()
      {
         bossRewards = [];
         super();
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function set todayRewards(param1:uint) : void
      {
         hasField$0 |= 1;
         today_rewards$field = param1;
      }
      
      public function removeTodayRewards() : void
      {
         hasField$0 &= 4294967294;
         today_rewards$field = new uint();
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get todayRewards() : uint
      {
         if(!hasTodayRewards)
         {
            return 0;
         }
         return today_rewards$field;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
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
                     throw new IOError("Bad data format: PTB_0x0320DA_QueryBossStatus_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if((_loc5_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,bossRewards);
                  }
                  else
                  {
                     bossRewards.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320DA_QueryBossStatus_Message_S2C.todayRewards cannot be set twice.");
                  }
                  _loc4_++;
                  todayRewards = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
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
         var _loc2_:uint = 0;
         while(_loc2_ < bossRewards.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,bossRewards[_loc2_]);
            _loc2_++;
         }
         if(hasTodayRewards)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,today_rewards$field);
         }
      }
      
      public function get hasTodayRewards() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
   }
}
