package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_C2S_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataOutput;
   
   public class SKT_0x032040_ApplyCliffEggReward_C2S extends ProtocolBase implements I_C2S_Socket
   {
      
      public static const PROTOCOL_ID:int = 204864;
      
      public var eggType:uint;
      
      public function SKT_0x032040_ApplyCliffEggReward_C2S()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeByte(eggType);
         return true;
      }
   }
}

