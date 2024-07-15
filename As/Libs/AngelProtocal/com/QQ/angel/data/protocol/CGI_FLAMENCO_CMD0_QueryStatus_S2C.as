package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_FLAMENCO_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "flamenco?cmd=0";
       
      
      public var times:uint;
      
      public var mater:Array;
      
      public var retCode:P_ReturnCode;
      
      public var complete:uint;
      
      public function CGI_FLAMENCO_CMD0_QueryStatus_S2C()
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
            times = uint(param1.times.text());
            if(!mater)
            {
               mater = new Array(5);
            }
            mater.length = 0;
            _loc2_ = param1.mater.elements();
            for each(_loc3_ in _loc2_)
            {
               mater.push(uint(_loc3_.text()));
            }
            complete = uint(param1.complete.text());
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
