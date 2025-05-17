package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032017_onQueryGameState_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032017_onQueryGameState_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 204823;
      
      public var posReward:Array;
      
      public var posUin:Array;
      
      public var retCode:P_ReturnCode;
      
      public var posAnswer:Array;
      
      public var gameID:uint;
      
      public var gameTime:uint;
      
      public var gameState:uint;
      
      public function PTB_0x032017_onQueryGameState_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032017_onQueryGameState_Message_S2C = PTB_0x032017_onQueryGameState_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         gameID = _loc2_.gameID;
         gameState = _loc2_.gameState;
         posAnswer = _loc2_.posAnswer;
         posReward = _loc2_.posReward;
         posUin = _loc2_.posUin;
         gameTime = _loc2_.gameTime;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032017_onQueryGameState_Message_S2C();
      }
   }
}

