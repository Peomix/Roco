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
   
   public final class PTB_0x0300A5_OnCourageHpNotify_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var true_hp$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var false_hp$field:uint;
      
      public function PTB_0x0300A5_OnCourageHpNotify_Message_S2C()
      {
         super();
      }
      
      public function removeFalseHp() : void
      {
         hasField$0 &= 4294967293;
         false_hp$field = new uint();
      }
      
      public function removeTrueHp() : void
      {
         hasField$0 &= 4294967294;
         true_hp$field = new uint();
      }
      
      public function get falseHp() : uint
      {
         if(!hasFalseHp)
         {
            return 0;
         }
         return false_hp$field;
      }
      
      public function set trueHp(param1:uint) : void
      {
         hasField$0 |= 1;
         true_hp$field = param1;
      }
      
      public function get hasTrueHp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get hasFalseHp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTrueHp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,true_hp$field);
         }
         if(hasFalseHp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,false_hp$field);
         }
      }
      
      public function get trueHp() : uint
      {
         if(!hasTrueHp)
         {
            return 0;
         }
         return true_hp$field;
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
                     throw new IOError("Bad data format: PTB_0x0300A5_OnCourageHpNotify_Message_S2C.trueHp cannot be set twice.");
                  }
                  _loc3_++;
                  trueHp = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300A5_OnCourageHpNotify_Message_S2C.falseHp cannot be set twice.");
                  }
                  _loc4_++;
                  falseHp = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
                  break;
            }
         }
      }
      
      public function set falseHp(param1:uint) : void
      {
         hasField$0 |= 2;
         false_hp$field = param1;
      }
   }
}
