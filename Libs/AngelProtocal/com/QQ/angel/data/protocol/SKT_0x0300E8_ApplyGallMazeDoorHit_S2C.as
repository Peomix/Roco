package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataInput;
   
   public class SKT_0x0300E8_ApplyGallMazeDoorHit_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 196840;
       
      
      public function SKT_0x0300E8_ApplyGallMazeDoorHit_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
