package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032314_CMD1_ApplyPutEgg_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032314_CMD1_ApplyPutEgg_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205588;
       
      
      public var cd:uint;
      
      public var egg:uint;
      
      public var statusVip:uint;
      
      public var retCode:P_ReturnCode;
      
      public var status:uint;
      
      public var cdVip:uint;
      
      public function PTB_0x032314_CMD1_ApplyPutEgg_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032314_CMD1_ApplyPutEgg_Message_S2C = PTB_0x032314_CMD1_ApplyPutEgg_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         status = _loc2_.status;
         statusVip = _loc2_.statusVip;
         cd = _loc2_.cd;
         cdVip = _loc2_.cdVip;
         egg = _loc2_.egg;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032314_CMD1_ApplyPutEgg_Message_S2C();
      }
   }
}
