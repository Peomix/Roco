package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_LIFESOUL_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "life_soul?cmd=0";
      
      public var FinishFlag:uint;
      
      public var NeedSecond:uint;
      
      public var retCode:P_ReturnCode;
      
      public var NeedNum:uint;
      
      public var DayGiftFlag:uint;
      
      public var ID:uint;
      
      public var HaveNum:uint;
      
      public var PartFlag:uint;
      
      public function CGI_LIFESOUL_CMD0_QueryStatus_S2C()
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
            ID = uint(param1.ID.text());
            NeedNum = uint(param1.NeedNum.text());
            HaveNum = uint(param1.HaveNum.text());
            DayGiftFlag = uint(param1.DayGiftFlag.text());
            NeedSecond = uint(param1.NeedSecond.text());
            PartFlag = uint(param1.PartFlag.text());
            FinishFlag = uint(param1.FinishFlag.text());
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

