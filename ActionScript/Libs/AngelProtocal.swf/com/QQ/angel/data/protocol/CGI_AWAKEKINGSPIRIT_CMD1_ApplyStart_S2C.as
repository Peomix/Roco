package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_AWAKEKINGSPIRIT_CMD1_ApplyStart_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "awake_king_spirit?cmd=1";
      
      public var scene:uint;
      
      public var retCode:P_ReturnCode;
      
      public var leftSecs:uint;
      
      public var leftTimes:uint;
      
      public function CGI_AWAKEKINGSPIRIT_CMD1_ApplyStart_S2C()
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
            leftTimes = uint(param1.leftTimes.text());
            leftSecs = uint(param1.leftSecs.text());
            scene = uint(param1.scene.text());
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

