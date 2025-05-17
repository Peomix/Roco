package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_HERODIG_CMD4_ApplyTool_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "hero_dig?cmd=4";
      
      public var itemCount:uint;
      
      public var currentToolId:uint;
      
      public var exchange0:uint;
      
      public var exchange1:uint;
      
      public var exchange2:uint;
      
      public var currentToolNum:uint;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_HERODIG_CMD4_ApplyTool_S2C()
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
            currentToolId = uint(param1.currentToolId.text());
            currentToolNum = uint(param1.currentToolNum.text());
            exchange0 = uint(param1.exchange0.text());
            exchange1 = uint(param1.exchange1.text());
            exchange2 = uint(param1.exchange2.text());
            itemCount = uint(param1.itemCount.text());
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

