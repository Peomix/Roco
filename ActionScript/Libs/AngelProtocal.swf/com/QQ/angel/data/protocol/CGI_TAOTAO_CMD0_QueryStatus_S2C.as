package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_TAOTAO_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "taotao?cmd=0";
      
      public var retCode:P_ReturnCode;
      
      public var itemArray:Array;
      
      public var socreArray:Array;
      
      public function CGI_TAOTAO_CMD0_QueryStatus_S2C()
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
            if(!socreArray)
            {
               socreArray = new Array(3);
            }
            socreArray.length = 0;
            _loc2_ = param1.socreArray.elements();
            for each(_loc3_ in _loc2_)
            {
               socreArray.push(uint(_loc3_.text()));
            }
            if(!itemArray)
            {
               itemArray = new Array(5);
            }
            itemArray.length = 0;
            _loc4_ = param1.itemArray.elements();
            for each(_loc5_ in _loc4_)
            {
               itemArray.push(uint(_loc5_.text()));
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

