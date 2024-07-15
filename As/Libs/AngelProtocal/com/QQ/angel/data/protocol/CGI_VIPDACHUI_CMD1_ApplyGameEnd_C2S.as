package com.QQ.angel.data.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.protocolBase.I_C2S_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   
   public class CGI_VIPDACHUI_CMD1_ApplyGameEnd_C2S extends ProtocolBase implements I_C2S_CGI
   {
      
      public static const CGI_NAME:String = "vip_dachui?cmd=1";
       
      
      public var excepts:Array;
      
      public var process10:uint;
      
      public var process:uint;
      
      public function CGI_VIPDACHUI_CMD1_ApplyGameEnd_C2S()
      {
         super();
      }
      
      public function encodeCGI() : String
      {
         return (CGI_NAME.indexOf("_fcgi") != -1 ? DEFINE.CGI_ROOT.replace("cgi-bin","fcgi-bin") : DEFINE.CGI_ROOT) + CGI_NAME + "&process=" + process + "&process10=" + process10 + "&excepts=" + (!!excepts ? excepts.join(",") : "");
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
   }
}
