package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x0300A3_OnCourageNpcRefreshNotify_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x0300A3_OnCourageNpcRefreshNotify_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 196771;
      
      public var trueNpcId:uint;
      
      public var falseNpcId:uint;
      
      public var verseIndex:uint;
      
      public function PTB_0x0300A3_OnCourageNpcRefreshNotify_S2C()
      {
         super();
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x0300A3_OnCourageNpcRefreshNotify_Message_S2C();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x0300A3_OnCourageNpcRefreshNotify_Message_S2C = PTB_0x0300A3_OnCourageNpcRefreshNotify_Message_S2C(param1);
         trueNpcId = _loc2_.trueNpcId;
         falseNpcId = _loc2_.falseNpcId;
         verseIndex = _loc2_.verseIndex;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}

