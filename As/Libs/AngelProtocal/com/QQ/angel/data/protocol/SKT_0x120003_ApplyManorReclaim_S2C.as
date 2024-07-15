package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x120003_ApplyManorReclaim_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 1179651;
       
      
      public var groundId:uint;
      
      public var rewardInfoLength:uint;
      
      public var result:uint;
      
      public var retCode:P_ReturnCode;
      
      public var rewardInfoArray:Array;
      
      public var exp:uint;
      
      public function SKT_0x120003_ApplyManorReclaim_S2C()
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
         groundId = param1.readUnsignedByte();
         result = param1.readUnsignedShort();
         exp = param1.readUnsignedShort();
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
