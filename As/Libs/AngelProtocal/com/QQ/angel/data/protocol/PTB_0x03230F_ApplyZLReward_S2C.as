package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x03230F_ApplyZLReward_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged32;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x03230F_ApplyZLReward_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205583;
       
      
      public var rewardIndex:uint;
      
      public var rewardArray:Array;
      
      public var ticket:uint;
      
      public var retCode:P_ReturnCode;
      
      public var countDown:uint;
      
      public var status:uint;
      
      public var remain:uint;
      
      public function PTB_0x03230F_ApplyZLReward_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x03230F_ApplyZLReward_Message_S2C = PTB_0x03230F_ApplyZLReward_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         status = _loc2_.status;
         ticket = _loc2_.ticket;
         remain = _loc2_.remain;
         countDown = _loc2_.countDown;
         rewardIndex = _loc2_.rewardIndex;
         if(!rewardArray)
         {
            rewardArray = new Array(0);
         }
         rewardArray.length = 0;
         var _loc3_:Array = _loc2_.rewardArray as Array;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            rewardArray[_loc4_] = new ItemInfoChanged32();
            rewardArray[_loc4_].readProtoBuf(_loc3_[_loc4_] as Message);
            _loc4_++;
         }
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x03230F_ApplyZLReward_Message_S2C();
      }
   }
}
