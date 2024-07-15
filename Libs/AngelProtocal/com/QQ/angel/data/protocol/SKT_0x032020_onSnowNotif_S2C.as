package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataInput;
   
   public class SKT_0x032020_onSnowNotif_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 204832;
       
      
      public var gameState:uint;
      
      public var time:uint;
      
      public var count:uint;
      
      public function SKT_0x032020_onSnowNotif_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         gameState = param1.readUnsignedByte();
         count = param1.readUnsignedByte();
         time = param1.readUnsignedInt();
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
