package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataInput;
   
   public class SKT_0x0320A1_OnGetModelAwardPushPack_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 204961;
      
      public var itemID:uint;
      
      public var count:uint;
      
      public function SKT_0x0320A1_OnGetModelAwardPushPack_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         itemID = param1.readUnsignedInt();
         count = param1.readUnsignedShort();
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}

