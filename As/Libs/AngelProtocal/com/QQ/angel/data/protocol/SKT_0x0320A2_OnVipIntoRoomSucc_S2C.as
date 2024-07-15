package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x0320A2_OnVipIntoRoomSucc_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 204962;
       
      
      public var ret:P_ReturnCode;
      
      public var ispull:uint;
      
      public function SKT_0x0320A2_OnVipIntoRoomSucc_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         ret = ProtocolHelper.ReadCode(param1);
         if(ret.code < 0)
         {
            return false;
         }
         ispull = param1.readUnsignedByte();
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
