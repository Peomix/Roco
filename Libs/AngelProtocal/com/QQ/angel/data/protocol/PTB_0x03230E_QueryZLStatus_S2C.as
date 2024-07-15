package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x03230E_QueryZLStatus_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x03230E_QueryZLStatus_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205582;
       
      
      public var ticket:uint;
      
      public var retCode:P_ReturnCode;
      
      public var countDown:uint;
      
      public var status:uint;
      
      public var remain:uint;
      
      public function PTB_0x03230E_QueryZLStatus_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x03230E_QueryZLStatus_Message_S2C = PTB_0x03230E_QueryZLStatus_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         status = _loc2_.status;
         ticket = _loc2_.ticket;
         remain = _loc2_.remain;
         countDown = _loc2_.countDown;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x03230E_QueryZLStatus_Message_S2C();
      }
   }
}
