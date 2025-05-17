package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x03009D_QuerySugerMagicResult_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 196765;
      
      public var hitSoftConePlayerNum:uint;
      
      public var coneGiftLimit:uint;
      
      public var doughnutGiftLimit:uint;
      
      public var retCode:P_ReturnCode;
      
      public var hitDoughnutPlayerNum:uint;
      
      public var cakeGiftLimit:uint;
      
      public var hitCakePlayerNum:uint;
      
      public function SKT_0x03009D_QuerySugerMagicResult_S2C()
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
         hitDoughnutPlayerNum = param1.readUnsignedByte();
         hitSoftConePlayerNum = param1.readUnsignedByte();
         hitCakePlayerNum = param1.readUnsignedByte();
         doughnutGiftLimit = param1.readUnsignedByte();
         coneGiftLimit = param1.readUnsignedByte();
         cakeGiftLimit = param1.readUnsignedByte();
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}

