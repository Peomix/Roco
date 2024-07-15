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
   
   public final class PTB_0x032239_ApplyHit_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var hasField$0:uint = 0;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var current_hp$field:uint;
      
      private var total_hp$field:uint;
      
      public function PTB_0x032239_ApplyHit_Message_S2C()
      {
         super();
      }
      
      public function set currentHp(param1:uint) : void
      {
         hasField$0 |= 1;
         current_hp$field = param1;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function removeTotalHp() : void
      {
         hasField$0 &= 4294967293;
         total_hp$field = new uint();
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
                     throw new IOError("Bad data format: PTB_0x032239_ApplyHit_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032239_ApplyHit_Message_S2C.currentHp cannot be set twice.");
                  }
                  _loc4_++;
                  currentHp = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032239_ApplyHit_Message_S2C.totalHp cannot be set twice.");
                  }
                  _loc5_++;
                  totalHp = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
                  break;
            }
         }
      }
      
      public function get hasTotalHp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasCurrentHp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,current_hp$field);
         }
         if(hasTotalHp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,total_hp$field);
         }
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function set totalHp(param1:uint) : void
      {
         hasField$0 |= 2;
         total_hp$field = param1;
      }
      
      public function get hasCurrentHp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get currentHp() : uint
      {
         if(!hasCurrentHp)
         {
            return 0;
         }
         return current_hp$field;
      }
      
      public function get totalHp() : uint
      {
         if(!hasTotalHp)
         {
            return 0;
         }
         return total_hp$field;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function removeCurrentHp() : void
      {
         hasField$0 &= 4294967294;
         current_hp$field = new uint();
      }
   }
}
