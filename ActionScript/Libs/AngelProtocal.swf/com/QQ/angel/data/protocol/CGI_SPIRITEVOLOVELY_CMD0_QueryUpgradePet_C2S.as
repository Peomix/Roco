package com.QQ.angel.data.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.protocolBase.I_C2S_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   
   public class CGI_SPIRITEVOLOVELY_CMD0_QueryUpgradePet_C2S extends ProtocolBase implements I_C2S_CGI
   {
      
      public static const CGI_NAME:String = "spirit_evo_lovely?cmd=0";
      
      public var index:uint;
      
      public function CGI_SPIRITEVOLOVELY_CMD0_QueryUpgradePet_C2S()
      {
         super();
      }
      
      public function encodeCGI() : String
      {
         return (CGI_NAME.indexOf("_fcgi") != -1 ? DEFINE.CGI_ROOT.replace("cgi-bin","fcgi-bin") : DEFINE.CGI_ROOT) + CGI_NAME + "&index=" + index;
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
   }
}

