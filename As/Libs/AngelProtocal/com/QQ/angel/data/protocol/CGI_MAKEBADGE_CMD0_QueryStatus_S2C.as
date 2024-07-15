package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_MAKEBADGE_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "makebadge?cmd=0";
       
      
      public var day:uint;
      
      public var time:uint;
      
      public var retCode:P_ReturnCode;
      
      public var reward:uint;
      
      public var item:uint;
      
      public function CGI_MAKEBADGE_CMD0_QueryStatus_S2C()
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
            day = uint(param1.day.text());
            item = uint(param1.item.text());
            time = uint(param1.time.text());
            reward = uint(param1.reward.text());
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
