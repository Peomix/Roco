package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_PRAYFORRAINING_CMD1_ApplyItem_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "pray_for_raining?cmd=1";
      
      public var contributed_value:uint;
      
      public var contirbuted_item:Array;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_PRAYFORRAINING_CMD1_ApplyItem_S2C()
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
            contributed_value = uint(param1.contributed_value.text());
            if(!contirbuted_item)
            {
               contirbuted_item = new Array(1);
            }
            contirbuted_item.length = 0;
            for each(_loc2_ in param1.contirbuted_item.ItemInfoChanged32)
            {
               _loc3_ = new ItemInfoChanged32();
               _loc3_.decodeCGI(_loc2_);
               contirbuted_item.push(_loc3_);
            }
            return true;
         }
         retCode = new P_ReturnCode();
         retCode.code = int(param1.result.@value);
         if(param1.result.msg != undefined)
         {
            retCode.message = param1.result.msg.text();
         }
         if(!contirbuted_item)
         {
            contirbuted_item = new Array();
         }
         return false;
      }
   }
}

