package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SKT_0x032036_ApplyGetAEgg_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 204854;
       
      
      public var retCode:P_ReturnCode;
      
      public var eggStatus:ByteArray;
      
      public var eggType:uint;
      
      public function SKT_0x032036_ApplyGetAEgg_S2C()
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
         eggStatus = new ByteArray();
         eggStatus.position = 0;
         param1.readBytes(eggStatus,0,11);
         eggStatus.length = 11;
         eggType = param1.readUnsignedByte();
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
