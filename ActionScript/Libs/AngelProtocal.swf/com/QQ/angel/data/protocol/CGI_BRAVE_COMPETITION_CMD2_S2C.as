package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_BRAVE_COMPETITION_CMD2_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "brave_competition?cmd=2";
      
      public var winRate:String;
      
      public var todayBattlePets:String;
      
      public var retCode:P_ReturnCode;
      
      public var rewardsStatus:String;
      
      public var todayWin:String;
      
      public var totalWin:String;
      
      public function CGI_BRAVE_COMPETITION_CMD2_S2C()
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
            winRate = String(param1.winRate.text());
            todayWin = String(param1.todayWin.text());
            totalWin = String(param1.totalWin.text());
            todayBattlePets = String(param1.todayBattlePets.text());
            rewardsStatus = String(param1.rewardsStatus.text());
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

