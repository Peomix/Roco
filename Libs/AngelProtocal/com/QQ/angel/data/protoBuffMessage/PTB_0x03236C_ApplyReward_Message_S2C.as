package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x03236C_ApplyReward_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var hasField$0:uint = 0;
      
      private var send_mail_flag$field:uint;
      
      private var max_play_count$field:uint;
      
      private var has_play_count$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      public var rewardArray:Array;
      
      public function PTB_0x03236C_ApplyReward_Message_S2C()
      {
         rewardArray = [];
         super();
      }
      
      public function get hasPlayCount() : uint
      {
         if(!hasHasPlayCount)
         {
            return 0;
         }
         return has_play_count$field;
      }
      
      public function set hasPlayCount(param1:uint) : void
      {
         hasField$0 |= 1;
         has_play_count$field = param1;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function removeSendMailFlag() : void
      {
         hasField$0 &= 4294967291;
         send_mail_flag$field = new uint();
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
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03236C_ApplyReward_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03236C_ApplyReward_Message_S2C.hasPlayCount cannot be set twice.");
                  }
                  _loc4_++;
                  hasPlayCount = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03236C_ApplyReward_Message_S2C.maxPlayCount cannot be set twice.");
                  }
                  _loc5_++;
                  maxPlayCount = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03236C_ApplyReward_Message_S2C.sendMailFlag cannot be set twice.");
                  }
                  _loc6_++;
                  sendMailFlag = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  _loc8_ = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  rewardArray.push(_loc8_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
                  break;
            }
         }
      }
      
      public function set sendMailFlag(param1:uint) : void
      {
         hasField$0 |= 4;
         send_mail_flag$field = param1;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasHasPlayCount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,has_play_count$field);
         }
         if(hasMaxPlayCount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,max_play_count$field);
         }
         if(hasSendMailFlag)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,send_mail_flag$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < rewardArray.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,5);
            WriteUtils.write$TYPE_MESSAGE(param1,rewardArray[_loc2_]);
            _loc2_++;
         }
      }
      
      public function removeMaxPlayCount() : void
      {
         hasField$0 &= 4294967293;
         max_play_count$field = new uint();
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function removeHasPlayCount() : void
      {
         hasField$0 &= 4294967294;
         has_play_count$field = new uint();
      }
      
      public function get sendMailFlag() : uint
      {
         if(!hasSendMailFlag)
         {
            return 0;
         }
         return send_mail_flag$field;
      }
      
      public function get hasSendMailFlag() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get hasMaxPlayCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function set maxPlayCount(param1:uint) : void
      {
         hasField$0 |= 2;
         max_play_count$field = param1;
      }
      
      public function get maxPlayCount() : uint
      {
         if(!hasMaxPlayCount)
         {
            return 0;
         }
         return max_play_count$field;
      }
      
      public function get hasHasPlayCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
   }
}
