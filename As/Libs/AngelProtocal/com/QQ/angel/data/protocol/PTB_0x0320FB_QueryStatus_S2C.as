package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x0320FB_QueryStatus_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x0320FB_QueryStatus_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205051;
       
      
      public var nextTime:uint;
      
      public var eggHp:uint;
      
      public var retCode:P_ReturnCode;
      
      public var giftNum:uint;
      
      public function PTB_0x0320FB_QueryStatus_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x0320FB_QueryStatus_Message_S2C = PTB_0x0320FB_QueryStatus_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         eggHp = _loc2_.eggHp;
         giftNum = _loc2_.giftNum;
         nextTime = _loc2_.nextTime;
         return true;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x0320FB_QueryStatus_Message_S2C();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
