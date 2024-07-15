package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_FORGOTTENCRYSTAL_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "forgottencrystal?cmd=0";
       
      
      public var item3:uint;
      
      public var has_release:uint;
      
      public var time1:uint;
      
      public var time2:uint;
      
      public var retCode:P_ReturnCode;
      
      public var type1:uint;
      
      public var type2:uint;
      
      public var type3:uint;
      
      public var item1:uint;
      
      public var item2:uint;
      
      public function CGI_FORGOTTENCRYSTAL_CMD0_QueryStatus_S2C()
      {
         super();
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
            type1 = uint(param1.type1.text());
            type2 = uint(param1.type2.text());
            type3 = uint(param1.type3.text());
            time1 = uint(param1.time1.text());
            time2 = uint(param1.time2.text());
            has_release = uint(param1.has_release.text());
            item1 = uint(param1.item1.text());
            item2 = uint(param1.item2.text());
            item3 = uint(param1.item3.text());
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
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
   }
}
