package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_WEEKTASKWORK_CMD2_QueryWorkStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "weektaskwork?cmd=2";
      
      public var day0:uint;
      
      public var day1:uint;
      
      public var day2:uint;
      
      public var day3:uint;
      
      public var day4:uint;
      
      public var day5:uint;
      
      public var day6:uint;
      
      public var award0:uint;
      
      public var award1:uint;
      
      public var award2:uint;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_WEEKTASKWORK_CMD2_QueryWorkStatus_S2C()
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
            day0 = uint(param1.day0.text());
            day1 = uint(param1.day1.text());
            day2 = uint(param1.day2.text());
            day3 = uint(param1.day3.text());
            day4 = uint(param1.day4.text());
            day5 = uint(param1.day5.text());
            day6 = uint(param1.day6.text());
            award0 = uint(param1.award0.text());
            award1 = uint(param1.award1.text());
            award2 = uint(param1.award2.text());
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

