package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032011_ZoneWolfNotifyGameState_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032011_ZoneWolfNotifyGameState_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 204817;
      
      public var npcHp:Array;
      
      public var actId:Array;
      
      public var round:uint;
      
      public var npcId:Array;
      
      public var gameId:uint;
      
      public var passiveCount:Array;
      
      public var timeLeft:uint;
      
      public var damage:Array;
      
      public var npcType:Array;
      
      public var winner:uint;
      
      public function PTB_0x032011_ZoneWolfNotifyGameState_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032011_ZoneWolfNotifyGameState_Message_S2C();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032011_ZoneWolfNotifyGameState_Message_S2C = PTB_0x032011_ZoneWolfNotifyGameState_Message_S2C(param1);
         gameId = _loc2_.gameId;
         round = _loc2_.round;
         winner = _loc2_.winner;
         npcId = _loc2_.npcId;
         npcType = _loc2_.npcType;
         npcHp = _loc2_.npcHp;
         actId = _loc2_.actId;
         passiveCount = _loc2_.passiveCount;
         damage = _loc2_.damage;
         timeLeft = _loc2_.timeLeft;
         return true;
      }
   }
}

