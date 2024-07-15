package com.QQ.angel.data.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.protocolBase.I_C2S_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   
   public class CGI_TANGRAM_CMD2_ApplyGameEnd_C2S extends ProtocolBase implements I_C2S_CGI
   {
      
      public static const CGI_NAME:String = "tangram?cmd=2";
       
      
      public var serialNum:uint;
      
      public function CGI_TANGRAM_CMD2_ApplyGameEnd_C2S()
      {
         super();
      }
      
      public function encodeCGI() : String
      {
         return (CGI_NAME.indexOf("_fcgi") != -1 ? DEFINE.CGI_ROOT.replace("cgi-bin","fcgi-bin") : DEFINE.CGI_ROOT) + CGI_NAME + "&serialNum=" + serialNum;
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
   }
}
