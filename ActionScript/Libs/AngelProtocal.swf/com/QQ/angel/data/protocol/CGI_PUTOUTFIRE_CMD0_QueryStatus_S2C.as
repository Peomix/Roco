package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_PUTOUTFIRE_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "putout_fire?cmd=0";
      
      public var ice:uint;
      
      public var retCode:P_ReturnCode;
      
      public var remain:uint;
      
      public var silk:uint;
      
      public var fire:uint;
      
      public var coat:uint;
      
      public function CGI_PUTOUTFIRE_CMD0_QueryStatus_S2C()
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
            fire = uint(param1.fire.text());
            remain = uint(param1.remain.text());
            silk = uint(param1.silk.text());
            coat = uint(param1.coat.text());
            ice = uint(param1.ice.text());
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

