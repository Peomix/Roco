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
   
   public final class PTB_0x03221A_ApplySubmitRewards_Message_S2C extends Message implements IExternalizable
   {
      
      private var ret_code$field:ReturnCode_Message;
      
      private var reward$field:ItemInfoChanged32_Message;
      
      public function PTB_0x03221A_ApplySubmitRewards_Message_S2C()
      {
         super();
      }
      
      public function get hasReward() : Boolean
      {
         return reward$field != null;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get reward() : ItemInfoChanged32_Message
      {
         return reward$field;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function removeReward() : void
      {
         reward$field = null;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasReward)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,reward$field);
         }
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function set reward(param1:ItemInfoChanged32_Message) : void
      {
         reward$field = param1;
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
                     throw new IOError("Bad data format: PTB_0x03221A_ApplySubmitRewards_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x03221A_ApplySubmitRewards_Message_S2C.reward cannot be set twice.");
                  }
                  _loc4_++;
                  reward = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,reward);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
                  break;
            }
         }
      }
   }
}

