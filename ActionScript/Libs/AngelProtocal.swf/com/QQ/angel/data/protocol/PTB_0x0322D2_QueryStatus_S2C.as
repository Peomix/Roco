package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x0322D2_QueryStatus_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x0322D2_QueryStatus_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 205522;
      
      public var evilHp:Array;
      
      public var hp:int;
      
      public var state:uint;
      
      public var countDown:uint;
      
      public var itemNum0:uint;
      
      public var itemNum1:uint;
      
      public var evilState:Array;
      
      public var boxType:int;
      
      public var isFirst:uint;
      
      public var retCode:P_ReturnCode;
      
      public var roundSucc:uint;
      
      public var week:uint;
      
      public var evilType:int;
      
      public function PTB_0x0322D2_QueryStatus_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x0322D2_QueryStatus_Message_S2C();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x0322D2_QueryStatus_Message_S2C = PTB_0x0322D2_QueryStatus_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         state = _loc2_.state;
         countDown = _loc2_.countDown;
         hp = _loc2_.hp;
         evilState = _loc2_.evilState;
         evilHp = _loc2_.evilHp;
         evilType = _loc2_.evilType;
         boxType = _loc2_.boxType;
         roundSucc = _loc2_.roundSucc;
         isFirst = _loc2_.isFirst;
         itemNum0 = _loc2_.itemNum0;
         itemNum1 = _loc2_.itemNum1;
         week = _loc2_.week;
         return true;
      }
   }
}

