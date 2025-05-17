package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032271_OnStatus_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032271_OnStatus_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205425;
      
      public var gift:uint;
      
      public var times:int;
      
      public function PTB_0x032271_OnStatus_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032271_OnStatus_Message_S2C = PTB_0x032271_OnStatus_Message_S2C(param1);
         times = _loc2_.times;
         gift = _loc2_.gift;
         return true;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032271_OnStatus_Message_S2C();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}

