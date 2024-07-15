package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_IRONLEAGUE_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "iron_league?cmd=0";
       
      
      public var giftStatus:Array;
      
      public var isInTime:uint;
      
      public var joinCount:uint;
      
      public var ratio:uint;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_IRONLEAGUE_CMD0_QueryStatus_S2C()
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
            isInTime = uint(param1.isInTime.text());
            joinCount = uint(param1.joinCount.text());
            ratio = uint(param1.ratio.text());
            if(!giftStatus)
            {
               giftStatus = new Array(4);
            }
            giftStatus.length = 0;
            _loc2_ = param1.giftStatus.elements();
            for each(_loc3_ in _loc2_)
            {
               giftStatus.push(uint(_loc3_.text()));
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
