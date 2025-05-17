package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x0320DE_QueryStatus_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x0320DE_QueryStatus_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205022;
      
      public var maxStage:uint;
      
      public var completeTimes:uint;
      
      public var retCode:P_ReturnCode;
      
      public var reward:Array;
      
      public var first:uint;
      
      public var curStage:uint;
      
      public function PTB_0x0320DE_QueryStatus_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x0320DE_QueryStatus_Message_S2C = PTB_0x0320DE_QueryStatus_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         reward = _loc2_.reward;
         maxStage = _loc2_.maxStage;
         curStage = _loc2_.curStage;
         completeTimes = _loc2_.completeTimes;
         first = _loc2_.first;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x0320DE_QueryStatus_Message_S2C();
      }
   }
}

