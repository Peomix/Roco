package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x03215A_ApplyReward_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged32;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x03215A_ApplyReward_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205146;
       
      
      public var itemArray:Array;
      
      public var rewardArray:Array;
      
      public var retCode:P_ReturnCode;
      
      public function PTB_0x03215A_ApplyReward_S2C()
      {
         super();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x03215A_ApplyReward_Message_S2C = PTB_0x03215A_ApplyReward_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
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
         if(!itemArray)
         {
            itemArray = new Array(9);
         }
         itemArray.length = 9;
         var _loc5_:Array = _loc2_.itemArray as Array;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            itemArray[_loc6_] = new ItemInfoChanged32();
            itemArray[_loc6_].readProtoBuf(_loc5_[_loc6_] as Message);
            _loc6_++;
         }
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x03215A_ApplyReward_Message_S2C();
      }
   }
}
