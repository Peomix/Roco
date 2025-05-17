package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x32099_QueryStatus_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x32099_QueryStatus_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 204953;
      
      public var waitTime:uint;
      
      public var isFirst:uint;
      
      public var isActiveDay:uint;
      
      public var status:uint;
      
      public var leftTime:uint;
      
      public var activeLeftTime:uint;
      
      public var timeStatus:uint;
      
      public function PTB_0x32099_QueryStatus_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x32099_QueryStatus_Message_S2C = PTB_0x32099_QueryStatus_Message_S2C(param1);
         status = _loc2_.status;
         leftTime = _loc2_.leftTime;
         isFirst = _loc2_.isFirst;
         isActiveDay = _loc2_.isActiveDay;
         waitTime = _loc2_.waitTime;
         timeStatus = _loc2_.timeStatus;
         activeLeftTime = _loc2_.activeLeftTime;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x32099_QueryStatus_Message_S2C();
      }
   }
}

