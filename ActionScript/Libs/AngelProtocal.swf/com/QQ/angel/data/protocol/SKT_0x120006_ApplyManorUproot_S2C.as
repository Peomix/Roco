package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ManorGroundInfo;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x120006_ApplyManorUproot_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 1179654;
      
      public var groundInfo:ManorGroundInfo;
      
      public var retCode:P_ReturnCode;
      
      public function SKT_0x120006_ApplyManorUproot_S2C()
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
         groundInfo = new ManorGroundInfo();
         groundInfo.readData(param1);
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}

