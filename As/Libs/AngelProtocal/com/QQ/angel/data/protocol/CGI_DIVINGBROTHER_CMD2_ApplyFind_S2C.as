package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_DIVINGBROTHER_CMD2_ApplyFind_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "diving_brother?cmd=2";
       
      
      public var succ:uint;
      
      public var times:uint;
      
      public var paopao_num:uint;
      
      public var rewardArray:Array;
      
      public var retCode:P_ReturnCode;
      
      public var water_num:uint;
      
      public function CGI_DIVINGBROTHER_CMD2_ApplyFind_S2C()
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
            succ = uint(param1.succ.text());
            water_num = uint(param1.water_num.text());
            paopao_num = uint(param1.paopao_num.text());
            times = uint(param1.times.text());
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
