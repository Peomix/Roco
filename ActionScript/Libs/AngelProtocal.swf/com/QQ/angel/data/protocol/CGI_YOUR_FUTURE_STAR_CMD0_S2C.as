package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_YOUR_FUTURE_STAR_CMD0_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "your_future_star?cmd=0";
      
      public var high:uint;
      
      public var retCode:P_ReturnCode;
      
      public var model:uint;
      
      public var low:uint;
      
      public var actor:uint;
      
      public var singer:uint;
      
      public var dancer:uint;
      
      public function CGI_YOUR_FUTURE_STAR_CMD0_S2C()
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
            high = uint(param1.high.text());
            low = uint(param1.low.text());
            dancer = uint(param1.dancer.text());
            singer = uint(param1.singer.text());
            actor = uint(param1.actor.text());
            model = uint(param1.model.text());
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

