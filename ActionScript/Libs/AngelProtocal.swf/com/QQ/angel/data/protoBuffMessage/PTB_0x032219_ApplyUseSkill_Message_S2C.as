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
   
   public final class PTB_0x032219_ApplyUseSkill_Message_S2C extends Message implements IExternalizable
   {
      
      private var hasField$0:uint = 0;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var chest_left_time$field:uint;
      
      private var npc_h_p0$field:uint;
      
      private var npc_exist$field:uint;
      
      private var npc_h_p1$field:uint;
      
      public function PTB_0x032219_ApplyUseSkill_Message_S2C()
      {
         super();
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function removeNpcHP0() : void
      {
         hasField$0 &= 4294967293;
         npc_h_p0$field = new uint();
      }
      
      public function removeNpcHP1() : void
      {
         hasField$0 &= 4294967291;
         npc_h_p1$field = new uint();
      }
      
      public function set npcHP0(param1:uint) : void
      {
         hasField$0 |= 2;
         npc_h_p0$field = param1;
      }
      
      public function get hasNpcExist() : Boolean
      {
         return (hasField$0 & 1) != 0;
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
                     throw new IOError("Bad data format: PTB_0x032219_ApplyUseSkill_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032219_ApplyUseSkill_Message_S2C.npcExist cannot be set twice.");
                  }
                  _loc4_++;
                  npcExist = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032219_ApplyUseSkill_Message_S2C.npcHP0 cannot be set twice.");
                  }
                  _loc5_++;
                  npcHP0 = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032219_ApplyUseSkill_Message_S2C.npcHP1 cannot be set twice.");
                  }
                  _loc6_++;
                  npcHP1 = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032219_ApplyUseSkill_Message_S2C.chestLeftTime cannot be set twice.");
                  }
                  _loc7_++;
                  chestLeftTime = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
                  break;
            }
         }
      }
      
      public function get chestLeftTime() : uint
      {
         if(!hasChestLeftTime)
         {
            return 0;
         }
         return chest_left_time$field;
      }
      
      public function get npcExist() : uint
      {
         if(!hasNpcExist)
         {
            return 0;
         }
         return npc_exist$field;
      }
      
      public function set npcHP1(param1:uint) : void
      {
         hasField$0 |= 4;
         npc_h_p1$field = param1;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasNpcExist)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,npc_exist$field);
         }
         if(hasNpcHP0)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,npc_h_p0$field);
         }
         if(hasNpcHP1)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,npc_h_p1$field);
         }
         if(hasChestLeftTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,chest_left_time$field);
         }
      }
      
      public function get hasChestLeftTime() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function get hasNpcHP1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function get npcHP0() : uint
      {
         if(!hasNpcHP0)
         {
            return 0;
         }
         return npc_h_p0$field;
      }
      
      public function get hasNpcHP0() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set chestLeftTime(param1:uint) : void
      {
         hasField$0 |= 8;
         chest_left_time$field = param1;
      }
      
      public function set npcExist(param1:uint) : void
      {
         hasField$0 |= 1;
         npc_exist$field = param1;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function removeChestLeftTime() : void
      {
         hasField$0 &= 4294967287;
         chest_left_time$field = new uint();
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get npcHP1() : uint
      {
         if(!hasNpcHP1)
         {
            return 0;
         }
         return npc_h_p1$field;
      }
      
      public function removeNpcExist() : void
      {
         hasField$0 &= 4294967294;
         npc_exist$field = new uint();
      }
   }
}

