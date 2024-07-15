package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032129_OnPhonePush_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032129_OnPhonePush_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205097;
       
      
      public var send:uint;
      
      public var name:String;
      
      public var uin:uint;
      
      public function PTB_0x032129_OnPhonePush_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032129_OnPhonePush_Message_S2C = PTB_0x032129_OnPhonePush_Message_S2C(param1);
         uin = _loc2_.uin;
         send = _loc2_.send;
         name = _loc2_.name;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032129_OnPhonePush_Message_S2C();
      }
   }
}
