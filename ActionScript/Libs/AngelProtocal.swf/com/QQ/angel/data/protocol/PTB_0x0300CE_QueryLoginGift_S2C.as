package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protoBuffMessage.PTB_0x0300CE_QueryLoginGift_Message_S2C;
   import com.QQ.angel.data.protocolBase.I_S2C_ProtoBuf;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged32;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.tencent.protobuf.Message;
   
   public class PTB_0x0300CE_QueryLoginGift_S2C extends ProtocolBase implements I_S2C_ProtoBuf
   {
      
      public static const PROTOCOL_ID:int = 196814;
      
      public var index0:uint;
      
      public var index1:uint;
      
      public var hasExtraGift:uint;
      
      public var index2:uint;
      
      public var itemArray0:Array;
      
      public var itemArray1:Array;
      
      public var itemArray2:Array;
      
      public var isShowDailyUI:uint;
      
      public var retCode:P_ReturnCode;
      
      public var money0:uint;
      
      public var money1:uint;
      
      public var money2:uint;
      
      public function PTB_0x0300CE_QueryLoginGift_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function getS2CMessage() : Message
      {
         return new PTB_0x0300CE_QueryLoginGift_Message_S2C();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:PTB_0x0300CE_QueryLoginGift_Message_S2C = PTB_0x0300CE_QueryLoginGift_Message_S2C(param1);
         retCode = new P_ReturnCode();
         retCode.code = _loc2_.retCode.code;
         retCode.message = _loc2_.retCode.message;
         if(retCode.code < 0)
         {
            return false;
         }
         index0 = _loc2_.index0;
         money0 = _loc2_.money0;
         if(!itemArray0)
         {
            itemArray0 = new Array(3);
         }
         itemArray0.length = 3;
         var _loc3_:Array = _loc2_.itemArray0 as Array;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            itemArray0[_loc4_] = new ItemInfoChanged32();
            itemArray0[_loc4_].readProtoBuf(_loc3_[_loc4_] as Message);
            _loc4_++;
         }
         index1 = _loc2_.index1;
         money1 = _loc2_.money1;
         if(!itemArray1)
         {
            itemArray1 = new Array(3);
         }
         itemArray1.length = 3;
         var _loc5_:Array = _loc2_.itemArray1 as Array;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            itemArray1[_loc6_] = new ItemInfoChanged32();
            itemArray1[_loc6_].readProtoBuf(_loc5_[_loc6_] as Message);
            _loc6_++;
         }
         index2 = _loc2_.index2;
         money2 = _loc2_.money2;
         if(!itemArray2)
         {
            itemArray2 = new Array(3);
         }
         itemArray2.length = 3;
         var _loc7_:Array = _loc2_.itemArray2 as Array;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_.length)
         {
            itemArray2[_loc8_] = new ItemInfoChanged32();
            itemArray2[_loc8_].readProtoBuf(_loc7_[_loc8_] as Message);
            _loc8_++;
         }
         hasExtraGift = _loc2_.hasExtraGift;
         isShowDailyUI = _loc2_.isShowDailyUI;
         return true;
      }
   }
}

