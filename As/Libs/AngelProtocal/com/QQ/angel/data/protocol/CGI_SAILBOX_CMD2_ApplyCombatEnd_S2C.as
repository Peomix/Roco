package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_SAILBOX_CMD2_ApplyCombatEnd_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "sail_box?cmd=2";
       
      
      public var num:uint;
      
      public var rewardArray:Array;
      
      public var retCode:P_ReturnCode;
      
      public var mail:uint;
      
      public var numAdd:uint;
      
      public function CGI_SAILBOX_CMD2_ApplyCombatEnd_S2C()
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
            mail = uint(param1.mail.text());
            num = uint(param1.num.text());
            numAdd = uint(param1.numAdd.text());
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
