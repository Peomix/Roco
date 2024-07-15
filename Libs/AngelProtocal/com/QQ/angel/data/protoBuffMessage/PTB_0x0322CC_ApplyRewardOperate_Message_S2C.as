package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x0322CC_ApplyRewardOperate_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var hasField$0:uint = 0;
      
      private var war_soul_count$field:uint;
      
      private var hurt_hp$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      public var rewardArray:Array;
      
      public function PTB_0x0322CC_ApplyRewardOperate_Message_S2C()
      {
         rewardArray = [];
         super();
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get hasWarSoulCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:ItemInfoChanged32_Message = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc6_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc6_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322CC_ApplyRewardOperate_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322CC_ApplyRewardOperate_Message_S2C.warSoulCount cannot be set twice.");
                  }
                  _loc4_++;
                  warSoulCount = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322CC_ApplyRewardOperate_Message_S2C.hurtHp cannot be set twice.");
                  }
                  _loc5_++;
                  hurtHp = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  _loc7_ = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  rewardArray.push(_loc7_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
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
         if(hasWarSoulCount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,war_soul_count$field);
         }
         if(hasHurtHp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,hurt_hp$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < rewardArray.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,rewardArray[_loc2_]);
            _loc2_++;
         }
      }
      
      public function removeHurtHp() : void
      {
         hasField$0 &= 4294967293;
         hurt_hp$field = new uint();
      }
      
      public function get warSoulCount() : uint
      {
         if(!hasWarSoulCount)
         {
            return 0;
         }
         return war_soul_count$field;
      }
      
      public function set warSoulCount(param1:uint) : void
      {
         hasField$0 |= 1;
         war_soul_count$field = param1;
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function set hurtHp(param1:uint) : void
      {
         hasField$0 |= 2;
         hurt_hp$field = param1;
      }
      
      public function get hasHurtHp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get hurtHp() : uint
      {
         if(!hasHurtHp)
         {
            return 0;
         }
         return hurt_hp$field;
      }
      
      public function removeWarSoulCount() : void
      {
         hasField$0 &= 4294967294;
         war_soul_count$field = new uint();
      }
   }
}
