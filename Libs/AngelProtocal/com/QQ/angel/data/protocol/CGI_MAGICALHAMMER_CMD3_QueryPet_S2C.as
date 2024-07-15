package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_MAGICALHAMMER_CMD3_QueryPet_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "magical_hammer?cmd=3";
       
      
      public var time:uint;
      
      public var retCode:P_ReturnCode;
      
      public var pets:Array;
      
      public var diamonds:uint;
      
      public function CGI_MAGICALHAMMER_CMD3_QueryPet_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         var _loc2_:XML = null;
         var _loc3_:PetInfo = null;
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            diamonds = uint(param1.diamonds.text());
            time = uint(param1.time.text());
            if(!pets)
            {
               pets = new Array(0);
            }
            pets.length = 0;
            for each(_loc2_ in param1.pets.PetInfo)
            {
               _loc3_ = new PetInfo();
               _loc3_.decodeCGI(_loc2_);
               pets.push(_loc3_);
            }
            return true;
         }
         retCode = new P_ReturnCode();
         retCode.code = int(param1.result.@value);
         if(param1.result.msg != undefined)
         {
            retCode.message = param1.result.msg.text();
         }
         if(!pets)
         {
            pets = new Array();
         }
         return false;
      }
   }
}
