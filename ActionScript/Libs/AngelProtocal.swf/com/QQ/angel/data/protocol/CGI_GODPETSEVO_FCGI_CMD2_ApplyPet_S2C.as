package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_GODPETSEVO_FCGI_CMD2_ApplyPet_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "god_pets_evo_fcgi?cmd=2";
      
      public var items:Array;
      
      public var petStatus:uint;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_GODPETSEVO_FCGI_CMD2_ApplyPet_S2C()
      {
         super();
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         var _loc2_:XMLList = null;
         var _loc3_:XML = null;
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            petStatus = uint(param1.petStatus.text());
            if(!items)
            {
               items = new Array(4);
            }
            items.length = 0;
            _loc2_ = param1.items.elements();
            for each(_loc3_ in _loc2_)
            {
               items.push(uint(_loc3_.text()));
            }
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

