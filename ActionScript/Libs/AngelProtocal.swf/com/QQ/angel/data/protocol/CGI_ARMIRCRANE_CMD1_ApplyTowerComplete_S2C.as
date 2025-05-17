package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_ARMIRCRANE_CMD1_ApplyTowerComplete_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "armir_crane?cmd=1";
      
      public var tower0:uint;
      
      public var tower1:uint;
      
      public var tower2:uint;
      
      public var tower3:uint;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_ARMIRCRANE_CMD1_ApplyTowerComplete_S2C()
      {
         super();
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
            tower0 = uint(param1.tower0.text());
            tower1 = uint(param1.tower1.text());
            tower2 = uint(param1.tower2.text());
            tower3 = uint(param1.tower3.text());
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
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
   }
}

