package com.QQ.angel.data.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.protocolBase.I_C2S_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.protocolBase.ProtocolUtil;
   
   public class CGI_WEEKREWARD3366_CMD1_ApplyReward_C2S extends ProtocolBase implements I_C2S_CGI
   {
      
      public static const CGI_NAME:String = "week_reward_3366?cmd=1";
      
      public var blue:uint;
      
      public function CGI_WEEKREWARD3366_CMD1_ApplyReward_C2S()
      {
         super();
      }
      
      public function get unkown() : String
      {
         return ProtocolUtil.getUnkownKey();
      }
      
      public function encodeCGI() : String
      {
         return (CGI_NAME.indexOf("_fcgi") != -1 ? DEFINE.CGI_ROOT.replace("cgi-bin","fcgi-bin") : DEFINE.CGI_ROOT) + CGI_NAME + "&blue=" + blue + "&unkown=" + unkown;
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
   }
}

