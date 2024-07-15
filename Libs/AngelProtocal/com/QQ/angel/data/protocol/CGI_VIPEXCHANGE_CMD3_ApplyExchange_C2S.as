package com.QQ.angel.data.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.protocolBase.I_C2S_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   
   public class CGI_VIPEXCHANGE_CMD3_ApplyExchange_C2S extends ProtocolBase implements I_C2S_CGI
   {
      
      public static const CGI_NAME:String = "vip_exchange?cmd=3";
       
      
      public var itemId0:uint;
      
      public var itemId1:uint;
      
      public var itemId2:uint;
      
      public var itemCount0:uint;
      
      public var itemCount1:uint;
      
      public var itemCount2:uint;
      
      public function CGI_VIPEXCHANGE_CMD3_ApplyExchange_C2S()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
      
      public function encodeCGI() : String
      {
         return (CGI_NAME.indexOf("_fcgi") != -1 ? DEFINE.CGI_ROOT.replace("cgi-bin","fcgi-bin") : DEFINE.CGI_ROOT) + CGI_NAME + "&itemId0=" + itemId0 + "&itemCount0=" + itemCount0 + "&itemId1=" + itemId1 + "&itemCount1=" + itemCount1 + "&itemId2=" + itemId2 + "&itemCount2=" + itemCount2;
      }
   }
}
