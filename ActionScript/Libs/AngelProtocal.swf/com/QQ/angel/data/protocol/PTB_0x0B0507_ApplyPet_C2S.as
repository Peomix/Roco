package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x0B0507_ApplyPet_Message_C2S;
   import com.QQ.angel.data.protocolBase.I_C2S_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x0B0507_ApplyPet_C2S extends ProtocolBase implements I_C2S_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 722183;
      
      public var vip:uint;
      
      public function PTB_0x0B0507_ApplyPet_C2S()
      {
         super();
      }
      
      public function writeProtoBuf() : Message
      {
         var _loc1_:PTB_0x0B0507_ApplyPet_Message_C2S = new PTB_0x0B0507_ApplyPet_Message_C2S();
         _loc1_.vip = vip;
         return _loc1_;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}

