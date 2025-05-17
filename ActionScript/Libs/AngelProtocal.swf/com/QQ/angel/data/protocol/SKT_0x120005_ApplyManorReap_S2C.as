package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged;
   import com.QQ.angel.data.struct.ManorGroundInfo;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x120005_ApplyManorReap_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 1179653;
      
      public var result:uint;
      
      public var rewardInfoLength:uint;
      
      public var friutNum:uint;
      
      public var rewardInfoArray:Array;
      
      public var eventId:uint;
      
      public var retCode:P_ReturnCode;
      
      public var seedUin:uint;
      
      public var groundInfo:ManorGroundInfo;
      
      public var qqUin:uint;
      
      public var exp:uint;
      
      public function SKT_0x120005_ApplyManorReap_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         retCode = ProtocolHelper.ReadCode(param1);
         if(retCode.code < 0)
         {
            return false;
         }
         qqUin = param1.readUnsignedInt();
         seedUin = param1.readUnsignedInt();
         result = param1.readUnsignedShort();
         exp = param1.readUnsignedShort();
         friutNum = param1.readUnsignedByte();
         groundInfo = new ManorGroundInfo();
         groundInfo.readData(param1);
         eventId = param1.readUnsignedByte();
         rewardInfoLength = param1.readUnsignedShort();
         if(!rewardInfoArray)
         {
            rewardInfoArray = new Array(rewardInfoLength);
         }
         rewardInfoArray.length = rewardInfoLength;
         var _loc2_:int = 0;
         while(_loc2_ < rewardInfoLength)
         {
            rewardInfoArray[_loc2_] = new ItemInfoChanged();
            rewardInfoArray[_loc2_].readData(param1);
            _loc2_++;
         }
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}

