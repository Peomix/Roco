package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_C2S_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataOutput;
   
   public class SKT_0x032036_ApplyGetAEgg_C2S extends ProtocolBase implements I_C2S_Socket
   {
      
      public static const PROTOCOL_ID:int = 204854;
       
      
      public var eggId:uint;
      
      public function SKT_0x032036_ApplyGetAEgg_C2S()
      {
         super();
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeByte(eggId);
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
