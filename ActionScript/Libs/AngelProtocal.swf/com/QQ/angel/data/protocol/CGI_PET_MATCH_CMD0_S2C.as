package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_PET_MATCH_CMD0_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "pet_match?cmd=0";
      
      public var accRewards:String;
      
      public var combatScore:uint;
      
      public var rank:uint;
      
      public var petPower:uint;
      
      public var retCode:P_ReturnCode;
      
      public var pets:String;
      
      public var leftTimes:uint;
      
      public function CGI_PET_MATCH_CMD0_S2C()
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
            combatScore = uint(param1.combatScore.text());
            pets = String(param1.pets.text());
            leftTimes = uint(param1.leftTimes.text());
            accRewards = String(param1.accRewards.text());
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            rank = uint(param1.rank.text());
            petPower = uint(param1.petPower.text());
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

