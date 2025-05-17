package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x0322CB_QueryStatus_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x0322CB_QueryStatus_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205515;
      
      public var playRemain:uint;
      
      public var bossFullHp:uint;
      
      public var needWarSoulCount:uint;
      
      public var retCode:P_ReturnCode;
      
      public var warSoulCount:uint;
      
      public var hurtHp:uint;
      
      public var bossTime:uint;
      
      public var bossLeftHp:uint;
      
      public var bossStatus:uint;
      
      public function PTB_0x0322CB_QueryStatus_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x0322CB_QueryStatus_Message_S2C = PTB_0x0322CB_QueryStatus_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         warSoulCount = _loc2_.warSoulCount;
         needWarSoulCount = _loc2_.needWarSoulCount;
         playRemain = _loc2_.playRemain;
         bossLeftHp = _loc2_.bossLeftHp;
         bossFullHp = _loc2_.bossFullHp;
         bossStatus = _loc2_.bossStatus;
         bossTime = _loc2_.bossTime;
         hurtHp = _loc2_.hurtHp;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x0322CB_QueryStatus_Message_S2C();
      }
   }
}

