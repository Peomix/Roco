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
   
   public final class PTB_0x000001_OnStatLog_Message_C2S extends Message implements IExternalizable
   {
      
      private var hasField$0:uint = 0;
      
      private var cmd$field:uint;
      
      private var id$field:uint;
      
      public function PTB_0x000001_OnStatLog_Message_C2S()
      {
         super();
      }
      
      public function get hasCmd() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCmd)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,cmd$field);
         }
         if(hasId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,id$field);
         }
      }
      
      public function set cmd(param1:uint) : void
      {
         hasField$0 |= 1;
         cmd$field = param1;
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function removeCmd() : void
      {
         hasField$0 &= 4294967294;
         cmd$field = new uint();
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
                     throw new IOError("Bad data format: PTB_0x000001_OnStatLog_Message_C2S.cmd cannot be set twice.");
                  }
                  _loc3_++;
                  cmd = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x000001_OnStatLog_Message_C2S.id cannot be set twice.");
                  }
                  _loc4_++;
                  id = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
                  break;
            }
         }
      }
      
      public function get cmd() : uint
      {
         if(!hasCmd)
         {
            return 0;
         }
         return cmd$field;
      }
      
      public function get id() : uint
      {
         if(!hasId)
         {
            return 0;
         }
         return id$field;
      }
      
      public function set id(param1:uint) : void
      {
         hasField$0 |= 2;
         id$field = param1;
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967293;
         id$field = new uint();
      }
   }
}

