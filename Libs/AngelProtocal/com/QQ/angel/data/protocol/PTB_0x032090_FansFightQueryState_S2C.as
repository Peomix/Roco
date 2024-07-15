package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032090_FansFightQueryState_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032090_FansFightQueryState_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 204944;
       
      
      public var dayReward:uint;
      
      public var cartoon:uint;
      
      public var process:uint;
      
      public var star:uint;
      
      public var retCode:P_ReturnCode;
      
      public var dipan:Array;
      
      public function PTB_0x032090_FansFightQueryState_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032090_FansFightQueryState_Message_S2C = PTB_0x032090_FansFightQueryState_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         star = _loc2_.star;
         dayReward = _loc2_.dayReward;
         process = _loc2_.process;
         cartoon = _loc2_.cartoon;
         dipan = _loc2_.dipan;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032090_FansFightQueryState_Message_S2C();
      }
   }
}
