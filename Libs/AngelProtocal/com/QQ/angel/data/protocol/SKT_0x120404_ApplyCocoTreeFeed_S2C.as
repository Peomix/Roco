package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x120404_ApplyCocoTreeFeed_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 1180676;
       
      
      public var level:uint;
      
      public var pickFruitFlag:uint;
      
      public var growthValue:uint;
      
      public var rewardLength:uint;
      
      public var retCode:P_ReturnCode;
      
      public var wateringFlag:uint;
      
      public var rewardArray:Array;
      
      public var timePast:uint;
      
      public function SKT_0x120404_ApplyCocoTreeFeed_S2C()
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
         growthValue = param1.readUnsignedShort();
         level = param1.readUnsignedShort();
         pickFruitFlag = param1.readUnsignedByte();
         wateringFlag = param1.readUnsignedByte();
         timePast = param1.readUnsignedInt();
         rewardLength = param1.readUnsignedShort();
         if(!rewardArray)
         {
            rewardArray = new Array(rewardLength);
         }
         rewardArray.length = rewardLength;
         var _loc2_:int = 0;
         while(_loc2_ < rewardLength)
         {
            rewardArray[_loc2_] = new ItemInfoChanged();
            rewardArray[_loc2_].readData(param1);
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
