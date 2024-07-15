package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x03000B_ApplyChangeAvatar_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 196619;
       
      
      public var avatarEffectID:uint;
      
      public var retCode:P_ReturnCode;
      
      public var avatarTransformID:uint;
      
      public var avatarVersion:uint;
      
      public function SKT_0x03000B_ApplyChangeAvatar_S2C()
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
         avatarVersion = param1.readUnsignedShort();
         avatarTransformID = param1.readUnsignedInt();
         avatarEffectID = param1.readUnsignedInt();
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
