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
   
   public final class PTB_0x0323A4_ApplyExchangeSpirit_Message_S2C extends Message implements IExternalizable
   {
      
      private var ret_code$field:ReturnCodeGBK_Message;
      
      private var hasField$0:uint = 0;
      
      private var has_item_count$field:uint;
      
      public function PTB_0x0323A4_ApplyExchangeSpirit_Message_S2C()
      {
         super();
      }
      
      public function set retCode(param1:ReturnCodeGBK_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function set hasItemCount(param1:uint) : void
      {
         hasField$0 |= 1;
         has_item_count$field = param1;
      }
      
      public function removeHasItemCount() : void
      {
         hasField$0 &= 4294967294;
         has_item_count$field = new uint();
      }
      
      public function get hasItemCount() : uint
      {
         if(!hasHasItemCount)
         {
            return 0;
         }
         return has_item_count$field;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get hasHasItemCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get retCode() : ReturnCodeGBK_Message
      {
         return ret_code$field;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
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
                     throw new IOError("Bad data format: PTB_0x0323A4_ApplyExchangeSpirit_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCodeGBK_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0323A4_ApplyExchangeSpirit_Message_S2C.hasItemCount cannot be set twice.");
                  }
                  _loc4_++;
                  hasItemCount = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
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
         if(hasHasItemCount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,has_item_count$field);
         }
      }
   }
}

