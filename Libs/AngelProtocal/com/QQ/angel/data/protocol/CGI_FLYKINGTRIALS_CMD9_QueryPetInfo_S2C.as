package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_FLYKINGTRIALS_CMD9_QueryPetInfo_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "fly_king_trials?cmd=9";
       
      
      public var pets:Array;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_FLYKINGTRIALS_CMD9_QueryPetInfo_S2C()
      {
         super();
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
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
   }
}
