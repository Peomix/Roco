package com.QQ.angel.data.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataInput;
   
   public class SKT_0x0B0070_OnVirtualItemChanged_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 721008;
       
      
      public var vItemId:uint;
      
      public var vItemCount:int;
      
      public var info:String;
      
      public function SKT_0x0B0070_OnVirtualItemChanged_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         vItemId = param1.readUnsignedInt();
         vItemCount = param1.readInt();
         info = DEFINE.ReadString(param1);
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
