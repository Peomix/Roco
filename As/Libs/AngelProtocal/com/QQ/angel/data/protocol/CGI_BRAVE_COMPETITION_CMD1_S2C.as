package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_BRAVE_COMPETITION_CMD1_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "brave_competition?cmd=1";
       
      
      public var rewardArray:Array;
      
      public var todayBattlePets:String;
      
      public var retCode:P_ReturnCode;
      
      public var totalWin:uint;
      
      public var todayWin:String;
      
      public var winRate:String;
      
      public var rewardsStatus:String;
      
      public function CGI_BRAVE_COMPETITION_CMD1_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         var _loc2_:XML = null;
         var _loc3_:ItemInfoChanged = null;
         if(int(param1.result.@value) == 0)
         {
            rewardsStatus = String(param1.rewardsStatus.text());
            todayBattlePets = String(param1.todayBattlePets.text());
            totalWin = uint(param1.totalWin.text());
            todayWin = String(param1.todayWin.text());
            winRate = String(param1.winRate.text());
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            if(!rewardArray)
            {
               rewardArray = new Array(1);
            }
            rewardArray.length = 0;
            for each(_loc2_ in param1.rewardArray.ItemInfoChanged)
            {
               _loc3_ = new ItemInfoChanged();
               _loc3_.decodeCGI(_loc2_);
               rewardArray.push(_loc3_);
            }
            return true;
         }
         retCode = new P_ReturnCode();
         retCode.code = int(param1.result.@value);
         if(param1.result.msg != undefined)
         {
            retCode.message = param1.result.msg.text();
         }
         if(!rewardArray)
         {
            rewardArray = new Array();
         }
         return false;
      }
   }
}
