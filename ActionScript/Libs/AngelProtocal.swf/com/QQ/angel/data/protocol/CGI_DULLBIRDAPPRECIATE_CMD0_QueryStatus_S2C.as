package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_DULLBIRDAPPRECIATE_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "dull_bird_appreciate?cmd=0";
      
      public var retCode:P_ReturnCode;
      
      public var featherGrassNum:uint;
      
      public var exchangeStatus:uint;
      
      public var isFirstTime:Boolean;
      
      public function CGI_DULLBIRDAPPRECIATE_CMD0_QueryStatus_S2C()
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
            isFirstTime = Boolean(param1.isFirstTime.text());
            exchangeStatus = uint(param1.exchangeStatus.text());
            featherGrassNum = uint(param1.featherGrassNum.text());
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

