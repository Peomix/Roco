package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_PET_MATCH_CMD2_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "pet_match?cmd=2";
       
      
      public var rewardArray:Array;
      
      public var rank:uint;
      
      public var retCode:P_ReturnCode;
      
      public var combatScore:uint;
      
      public var leftTimes:uint;
      
      public function CGI_PET_MATCH_CMD2_S2C()
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
            combatScore = uint(param1.combatScore.text());
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
            leftTimes = uint(param1.leftTimes.text());
            rank = uint(param1.rank.text());
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
