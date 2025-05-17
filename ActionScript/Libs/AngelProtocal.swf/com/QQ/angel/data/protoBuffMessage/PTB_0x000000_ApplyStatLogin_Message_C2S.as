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
   
   public final class PTB_0x000000_ApplyStatLogin_Message_C2S extends Message implements IExternalizable
   {
      
      private var key$field:String;
      
      public function PTB_0x000000_ApplyStatLogin_Message_C2S()
      {
         super();
      }
      
      public function get hasKey() : Boolean
      {
         return key$field != null;
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
                     throw new IOError("Bad data format: PTB_0x000000_ApplyStatLogin_Message_C2S.key cannot be set twice.");
                  }
                  _loc3_++;
                  key = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
                  break;
            }
         }
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasKey)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_STRING(param1,key$field);
         }
      }
      
      public function removeKey() : void
      {
         key$field = null;
      }
      
      public function set key(param1:String) : void
      {
         key$field = param1;
      }
      
      public function get key() : String
      {
         if(!hasKey)
         {
            return "";
         }
         return key$field;
      }
   }
}

