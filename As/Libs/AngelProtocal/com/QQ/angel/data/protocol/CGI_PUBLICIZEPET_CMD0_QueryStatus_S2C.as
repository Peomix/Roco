package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_PUBLICIZEPET_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "publicize_pet?cmd=0";
       
      
      public var isFirst:uint;
      
      public var box:uint;
      
      public var retCode:P_ReturnCode;
      
      public var status:uint;
      
      public var week:uint;
      
      public var pet:uint;
      
      public function CGI_PUBLICIZEPET_CMD0_QueryStatus_S2C()
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
            week = uint(param1.week.text());
            isFirst = uint(param1.isFirst.text());
            box = uint(param1.box.text());
            pet = uint(param1.pet.text());
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
