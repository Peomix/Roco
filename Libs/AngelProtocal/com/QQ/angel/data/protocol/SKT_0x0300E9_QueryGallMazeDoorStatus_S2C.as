package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x0300E9_QueryGallMazeDoorStatus_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 196841;
       
      
      public var sceneId:uint;
      
      public var hp:uint;
      
      public var time:uint;
      
      public var status:uint;
      
      public var retCode:P_ReturnCode;
      
      public function SKT_0x0300E9_QueryGallMazeDoorStatus_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         retCode = ProtocolHelper.ReadCode(param1);
         if(retCode.code < 0)
         {
            return false;
         }
         status = param1.readUnsignedByte();
         sceneId = param1.readUnsignedShort();
         hp = param1.readUnsignedInt();
         time = param1.readUnsignedInt();
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
