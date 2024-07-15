package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x032159_OnGameStatus_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged32;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x032159_OnGameStatus_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205145;
       
      
      public var bossHp:uint;
      
      public var itemArray:Array;
      
      public function PTB_0x032159_OnGameStatus_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x032159_OnGameStatus_Message_S2C = PTB_0x032159_OnGameStatus_Message_S2C(param1);
         bossHp = _loc2_.bossHp;
         if(!itemArray)
         {
            itemArray = new Array(9);
         }
         itemArray.length = 9;
         var _loc3_:Array = _loc2_.itemArray as Array;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            itemArray[_loc4_] = new ItemInfoChanged32();
            itemArray[_loc4_].readProtoBuf(_loc3_[_loc4_] as Message);
            _loc4_++;
         }
         return true;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x032159_OnGameStatus_Message_S2C();
      }
   }
}
