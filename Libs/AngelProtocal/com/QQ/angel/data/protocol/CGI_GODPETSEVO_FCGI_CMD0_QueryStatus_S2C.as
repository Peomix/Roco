package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_GODPETSEVO_FCGI_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "god_pets_evo_fcgi?cmd=0";
       
      
      public var items:Array;
      
      public var remain2:uint;
      
      public var remain3:uint;
      
      public var retCode:P_ReturnCode;
      
      public var petStatus:uint;
      
      public var status:uint;
      
      public var dimoCombat:uint;
      
      public function CGI_GODPETSEVO_FCGI_CMD0_QueryStatus_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
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
            status = uint(param1.status.text());
            petStatus = uint(param1.petStatus.text());
            dimoCombat = uint(param1.dimoCombat.text());
            remain2 = uint(param1.remain2.text());
            remain3 = uint(param1.remain3.text());
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
   }
}
