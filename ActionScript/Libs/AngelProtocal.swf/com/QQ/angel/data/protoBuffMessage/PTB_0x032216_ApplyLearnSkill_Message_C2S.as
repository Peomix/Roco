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
   
   public final class PTB_0x032216_ApplyLearnSkill_Message_C2S extends Message implements IExternalizable
   {
      
      private var skill_id$field:uint;
      
      private var hasField$0:uint = 0;
      
      public function PTB_0x032216_ApplyLearnSkill_Message_C2S()
      {
         super();
      }
      
      public function removeSkillId() : void
      {
         hasField$0 &= 4294967294;
         skill_id$field = new uint();
      }
      
      public function get skillId() : uint
      {
         if(!hasSkillId)
         {
            return 0;
         }
         return skill_id$field;
      }
      
      public function get hasSkillId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set skillId(param1:uint) : void
      {
         hasField$0 |= 1;
         skill_id$field = param1;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc4_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc4_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032216_ApplyLearnSkill_Message_C2S.skillId cannot be set twice.");
                  }
                  _loc3_++;
                  skillId = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
                  break;
            }
         }
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,skill_id$field);
         }
      }
   }
}

