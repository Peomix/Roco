package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032091_FansFightQueryPKState_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032091_FansFightQueryPKState_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 204945;
       
      
      public var star:uint;
      
      public var scoreDuck:uint;
      
      public var retCode:P_ReturnCode;
      
      public var scoreDimo:uint;
      
      public var gotReward:uint;
      
      public function PTB_0x032091_FansFightQueryPKState_S2C()
      {
         super();
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032091_FansFightQueryPKState_Message_S2C();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032091_FansFightQueryPKState_Message_S2C = PTB_0x032091_FansFightQueryPKState_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         star = _loc2_.star;
         scoreDuck = _loc2_.scoreDuck;
         scoreDimo = _loc2_.scoreDimo;
         gotReward = _loc2_.gotReward;
         return true;
      }
   }
}
