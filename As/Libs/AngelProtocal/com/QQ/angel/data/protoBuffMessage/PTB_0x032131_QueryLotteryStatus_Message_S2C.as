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
   
   public final class PTB_0x032131_QueryLotteryStatus_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var hasField$0:uint = 0;
      
      private var next_lottery_mon$field:int;
      
      private var next_lottery_mday$field:int;
      
      private var win_lottery$field:int;
      
      private var reward_status$field:int;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var buy_lottery$field:int;
      
      private var buy_button_status$field:int;
      
      public function PTB_0x032131_QueryLotteryStatus_Message_S2C()
      {
         super();
      }
      
      public function set rewardStatus(param1:int) : void
      {
         hasField$0 |= 4;
         reward_status$field = param1;
      }
      
      public function get nextLotteryMday() : int
      {
         if(!hasNextLotteryMday)
         {
            return 0;
         }
         return next_lottery_mday$field;
      }
      
      public function removeBuyLottery() : void
      {
         hasField$0 &= 4294967279;
         buy_lottery$field = new int();
      }
      
      public function get rewardStatus() : int
      {
         if(!hasRewardStatus)
         {
            return 0;
         }
         return reward_status$field;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get hasNextLotteryMday() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get hasWinLottery() : Boolean
      {
         return (hasField$0 & 32) != 0;
      }
      
      public function get hasNextLotteryMon() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set nextLotteryMday(param1:int) : void
      {
         hasField$0 |= 2;
         next_lottery_mday$field = param1;
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
                     throw new IOError("Bad data format: PTB_0x032131_QueryLotteryStatus_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032131_QueryLotteryStatus_Message_S2C.nextLotteryMon cannot be set twice.");
                  }
                  _loc4_++;
                  nextLotteryMon = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032131_QueryLotteryStatus_Message_S2C.nextLotteryMday cannot be set twice.");
                  }
                  _loc5_++;
                  nextLotteryMday = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032131_QueryLotteryStatus_Message_S2C.rewardStatus cannot be set twice.");
                  }
                  _loc6_++;
                  rewardStatus = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032131_QueryLotteryStatus_Message_S2C.buyButtonStatus cannot be set twice.");
                  }
                  _loc7_++;
                  buyButtonStatus = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032131_QueryLotteryStatus_Message_S2C.buyLottery cannot be set twice.");
                  }
                  _loc8_++;
                  buyLottery = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032131_QueryLotteryStatus_Message_S2C.winLottery cannot be set twice.");
                  }
                  _loc9_++;
                  winLottery = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
                  break;
            }
         }
      }
      
      public function set winLottery(param1:int) : void
      {
         hasField$0 |= 32;
         win_lottery$field = param1;
      }
      
      public function get hasBuyLottery() : Boolean
      {
         return (hasField$0 & 16) != 0;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasNextLotteryMon)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_INT32(param1,next_lottery_mon$field);
         }
         if(hasNextLotteryMday)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_INT32(param1,next_lottery_mday$field);
         }
         if(hasRewardStatus)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_INT32(param1,reward_status$field);
         }
         if(hasBuyButtonStatus)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_INT32(param1,buy_button_status$field);
         }
         if(hasBuyLottery)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_INT32(param1,buy_lottery$field);
         }
         if(hasWinLottery)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_INT32(param1,win_lottery$field);
         }
      }
      
      public function removeRewardStatus() : void
      {
         hasField$0 &= 4294967291;
         reward_status$field = new int();
      }
      
      public function set nextLotteryMon(param1:int) : void
      {
         hasField$0 |= 1;
         next_lottery_mon$field = param1;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get hasRewardStatus() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function removeBuyButtonStatus() : void
      {
         hasField$0 &= 4294967287;
         buy_button_status$field = new int();
      }
      
      public function set buyLottery(param1:int) : void
      {
         hasField$0 |= 16;
         buy_lottery$field = param1;
      }
      
      public function set buyButtonStatus(param1:int) : void
      {
         hasField$0 |= 8;
         buy_button_status$field = param1;
      }
      
      public function get nextLotteryMon() : int
      {
         if(!hasNextLotteryMon)
         {
            return 0;
         }
         return next_lottery_mon$field;
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function get buyLottery() : int
      {
         if(!hasBuyLottery)
         {
            return 0;
         }
         return buy_lottery$field;
      }
      
      public function get winLottery() : int
      {
         if(!hasWinLottery)
         {
            return 0;
         }
         return win_lottery$field;
      }
      
      public function removeNextLotteryMday() : void
      {
         hasField$0 &= 4294967293;
         next_lottery_mday$field = new int();
      }
      
      public function get buyButtonStatus() : int
      {
         if(!hasBuyButtonStatus)
         {
            return 0;
         }
         return buy_button_status$field;
      }
      
      public function get hasBuyButtonStatus() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function removeWinLottery() : void
      {
         hasField$0 &= 4294967263;
         win_lottery$field = new int();
      }
      
      public function removeNextLotteryMon() : void
      {
         hasField$0 &= 4294967294;
         next_lottery_mon$field = new int();
      }
   }
}
