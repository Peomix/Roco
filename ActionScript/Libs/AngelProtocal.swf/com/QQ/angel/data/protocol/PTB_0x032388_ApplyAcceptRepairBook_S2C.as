package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032388_ApplyAcceptRepairBook_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032388_ApplyAcceptRepairBook_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205704;
      
      public var hasAccptedCatchSpirit:uint;
      
      public var catchSpiritId:uint;
      
      public var hasDeanTrust:uint;
      
      public var hasCatchSpirit:uint;
      
      public var hasKingTrust:uint;
      
      public var kingItemNum:uint;
      
      public var hasAccptedRepairBook:uint;
      
      public var deanItemNum:uint;
      
      public var hasGetSpirit:uint;
      
      public var retCode:P_ReturnCode;
      
      public function PTB_0x032388_ApplyAcceptRepairBook_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032388_ApplyAcceptRepairBook_Message_S2C = PTB_0x032388_ApplyAcceptRepairBook_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         hasGetSpirit = _loc2_.hasGetSpirit;
         catchSpiritId = _loc2_.catchSpiritId;
         hasCatchSpirit = _loc2_.hasCatchSpirit;
         hasAccptedCatchSpirit = _loc2_.hasAccptedCatchSpirit;
         hasAccptedRepairBook = _loc2_.hasAccptedRepairBook;
         hasKingTrust = _loc2_.hasKingTrust;
         hasDeanTrust = _loc2_.hasDeanTrust;
         deanItemNum = _loc2_.deanItemNum;
         kingItemNum = _loc2_.kingItemNum;
         return true;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032388_ApplyAcceptRepairBook_Message_S2C();
      }
   }
}

