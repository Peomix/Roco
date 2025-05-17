package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x030085_QueryServerTime_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 196741;
      
      public var month:uint;
      
      public var seconds:uint;
      
      public var stamp:uint;
      
      public var day:uint;
      
      public var fullYear:uint;
      
      public var date:uint;
      
      public var hours:uint;
      
      public var retCode:P_ReturnCode;
      
      public var dayOfYear:uint;
      
      public var minutes:uint;
      
      public function SKT_0x030085_QueryServerTime_S2C()
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
         fullYear = param1.readUnsignedInt();
         month = param1.readUnsignedInt();
         date = param1.readUnsignedInt();
         hours = param1.readUnsignedInt();
         minutes = param1.readUnsignedInt();
         seconds = param1.readUnsignedInt();
         day = param1.readUnsignedInt();
         dayOfYear = param1.readUnsignedInt();
         stamp = param1.readUnsignedInt();
         return true;
      }
   }
}

