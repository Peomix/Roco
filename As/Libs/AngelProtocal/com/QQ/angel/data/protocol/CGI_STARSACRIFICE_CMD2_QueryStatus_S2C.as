package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_STARSACRIFICE_CMD2_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "star_sacrifice?cmd=2";
       
      
      public var got:uint;
      
      public var retCode:P_ReturnCode;
      
      public var star:uint;
      
      public var myself:uint;
      
      public var friend:uint;
      
      public function CGI_STARSACRIFICE_CMD2_QueryStatus_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            star = uint(param1.star.text());
            myself = uint(param1.myself.text());
            friend = uint(param1.friend.text());
            got = uint(param1.got.text());
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
