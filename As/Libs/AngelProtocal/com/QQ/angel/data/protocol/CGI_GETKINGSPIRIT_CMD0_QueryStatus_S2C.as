package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_GETKINGSPIRIT_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "get_king_spirit?cmd=0";
       
      
      public var vip_level:uint;
      
      public var reward_flag:uint;
      
      public var retCode:P_ReturnCode;
      
      public var left_count:uint;
      
      public var game_status:uint;
      
      public function CGI_GETKINGSPIRIT_CMD0_QueryStatus_S2C()
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
            game_status = uint(param1.game_status.text());
            reward_flag = uint(param1.reward_flag.text());
            vip_level = uint(param1.vip_level.text());
            left_count = uint(param1.left_count.text());
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
