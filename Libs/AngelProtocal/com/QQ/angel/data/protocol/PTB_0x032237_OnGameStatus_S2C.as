package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032237_OnGameStatus_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032237_OnGameStatus_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205367;
       
      
      public var currentHp:uint;
      
      public var totalHp:uint;
      
      public var eggCountDown:uint;
      
      public var status:uint;
      
      public var light:uint;
      
      public var giftNum:uint;
      
      public function PTB_0x032237_OnGameStatus_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032237_OnGameStatus_Message_S2C = PTB_0x032237_OnGameStatus_Message_S2C(param1);
         status = _loc2_.status;
         light = _loc2_.light;
         currentHp = _loc2_.currentHp;
         totalHp = _loc2_.totalHp;
         giftNum = _loc2_.giftNum;
         eggCountDown = _loc2_.eggCountDown;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032237_OnGameStatus_Message_S2C();
      }
   }
}
