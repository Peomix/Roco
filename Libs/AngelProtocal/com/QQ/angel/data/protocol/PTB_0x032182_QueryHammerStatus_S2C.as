package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032182_QueryHammerStatus_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032182_QueryHammerStatus_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205186;
       
      
      public var money:int;
      
      public var box0:int;
      
      public var box1:int;
      
      public var box2:int;
      
      public var hammerCountDown:int;
      
      public var retCode:P_ReturnCode;
      
      public var giftNumber:int;
      
      public var cardNumber:int;
      
      public var type:int;
      
      public var gameCountDown:int;
      
      public function PTB_0x032182_QueryHammerStatus_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032182_QueryHammerStatus_Message_S2C();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032182_QueryHammerStatus_Message_S2C = PTB_0x032182_QueryHammerStatus_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         gameCountDown = _loc2_.gameCountDown;
         hammerCountDown = _loc2_.hammerCountDown;
         type = _loc2_.type;
         giftNumber = _loc2_.giftNumber;
         cardNumber = _loc2_.cardNumber;
         box0 = _loc2_.box0;
         box1 = _loc2_.box1;
         box2 = _loc2_.box2;
         money = _loc2_.money;
         return true;
      }
   }
}
