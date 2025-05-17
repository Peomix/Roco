package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_TANGRAM_CMD1_QueryGameStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "tangram?cmd=1";
      
      public var itemInfo:Array;
      
      public var retCode:P_ReturnCode;
      
      public var canComplete:uint;
      
      public var serialNum:uint;
      
      public function CGI_TANGRAM_CMD1_QueryGameStatus_S2C()
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
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            serialNum = uint(param1.serialNum.text());
            canComplete = uint(param1.canComplete.text());
            if(!itemInfo)
            {
               itemInfo = new Array(5);
            }
            itemInfo.length = 0;
            _loc2_ = param1.itemInfo.elements();
            for each(_loc3_ in _loc2_)
            {
               itemInfo.push(uint(_loc3_.text()));
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
   }
}

