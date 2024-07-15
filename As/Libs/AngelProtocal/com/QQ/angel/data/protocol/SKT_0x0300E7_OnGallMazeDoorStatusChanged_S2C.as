package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataInput;
   
   public class SKT_0x0300E7_OnGallMazeDoorStatusChanged_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 196839;
       
      
      public var sceneId:uint;
      
      public var hp:uint;
      
      public var time:uint;
      
      public var status:uint;
      
      public function SKT_0x0300E7_OnGallMazeDoorStatusChanged_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         status = param1.readUnsignedByte();
         sceneId = param1.readUnsignedShort();
         hp = param1.readUnsignedInt();
         time = param1.readUnsignedInt();
         return true;
      }
   }
}
