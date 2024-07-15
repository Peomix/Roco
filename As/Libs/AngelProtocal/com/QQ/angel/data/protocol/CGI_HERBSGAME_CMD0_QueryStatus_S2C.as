package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_HERBSGAME_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "herbs_game?cmd=0";
       
      
      public var comp30Sec:uint;
      
      public var comp60Sec:uint;
      
      public var comp90Sec:uint;
      
      public var step:uint;
      
      public var countDown:uint;
      
      public var todayWin:uint;
      
      public var pet:uint;
      
      public var remain:uint;
      
      public var retCode:P_ReturnCode;
      
      public var currentTool:uint;
      
      public var todayChoose:uint;
      
      public function CGI_HERBSGAME_CMD0_QueryStatus_S2C()
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
            comp30Sec = uint(param1.comp30Sec.text());
            comp60Sec = uint(param1.comp60Sec.text());
            comp90Sec = uint(param1.comp90Sec.text());
            todayChoose = uint(param1.todayChoose.text());
            todayWin = uint(param1.todayWin.text());
            countDown = uint(param1.countDown.text());
            currentTool = uint(param1.currentTool.text());
            step = uint(param1.step.text());
            pet = uint(param1.pet.text());
            remain = uint(param1.remain.text());
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
