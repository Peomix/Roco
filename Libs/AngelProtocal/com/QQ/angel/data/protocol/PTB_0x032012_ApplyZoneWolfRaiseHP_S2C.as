package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032012_ApplyZoneWolfRaiseHP_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032012_ApplyZoneWolfRaiseHP_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 204818;
       
      
      public var npcId:Array;
      
      public var propCount:uint;
      
      public var gameId:uint;
      
      public var retCode:P_ReturnCode;
      
      public var npcHp:Array;
      
      public var round:uint;
      
      public var npcType:Array;
      
      public var winner:uint;
      
      public function PTB_0x032012_ApplyZoneWolfRaiseHP_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032012_ApplyZoneWolfRaiseHP_Message_S2C = PTB_0x032012_ApplyZoneWolfRaiseHP_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         gameId = _loc2_.gameId;
         round = _loc2_.round;
         winner = _loc2_.winner;
         npcId = _loc2_.npcId;
         npcType = _loc2_.npcType;
         npcHp = _loc2_.npcHp;
         propCount = _loc2_.propCount;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032012_ApplyZoneWolfRaiseHP_Message_S2C();
      }
   }
}
