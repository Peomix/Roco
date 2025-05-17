package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.Message;
   import com.tencent.protobuf.ReadUtils;
   import com.tencent.protobuf.WireType;
   import com.tencent.protobuf.WriteUtils;
   import com.tencent.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ReturnCodeGBK_Message extends Message implements IExternalizable
   {
      
      private var code$field:int;
      
      private var hasField$0:uint = 0;
      
      private var message$field:String;
      
      public function ReturnCodeGBK_Message()
      {
         super();
      }
      
      public function get hasCode() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set code(param1:int) : void
      {
         hasField$0 |= 1;
         code$field = param1;
      }
      
      public function get code() : int
      {
         if(!hasCode)
         {
            return 0;
         }
         return code$field;
      }
      
      public function set message(param1:String) : void
      {
         message$field = param1;
      }
      
      public function removeCode() : void
      {
         hasField$0 &= 4294967294;
         code$field = new int();
      }
      
      public function removeMessage() : void
      {
         message$field = null;
      }
      
      public function get hasMessage() : Boolean
      {
         return message$field != null;
      }
      
      public function get message() : String
      {
         if(!hasMessage)
         {
            return "";
         }
         return message$field;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:ByteArray = null;
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
                     throw new IOError("Bad data format: ReturnCodeGBK_Message.code cannot be set twice.");
                  }
                  _loc3_++;
                  code = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ReturnCodeGBK_Message.message cannot be set twice.");
                  }
                  _loc4_++;
                  _loc6_ = ReadUtils.read$TYPE_BYTES(param1);
                  message = _loc6_.readMultiByte(_loc6_.length,"gb2312");
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
                  break;
            }
         }
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCode)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_INT32(param1,code$field);
         }
         if(hasMessage)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_STRING(param1,message$field);
         }
      }
   }
}

