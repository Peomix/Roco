package com.QQ.angel.plugs.Login.data
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class LoginDataRepply implements IAngelDataInput
   {
       
      
      public var sceneID:uint;
      
      public var sessionKey:String;
      
      public var mainRole:RoleData;
      
      public var roomID:uint;
      
      public var sceneVer:uint;
      
      public var firstLogin:int = 0;
      
      public var returnCode:P_ReturnCode;
      
      public function LoginDataRepply()
      {
         super();
      }
      
      public function read(param1:IDataInput) : void
      {
         returnCode = ProtocolHelper.ReadCode(param1);
         if(returnCode.isError() == false)
         {
            roomID = param1.readUnsignedShort();
            sceneID = param1.readUnsignedShort();
            sceneVer = param1.readUnsignedShort();
            mainRole = ProtocolHelper.ReadRoleData(param1);
            firstLogin = param1.readUnsignedByte();
            mainRole.flag = param1.readUnsignedInt();
         }
      }
   }
}
