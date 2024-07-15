package com.QQ.angel.data.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.protocolBase.I_C2S_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   
   public class CGI_GODPETSEVO_FCGI_CMD4_ApplyUpgrade_C2S extends ProtocolBase implements I_C2S_CGI
   {
      
      public static const CGI_NAME:String = "god_pets_evo_fcgi?cmd=4";
       
      
      public var catchtime:uint;
      
      public var id:uint;
      
      public function CGI_GODPETSEVO_FCGI_CMD4_ApplyUpgrade_C2S()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
      
      public function encodeCGI() : String
      {
         return (CGI_NAME.indexOf("_fcgi") != -1 ? DEFINE.CGI_ROOT.replace("cgi-bin","fcgi-bin") : DEFINE.CGI_ROOT) + CGI_NAME + "&id=" + id + "&catchtime=" + catchtime;
      }
   }
}
