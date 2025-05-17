package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_FLYKINGTRIALS_CMD5_ApplyStep1_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "fly_king_trials?cmd=5";
      
      public var step2process:uint;
      
      public var step:uint;
      
      public var retCode:P_ReturnCode;
      
      public var step2reward:uint;
      
      public var step2waterRemain:uint;
      
      public function CGI_FLYKINGTRIALS_CMD5_ApplyStep1_S2C()
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
            step = uint(param1.step.text());
            step2process = uint(param1.step2process.text());
            step2waterRemain = uint(param1.step2waterRemain.text());
            step2reward = uint(param1.step2reward.text());
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

