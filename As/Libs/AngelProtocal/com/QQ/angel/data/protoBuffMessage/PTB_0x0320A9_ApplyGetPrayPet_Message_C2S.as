package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.Message;
   import com.tencent.protobuf.ReadUtils;
   import com.tencent.protobuf.WritingBuffer;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x0320A9_ApplyGetPrayPet_Message_C2S extends Message implements IExternalizable
   {
       
      
      public function PTB_0x0320A9_ApplyGetPrayPet_Message_C2S()
      {
         super();
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            var _loc4_:* = _loc3_ >>> 3;
            switch(0)
            {
            }
            ReadUtils.skip(param1,_loc3_ & 7);
         }
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
      }
   }
}
