package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_YOUR_FUTURE_STAR_CMD2_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "your_future_star?cmd=2";
       
      
      public var player:uint;
      
      public var npc:uint;
      
      public var retCode:P_ReturnCode;
      
      public var score:uint;
      
      public function CGI_YOUR_FUTURE_STAR_CMD2_S2C()
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
            player = uint(param1.player.text());
            npc = uint(param1.npc.text());
            score = uint(param1.score.text());
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
