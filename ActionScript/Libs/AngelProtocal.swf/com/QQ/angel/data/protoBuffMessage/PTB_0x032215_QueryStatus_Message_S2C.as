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
   
   public final class PTB_0x032215_QueryStatus_Message_S2C extends Message implements IExternalizable
   {
      
      private var skill_id$field:uint;
      
      private var time_active$field:uint;
      
      private var hasField$0:uint = 0;
      
      public function PTB_0x032215_QueryStatus_Message_S2C()
      {
         super();
      }
      
      public function removeSkillId() : void
      {
         hasField$0 &= 4294967294;
         skill_id$field = new uint();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,skill_id$field);
         }
         if(hasTimeActive)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,time_active$field);
         }
      }
      
      public function get skillId() : uint
      {
         if(!hasSkillId)
         {
            return 0;
         }
         return skill_id$field;
      }
      
      public function get hasTimeActive() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get hasSkillId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set timeActive(param1:uint) : void
      {
         hasField$0 |= 2;
         time_active$field = param1;
      }
      
      public function removeTimeActive() : void
      {
         hasField$0 &= 4294967293;
         time_active$field = new uint();
      }
      
      public function set skillId(param1:uint) : void
      {
         hasField$0 |= 1;
         skill_id$field = param1;
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
                     throw new IOError("Bad data format: PTB_0x032215_QueryStatus_Message_S2C.skillId cannot be set twice.");
                  }
                  _loc3_++;
                  skillId = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032215_QueryStatus_Message_S2C.timeActive cannot be set twice.");
                  }
                  _loc4_++;
                  timeActive = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
                  break;
            }
         }
      }
      
      public function get timeActive() : uint
      {
         if(!hasTimeActive)
         {
            return 0;
         }
         return time_active$field;
      }
   }
}

