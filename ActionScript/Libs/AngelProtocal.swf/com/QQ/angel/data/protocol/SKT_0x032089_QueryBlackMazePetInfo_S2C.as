package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x032089_QueryBlackMazePetInfo_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 204937;
      
      public var petInfoLength:uint;
      
      public var petInfoArray:Array;
      
      public var retCode:P_ReturnCode;
      
      public function SKT_0x032089_QueryBlackMazePetInfo_S2C()
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
         petInfoLength = param1.readUnsignedShort();
         petInfoArray = new Array();
         petInfoArray.length = petInfoLength;
         var _loc2_:int = 0;
         while(_loc2_ < petInfoLength)
         {
            petInfoArray[_loc2_] = param1.readUnsignedInt();
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

