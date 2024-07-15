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
   
   public final class PTB_0x0300A3_OnCourageNpcRefreshNotify_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var hasField$0:uint = 0;
      
      private var verse_index$field:uint;
      
      private var true_npc_id$field:uint;
      
      private var false_npc_id$field:uint;
      
      public function PTB_0x0300A3_OnCourageNpcRefreshNotify_Message_S2C()
      {
         super();
      }
      
      public function removeVerseIndex() : void
      {
         hasField$0 &= 4294967291;
         verse_index$field = new uint();
      }
      
      public function removeTrueNpcId() : void
      {
         hasField$0 &= 4294967294;
         true_npc_id$field = new uint();
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:uint = 0;
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
                     throw new IOError("Bad data format: PTB_0x0300A3_OnCourageNpcRefreshNotify_Message_S2C.trueNpcId cannot be set twice.");
                  }
                  _loc3_++;
                  trueNpcId = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300A3_OnCourageNpcRefreshNotify_Message_S2C.falseNpcId cannot be set twice.");
                  }
                  _loc4_++;
                  falseNpcId = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300A3_OnCourageNpcRefreshNotify_Message_S2C.verseIndex cannot be set twice.");
                  }
                  _loc5_++;
                  verseIndex = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
                  break;
            }
         }
      }
      
      public function get hasVerseIndex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTrueNpcId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,true_npc_id$field);
         }
         if(hasFalseNpcId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,false_npc_id$field);
         }
         if(hasVerseIndex)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,verse_index$field);
         }
      }
      
      public function set trueNpcId(param1:uint) : void
      {
         hasField$0 |= 1;
         true_npc_id$field = param1;
      }
      
      public function get verseIndex() : uint
      {
         if(!hasVerseIndex)
         {
            return 0;
         }
         return verse_index$field;
      }
      
      public function removeFalseNpcId() : void
      {
         hasField$0 &= 4294967293;
         false_npc_id$field = new uint();
      }
      
      public function get trueNpcId() : uint
      {
         if(!hasTrueNpcId)
         {
            return 0;
         }
         return true_npc_id$field;
      }
      
      public function set falseNpcId(param1:uint) : void
      {
         hasField$0 |= 2;
         false_npc_id$field = param1;
      }
      
      public function get hasFalseNpcId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get hasTrueNpcId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get falseNpcId() : uint
      {
         if(!hasFalseNpcId)
         {
            return 0;
         }
         return false_npc_id$field;
      }
      
      public function set verseIndex(param1:uint) : void
      {
         hasField$0 |= 4;
         verse_index$field = param1;
      }
   }
}
