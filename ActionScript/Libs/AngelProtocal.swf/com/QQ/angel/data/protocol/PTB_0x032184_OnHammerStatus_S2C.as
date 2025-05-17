package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032184_OnHammerStatus_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032184_OnHammerStatus_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205188;
      
      public var isFire:int;
      
      public var giftNumber:int;
      
      public var hammerCountDown:int;
      
      public var type:int;
      
      public var gameCountDown:int;
      
      public function PTB_0x032184_OnHammerStatus_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032184_OnHammerStatus_Message_S2C = PTB_0x032184_OnHammerStatus_Message_S2C(param1);
         isFire = _loc2_.isFire;
         type = _loc2_.type;
         giftNumber = _loc2_.giftNumber;
         gameCountDown = _loc2_.gameCountDown;
         hammerCountDown = _loc2_.hammerCountDown;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032184_OnHammerStatus_Message_S2C();
      }
   }
}

