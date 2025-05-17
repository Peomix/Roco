package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032230_QueryDiceStatus_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032230_QueryDiceStatus_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205360;
      
      public var grid:uint;
      
      public var petNum:uint;
      
      public var retCode:P_ReturnCode;
      
      public var vipRemain:uint;
      
      public var scene:uint;
      
      public var timeLeft:uint;
      
      public var petId:uint;
      
      public var diceNum:uint;
      
      public function PTB_0x032230_QueryDiceStatus_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032230_QueryDiceStatus_Message_S2C = PTB_0x032230_QueryDiceStatus_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         scene = _loc2_.scene;
         grid = _loc2_.grid;
         diceNum = _loc2_.diceNum;
         timeLeft = _loc2_.timeLeft;
         petId = _loc2_.petId;
         petNum = _loc2_.petNum;
         vipRemain = _loc2_.vipRemain;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032230_QueryDiceStatus_Message_S2C();
      }
   }
}

