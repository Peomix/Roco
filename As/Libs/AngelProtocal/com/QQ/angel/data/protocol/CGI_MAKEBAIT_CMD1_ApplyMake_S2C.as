package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_MAKEBAIT_CMD1_ApplyMake_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "make_bait?cmd=1";
       
      
      public var rewardArray:Array;
      
      public var remain:uint;
      
      public var retCode:P_ReturnCode;
      
      public var item:Array;
      
      public function CGI_MAKEBAIT_CMD1_ApplyMake_S2C()
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
         var _loc3_:XML = null;
         var _loc4_:ItemInfoChanged32 = null;
         var _loc5_:ItemInfoChanged32 = null;
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            remain = uint(param1.remain.text());
            if(!item)
            {
               item = new Array(0);
            }
            item.length = 0;
            for each(_loc2_ in param1.item.ItemInfoChanged32)
            {
               (_loc4_ = new ItemInfoChanged32()).decodeCGI(_loc2_);
               item.push(_loc4_);
            }
            if(!rewardArray)
            {
               rewardArray = new Array(0);
            }
            rewardArray.length = 0;
            for each(_loc3_ in param1.rewardArray.ItemInfoChanged32)
            {
               (_loc5_ = new ItemInfoChanged32()).decodeCGI(_loc3_);
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
         if(!item)
         {
            item = new Array();
         }
         if(!rewardArray)
         {
            rewardArray = new Array();
         }
         return false;
      }
   }
}
