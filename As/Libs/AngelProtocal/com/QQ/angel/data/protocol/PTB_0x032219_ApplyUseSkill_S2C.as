package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032219_ApplyUseSkill_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032219_ApplyUseSkill_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205337;
       
      
      public var npcHP0:uint;
      
      public var npcHP1:uint;
      
      public var chestLeftTime:uint;
      
      public var npcExist:uint;
      
      public var retCode:P_ReturnCode;
      
      public function PTB_0x032219_ApplyUseSkill_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032219_ApplyUseSkill_Message_S2C = PTB_0x032219_ApplyUseSkill_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         npcExist = _loc2_.npcExist;
         npcHP0 = _loc2_.npcHP0;
         npcHP1 = _loc2_.npcHP1;
         chestLeftTime = _loc2_.chestLeftTime;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032219_ApplyUseSkill_Message_S2C();
      }
   }
}
