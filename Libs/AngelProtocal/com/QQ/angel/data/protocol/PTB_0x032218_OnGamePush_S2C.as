package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032218_OnGamePush_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032218_OnGamePush_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205336;
       
      
      public var npcHP0:uint;
      
      public var npcHP1:uint;
      
      public var chestLeftTime:uint;
      
      public var npcExist:uint;
      
      public function PTB_0x032218_OnGamePush_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032218_OnGamePush_Message_S2C = PTB_0x032218_OnGamePush_Message_S2C(param1);
         npcExist = _loc2_.npcExist;
         npcHP0 = _loc2_.npcHP0;
         npcHP1 = _loc2_.npcHP1;
         chestLeftTime = _loc2_.chestLeftTime;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032218_OnGamePush_Message_S2C();
      }
   }
}
