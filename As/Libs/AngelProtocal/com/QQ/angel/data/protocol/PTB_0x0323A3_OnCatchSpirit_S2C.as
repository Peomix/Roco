package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x0323A3_OnCatchSpirit_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged32;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x0323A3_OnCatchSpirit_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205731;
       
      
      public var missionId:uint;
      
      public var rewardArray:Array;
      
      public var maxPlayCount:uint;
      
      public var playCount:uint;
      
      public var missionStatus:uint;
      
      public function PTB_0x0323A3_OnCatchSpirit_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x0323A3_OnCatchSpirit_Message_S2C = PTB_0x0323A3_OnCatchSpirit_Message_S2C(param1);
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
         playCount = _loc2_.playCount;
         maxPlayCount = _loc2_.maxPlayCount;
         missionId = _loc2_.missionId;
         missionStatus = _loc2_.missionStatus;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x0323A3_OnCatchSpirit_Message_S2C();
      }
   }
}
