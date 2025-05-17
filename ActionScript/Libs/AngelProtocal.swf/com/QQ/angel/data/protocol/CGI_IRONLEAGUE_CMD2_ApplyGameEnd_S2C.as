package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_IRONLEAGUE_CMD2_ApplyGameEnd_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "iron_league?cmd=2";
      
      public var giftStatus:Array;
      
      public var rewardArray:Array;
      
      public var ratio:uint;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_IRONLEAGUE_CMD2_ApplyGameEnd_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         var _loc2_:XMLList = null;
         var _loc3_:XML = null;
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
            ratio = uint(param1.ratio.text());
            if(!giftStatus)
            {
               giftStatus = new Array(4);
            }
            giftStatus.length = 0;
            _loc2_ = param1.giftStatus.elements();
            for each(_loc3_ in _loc2_)
            {
               giftStatus.push(uint(_loc3_.text()));
            }
            if(!rewardArray)
            {
               rewardArray = new Array(0);
            }
            rewardArray.length = 0;
            for each(_loc4_ in param1.rewardArray.ItemInfoChanged32)
            {
               _loc5_ = new ItemInfoChanged32();
               _loc5_.decodeCGI(_loc4_);
               rewardArray.push(_loc5_);
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

