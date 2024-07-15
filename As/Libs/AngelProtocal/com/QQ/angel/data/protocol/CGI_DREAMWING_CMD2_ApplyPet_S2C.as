package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_DREAMWING_CMD2_ApplyPet_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "dream_wing?cmd=2";
       
      
      public var cd:uint;
      
      public var statusVip:uint;
      
      public var retCode:P_ReturnCode;
      
      public var status:uint;
      
      public var cdVip:uint;
      
      public function CGI_DREAMWING_CMD2_ApplyPet_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            status = uint(param1.status.text());
            statusVip = uint(param1.statusVip.text());
            cd = uint(param1.cd.text());
            cdVip = uint(param1.cdVip.text());
            return true;
         }
         retCode = new P_ReturnCode();
         retCode.code = int(param1.result.@value);
         if(param1.result.msg != undefined)
         {
            retCode.message = param1.result.msg.text();
         }
         return false;
      }
   }
}
