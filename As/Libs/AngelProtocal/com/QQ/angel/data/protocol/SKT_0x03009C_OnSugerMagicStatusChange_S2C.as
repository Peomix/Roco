package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataInput;
   
   public class SKT_0x03009C_OnSugerMagicStatusChange_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 196764;
       
      
      public var hitSoftConePlayerNum:uint;
      
      public var sceneId:uint;
      
      public var hitDoughnutPlayerNum:uint;
      
      public var status:uint;
      
      public var hitCakePlayerNum:uint;
      
      public function SKT_0x03009C_OnSugerMagicStatusChange_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         sceneId = param1.readUnsignedShort();
         status = param1.readUnsignedByte();
         hitDoughnutPlayerNum = param1.readUnsignedByte();
         hitSoftConePlayerNum = param1.readUnsignedByte();
         hitCakePlayerNum = param1.readUnsignedByte();
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
