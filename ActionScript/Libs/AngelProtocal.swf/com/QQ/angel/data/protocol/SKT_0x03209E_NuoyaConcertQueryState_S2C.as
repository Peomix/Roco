package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x03209E_NuoyaConcertQueryState_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 204958;
      
      public var maxTimes:uint;
      
      public var times:uint;
      
      public var retCode:P_ReturnCode;
      
      public var aState:uint;
      
      public function SKT_0x03209E_NuoyaConcertQueryState_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         retCode = ProtocolHelper.ReadCode(param1);
         if(retCode.code < 0)
         {
            return false;
         }
         aState = param1.readUnsignedByte();
         times = param1.readUnsignedByte();
         maxTimes = param1.readUnsignedByte();
         return true;
      }
   }
}

