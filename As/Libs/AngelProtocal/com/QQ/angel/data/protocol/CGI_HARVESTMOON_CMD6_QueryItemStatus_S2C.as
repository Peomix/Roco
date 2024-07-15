package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_HARVESTMOON_CMD6_QueryItemStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "harvest_moon?cmd=6";
       
      
      public var retCode:P_ReturnCode;
      
      public var itemId:Array;
      
      public function CGI_HARVESTMOON_CMD6_QueryItemStatus_S2C()
      {
         super();
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         var _loc2_:XMLList = null;
         var _loc3_:XML = null;
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            if(!itemId)
            {
               itemId = new Array(12);
            }
            itemId.length = 0;
            _loc2_ = param1.itemId.elements();
            for each(_loc3_ in _loc2_)
            {
               itemId.push(uint(_loc3_.text()));
            }
            return true;
         }
         retCode = new P_ReturnCode();
         retCode.code = int(param1.result.@value);
         if(param1.result.msg != undefined)
         {
            retCode.message = param1.result.msg.text();
         }
         return false;
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
   }
}
