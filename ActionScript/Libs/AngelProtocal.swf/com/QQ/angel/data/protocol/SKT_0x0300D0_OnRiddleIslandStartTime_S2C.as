package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataInput;
   
   public class SKT_0x0300D0_OnRiddleIslandStartTime_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 196816;
      
      public var time:int;
      
      public function SKT_0x0300D0_OnRiddleIslandStartTime_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         time = param1.readShort();
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}

