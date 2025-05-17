package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_VIPDACHUI_CMD0_ApplyGameStart_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "vip_dachui?cmd=0";
      
      public var itemIdLast10:Array;
      
      public var retCode:P_ReturnCode;
      
      public var itemId:Array;
      
      public function CGI_VIPDACHUI_CMD0_ApplyGameStart_S2C()
      {
         super();
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         var _loc2_:XMLList = null;
         var _loc3_:XML = null;
         var _loc4_:XMLList = null;
         var _loc5_:XML = null;
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
               itemId = new Array(0);
            }
            itemId.length = 0;
            _loc2_ = param1.itemId.elements();
            for each(_loc3_ in _loc2_)
            {
               itemId.push(uint(_loc3_.text()));
            }
            if(!itemIdLast10)
            {
               itemIdLast10 = new Array(0);
            }
            itemIdLast10.length = 0;
            _loc4_ = param1.itemIdLast10.elements();
            for each(_loc5_ in _loc4_)
            {
               itemIdLast10.push(uint(_loc5_.text()));
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

