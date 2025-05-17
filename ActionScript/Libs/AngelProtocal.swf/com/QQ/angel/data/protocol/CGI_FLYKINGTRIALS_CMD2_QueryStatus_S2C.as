package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_FLYKINGTRIALS_CMD2_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "fly_king_trials?cmd=2";
      
      public var step4process:uint;
      
      public var step2process:uint;
      
      public var mainStatus:uint;
      
      public var step1countDown:uint;
      
      public var step:uint;
      
      public var step2reward:uint;
      
      public var step3status:uint;
      
      public var step4status:uint;
      
      public var step3process:uint;
      
      public var retCode:P_ReturnCode;
      
      public var step2waterRemain:uint;
      
      public function CGI_FLYKINGTRIALS_CMD2_QueryStatus_S2C()
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
            mainStatus = uint(param1.mainStatus.text());
            step = uint(param1.step.text());
            step1countDown = uint(param1.step1countDown.text());
            step2process = uint(param1.step2process.text());
            step2waterRemain = uint(param1.step2waterRemain.text());
            step2reward = uint(param1.step2reward.text());
            step3process = uint(param1.step3process.text());
            step3status = uint(param1.step3status.text());
            step4process = uint(param1.step4process.text());
            step4status = uint(param1.step4status.text());
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

