package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_IRONLEAGUE_CMD3_ApplyReward_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "iron_league?cmd=3";
       
      
      public var giftStatus:Array;
      
      public var rewardArray:Array;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_IRONLEAGUE_CMD3_ApplyReward_S2C()
      {
         super();
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         var _loc2_:XML = null;
         var _loc3_:XMLList = null;
         var _loc4_:XML = null;
         var _loc5_:ItemInfoChanged32 = null;
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            if(!rewardArray)
            {
               rewardArray = new Array(0);
            }
            rewardArray.length = 0;
            for each(_loc2_ in param1.rewardArray.ItemInfoChanged32)
            {
               (_loc5_ = new ItemInfoChanged32()).decodeCGI(_loc2_);
               rewardArray.push(_loc5_);
            }
            if(!giftStatus)
            {
               giftStatus = new Array(4);
            }
            giftStatus.length = 0;
            _loc3_ = param1.giftStatus.elements();
            for each(_loc4_ in _loc3_)
            {
               giftStatus.push(uint(_loc4_.text()));
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
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
   }
}
