package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_SAVETHEBIRD_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "save_the_bird?cmd=0";
      
      public var love_count:uint;
      
      public var fight_flag:uint;
      
      public var save_bird_0:uint;
      
      public var save_bird_1:uint;
      
      public var retCode:P_ReturnCode;
      
      public var save_bird_3:uint;
      
      public var save_bird_4:uint;
      
      public var save_bird_2:uint;
      
      public var flash_flag:uint;
      
      public function CGI_SAVETHEBIRD_CMD0_QueryStatus_S2C()
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
            flash_flag = uint(param1.flash_flag.text());
            fight_flag = uint(param1.fight_flag.text());
            love_count = uint(param1.love_count.text());
            save_bird_0 = uint(param1.save_bird_0.text());
            save_bird_1 = uint(param1.save_bird_1.text());
            save_bird_2 = uint(param1.save_bird_2.text());
            save_bird_3 = uint(param1.save_bird_3.text());
            save_bird_4 = uint(param1.save_bird_4.text());
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

