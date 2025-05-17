package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x03206F_SubmitReward_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged32;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x03206F_SubmitReward_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 204911;
      
      public var cd:uint;
      
      public var rewards:Array;
      
      public var alreadyPlay:uint;
      
      public var retCode:P_ReturnCode;
      
      public var done:uint;
      
      public var status:uint;
      
      public var scene:uint;
      
      public var stage:uint;
      
      public function PTB_0x03206F_SubmitReward_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x03206F_SubmitReward_Message_S2C = PTB_0x03206F_SubmitReward_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         stage = _loc2_.stage;
         status = _loc2_.status;
         scene = _loc2_.scene;
         alreadyPlay = _loc2_.alreadyPlay;
         cd = _loc2_.cd;
         done = _loc2_.done;
         if(!rewards)
         {
            rewards = new Array(0);
         }
         rewards.length = 0;
         var _loc3_:Array = _loc2_.rewards as Array;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            rewards[_loc4_] = new ItemInfoChanged32();
            rewards[_loc4_].readProtoBuf(_loc3_[_loc4_] as Message);
            _loc4_++;
         }
         return true;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x03206F_SubmitReward_Message_S2C();
      }
   }
}

