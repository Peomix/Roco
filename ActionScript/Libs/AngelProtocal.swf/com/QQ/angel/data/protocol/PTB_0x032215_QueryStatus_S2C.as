package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032215_QueryStatus_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032215_QueryStatus_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205333;
      
      public var timeActive:uint;
      
      public var skillId:uint;
      
      public function PTB_0x032215_QueryStatus_S2C()
      {
         super();
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032215_QueryStatus_Message_S2C();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032215_QueryStatus_Message_S2C = PTB_0x032215_QueryStatus_Message_S2C(param1);
         skillId = _loc2_.skillId;
         timeActive = _loc2_.timeActive;
         return true;
      }
   }
}

