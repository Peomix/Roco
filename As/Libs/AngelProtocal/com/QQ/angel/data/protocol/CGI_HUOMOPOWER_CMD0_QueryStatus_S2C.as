package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_HUOMOPOWER_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "huomopower?cmd=0";
       
      
      public var realization1:uint;
      
      public var realization2:uint;
      
      public var realization3:uint;
      
      public var retCode:P_ReturnCode;
      
      public var first:uint;
      
      public var remain:uint;
      
      public function CGI_HUOMOPOWER_CMD0_QueryStatus_S2C()
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
            first = uint(param1.first.text());
            remain = uint(param1.remain.text());
            realization1 = uint(param1.realization1.text());
            realization2 = uint(param1.realization2.text());
            realization3 = uint(param1.realization3.text());
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
