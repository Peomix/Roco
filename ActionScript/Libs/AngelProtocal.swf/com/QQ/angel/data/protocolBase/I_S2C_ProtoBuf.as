package com.QQ.angel.data.protocolBase
{
   import com.tencent.protobuf.Message;
   
   public interface I_S2C_ProtoBuf
   {
      
      function readProtoBuf(param1:Message) : Boolean;
      
      function getS2CMessage() : Message;
   }
}

