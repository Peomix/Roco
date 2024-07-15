package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032131_QueryLotteryStatus_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032131_QueryLotteryStatus_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205105;
       
      
      public var rewardStatus:int;
      
      public var buyLottery:int;
      
      public var nextLotteryMday:int;
      
      public var buyButtonStatus:int;
      
      public var winLottery:int;
      
      public var retCode:P_ReturnCode;
      
      public var nextLotteryMon:int;
      
      public function PTB_0x032131_QueryLotteryStatus_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032131_QueryLotteryStatus_Message_S2C = PTB_0x032131_QueryLotteryStatus_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         nextLotteryMon = _loc2_.nextLotteryMon;
         nextLotteryMday = _loc2_.nextLotteryMday;
         rewardStatus = _loc2_.rewardStatus;
         buyButtonStatus = _loc2_.buyButtonStatus;
         buyLottery = _loc2_.buyLottery;
         winLottery = _loc2_.winLottery;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032131_QueryLotteryStatus_Message_S2C();
      }
   }
}
