package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_LIBRABABY_CMD1_APPLYPUTSTONES_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "libra_baby?cmd=1";
       
      
      public var lightMinusDark:uint;
      
      public var rewardItems:Array;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_LIBRABABY_CMD1_APPLYPUTSTONES_S2C()
      {
         super();
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         var _loc2_:XML = null;
         var _loc3_:ItemInfoChanged = null;
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            lightMinusDark = uint(param1.lightMinusDark.text());
            if(!rewardItems)
            {
               rewardItems = new Array(2);
            }
            rewardItems.length = 0;
            for each(_loc2_ in param1.rewardItems.ItemInfoChanged)
            {
               _loc3_ = new ItemInfoChanged();
               _loc3_.decodeCGI(_loc2_);
               rewardItems.push(_loc3_);
            }
            return true;
         }
         retCode = new P_ReturnCode();
         retCode.code = int(param1.result.@value);
         if(param1.result.msg != undefined)
         {
            retCode.message = param1.result.msg.text();
         }
         if(!rewardItems)
         {
            rewardItems = new Array();
         }
         return false;
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
   }
}
