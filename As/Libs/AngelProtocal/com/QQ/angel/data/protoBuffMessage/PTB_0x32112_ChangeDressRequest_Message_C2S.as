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
   
   public final class PTB_0x32112_ChangeDressRequest_Message_C2S extends Message implements IExternalizable
   {
       
      
      private var src_id$field:uint;
      
      private var dest_id$field:uint;
      
      private var hasField$0:uint = 0;
      
      public function PTB_0x32112_ChangeDressRequest_Message_C2S()
      {
         super();
      }
      
      public function get hasSrcId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function removeDestId() : void
      {
         hasField$0 &= 4294967293;
         dest_id$field = new uint();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSrcId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,src_id$field);
         }
         if(hasDestId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,dest_id$field);
         }
      }
      
      public function get hasDestId() : Boolean
      {
         return (hasField$0 & 2) != 0;
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
                     throw new IOError("Bad data format: PTB_0x32112_ChangeDressRequest_Message_C2S.srcId cannot be set twice.");
                  }
                  _loc3_++;
                  srcId = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x32112_ChangeDressRequest_Message_C2S.destId cannot be set twice.");
                  }
                  _loc4_++;
                  destId = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
                  break;
            }
         }
      }
      
      public function set destId(param1:uint) : void
      {
         hasField$0 |= 2;
         dest_id$field = param1;
      }
      
      public function removeSrcId() : void
      {
         hasField$0 &= 4294967294;
         src_id$field = new uint();
      }
      
      public function get destId() : uint
      {
         if(!hasDestId)
         {
            return 0;
         }
         return dest_id$field;
      }
      
      public function set srcId(param1:uint) : void
      {
         hasField$0 |= 1;
         src_id$field = param1;
      }
      
      public function get srcId() : uint
      {
         if(!hasSrcId)
         {
            return 0;
         }
         return src_id$field;
      }
   }
}
