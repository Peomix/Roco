package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_ANIMALARRIVE_CMD1_ApplySeed_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "animal_arrive?cmd=1";
       
      
      public var item_count:uint;
      
      public var rest_sec:uint;
      
      public var favorable_value:uint;
      
      public var retCode:P_ReturnCode;
      
      public var first:uint;
      
      public var rewardArray:Array;
      
      public var has_get_seed:uint;
      
      public function CGI_ANIMALARRIVE_CMD1_ApplySeed_S2C()
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
            first = uint(param1.first.text());
            has_get_seed = uint(param1.has_get_seed.text());
            rest_sec = uint(param1.rest_sec.text());
            favorable_value = uint(param1.favorable_value.text());
            item_count = uint(param1.item_count.text());
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
