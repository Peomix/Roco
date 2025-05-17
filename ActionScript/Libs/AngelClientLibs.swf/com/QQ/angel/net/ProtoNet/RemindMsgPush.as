package com.QQ.angel.net.ProtoNet
{
   import com.tencent.protobuf.Message;
   import com.tencent.protobuf.ReadUtils;
   import com.tencent.protobuf.WireType;
   import com.tencent.protobuf.WriteUtils;
   import com.tencent.protobuf.WritingBuffer;
   import com.tencent.protobuf.stringToByteArray;
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RemindMsgPush extends Message implements IExternalizable
   {
      
      private var remind_msg$field:ByteArray;
      
      public function RemindMsgPush()
      {
         super();
      }
      
      public function removeRemindMsg() : void
      {
         this.remind_msg$field = null;
      }
      
      public function get hasRemindMsg() : Boolean
      {
         return this.remind_msg$field != null;
      }
      
      public function set remindMsg(param1:ByteArray) : void
      {
         this.remind_msg$field = param1;
      }
      
      public function get remindMsg() : ByteArray
      {
         if(!this.hasRemindMsg)
         {
            return stringToByteArray("");
         }
         return this.remind_msg$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(this.hasRemindMsg)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_BYTES(param1,this.remind_msg$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc4_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc4_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RemindMsgPush.remindMsg cannot be set twice.");
                  }
                  _loc3_++;
                  this.remindMsg = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
                  break;
            }
         }
      }
   }
}

