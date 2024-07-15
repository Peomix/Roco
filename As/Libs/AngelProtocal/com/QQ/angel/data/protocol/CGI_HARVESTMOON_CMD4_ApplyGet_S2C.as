package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_HARVESTMOON_CMD4_ApplyGet_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "harvest_moon?cmd=4";
       
      
      public var rewardId0:int;
      
      public var rewardId1:int;
      
      public var rewardId2:int;
      
      public var intimacy1:int;
      
      public var intimacy0:int;
      
      public var intimacy2:int;
      
      public var countdown0:int;
      
      public var countdown1:int;
      
      public var countdown2:int;
      
      public var rewardArray:Array;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_HARVESTMOON_CMD4_ApplyGet_S2C()
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
         var _loc3_:ItemInfoChanged32 = null;
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            intimacy0 = int(param1.intimacy0.text());
            countdown0 = int(param1.countdown0.text());
            rewardId0 = int(param1.rewardId0.text());
            intimacy1 = int(param1.intimacy1.text());
            rewardId1 = int(param1.rewardId1.text());
            countdown1 = int(param1.countdown1.text());
            intimacy2 = int(param1.intimacy2.text());
            countdown2 = int(param1.countdown2.text());
            rewardId2 = int(param1.rewardId2.text());
            if(!rewardArray)
            {
               rewardArray = new Array(0);
            }
            rewardArray.length = 0;
            for each(_loc2_ in param1.rewardArray.ItemInfoChanged32)
            {
               _loc3_ = new ItemInfoChanged32();
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
