package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SKT_0x032037_OnCliffEggChange_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 204855;
       
      
      public var eggStatus:ByteArray;
      
      public function SKT_0x032037_OnCliffEggChange_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         eggStatus = new ByteArray();
         eggStatus.position = 0;
         param1.readBytes(eggStatus,0,11);
         eggStatus.length = 11;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
