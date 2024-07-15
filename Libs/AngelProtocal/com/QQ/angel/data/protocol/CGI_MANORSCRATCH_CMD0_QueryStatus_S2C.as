package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.ByteArray;
   
   public class CGI_MANORSCRATCH_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "manor_scratch?cmd=0";
       
      
      public var retCode:P_ReturnCode;
      
      public var seed:uint;
      
      public var item:uint;
      
      public var scratch:ByteArray;
      
      public function CGI_MANORSCRATCH_CMD0_QueryStatus_S2C()
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
            seed = uint(param1.seed.text());
            if(!scratch)
            {
               scratch = new ByteArray();
            }
            scratch.length = 0;
            _loc2_ = param1.scratch.elements();
            for each(_loc3_ in _loc2_)
            {
               scratch.writeByte(uint(_loc3_.text()));
            }
            item = uint(param1.item.text());
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
