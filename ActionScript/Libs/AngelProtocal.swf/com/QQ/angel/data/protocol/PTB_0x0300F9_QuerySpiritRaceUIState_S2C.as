package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x0300F9_QuerySpiritRaceUIState_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x0300F9_QuerySpiritRaceUIState_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 196857;
      
      public var mySupport:uint;
      
      public var time:uint;
      
      public var retCode:P_ReturnCode;
      
      public var state:uint;
      
      public var score:uint;
      
      public var allSupport:Array;
      
      public var id:uint;
      
      public function PTB_0x0300F9_QuerySpiritRaceUIState_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x0300F9_QuerySpiritRaceUIState_Message_S2C = PTB_0x0300F9_QuerySpiritRaceUIState_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         id = _loc2_.id;
         state = _loc2_.state;
         mySupport = _loc2_.mySupport;
         score = _loc2_.score;
         time = _loc2_.time;
         allSupport = _loc2_.allSupport;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x0300F9_QuerySpiritRaceUIState_Message_S2C();
      }
   }
}

