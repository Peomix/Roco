package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032156_OnGameStart_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032156_OnGameStart_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205142;
       
      
      public var sceneId:uint;
      
      public function PTB_0x032156_OnGameStart_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032156_OnGameStart_Message_S2C = PTB_0x032156_OnGameStart_Message_S2C(param1);
         sceneId = _loc2_.sceneId;
         return true;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032156_OnGameStart_Message_S2C();
      }
   }
}
