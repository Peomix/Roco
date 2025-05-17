package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x032090_FansFightQueryState_Message_S2C extends Message implements IExternalizable
   {
      
      private var cartoon$field:uint;
      
      private var process$field:uint;
      
      private var day_reward$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var star$field:uint;
      
      public var dipan:Array = [];
      
      public function PTB_0x032090_FansFightQueryState_Message_S2C()
      {
         super();
      }
      
      public function removeDayReward() : void
      {
         hasField$0 &= 4294967293;
         day_reward$field = new uint();
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function removeProcess() : void
      {
         hasField$0 &= 4294967291;
         process$field = new uint();
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
      
      public function set dayReward(param1:uint) : void
      {
         hasField$0 |= 2;
         day_reward$field = param1;
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
         if(hasDayReward)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,day_reward$field);
         }
         if(hasProcess)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,process$field);
         }
         if(hasCartoon)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,cartoon$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < dipan.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,dipan[_loc2_]);
            _loc2_++;
         }
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function set process(param1:uint) : void
      {
         hasField$0 |= 4;
         process$field = param1;
      }
      
      public function removeCartoon() : void
      {
         hasField$0 &= 4294967287;
         cartoon$field = new uint();
      }
      
      public function set cartoon(param1:uint) : void
      {
         hasField$0 |= 8;
         cartoon$field = param1;
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
                     throw new IOError("Bad data format: PTB_0x032090_FansFightQueryState_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032090_FansFightQueryState_Message_S2C.star cannot be set twice.");
                  }
                  _loc4_++;
                  star = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032090_FansFightQueryState_Message_S2C.dayReward cannot be set twice.");
                  }
                  _loc5_++;
                  dayReward = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032090_FansFightQueryState_Message_S2C.process cannot be set twice.");
                  }
                  _loc6_++;
                  process = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032090_FansFightQueryState_Message_S2C.cartoon cannot be set twice.");
                  }
                  _loc7_++;
                  cartoon = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 6:
                  if((_loc8_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,dipan);
                  }
                  else
                  {
                     dipan.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
                  break;
            }
         }
      }
      
      public function get dayReward() : uint
      {
         if(!hasDayReward)
         {
            return 0;
         }
         return day_reward$field;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get process() : uint
      {
         if(!hasProcess)
         {
            return 0;
         }
         return process$field;
      }
      
      public function get hasDayReward() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get hasProcess() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function removeStar() : void
      {
         hasField$0 &= 4294967294;
         star$field = new uint();
      }
      
      public function get hasCartoon() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function get cartoon() : uint
      {
         if(!hasCartoon)
         {
            return 0;
         }
         return cartoon$field;
      }
   }
}

