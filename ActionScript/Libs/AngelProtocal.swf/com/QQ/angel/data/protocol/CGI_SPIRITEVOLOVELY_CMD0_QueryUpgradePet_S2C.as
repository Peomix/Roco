package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.ByteArray;
   
   public class CGI_SPIRITEVOLOVELY_CMD0_QueryUpgradePet_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "spirit_evo_lovely?cmd=0";
      
      public var stateArray:ByteArray;
      
      public var petArray:Array;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_SPIRITEVOLOVELY_CMD0_QueryUpgradePet_S2C()
      {
         super();
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         var _loc2_:XMLList = null;
         var _loc3_:XML = null;
         var _loc4_:XML = null;
         var _loc5_:PetInfo = null;
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            if(!stateArray)
            {
               stateArray = new ByteArray();
            }
            stateArray.length = 0;
            _loc2_ = param1.stateArray.elements();
            for each(_loc3_ in _loc2_)
            {
               stateArray.writeByte(uint(_loc3_.text()));
            }
            if(!petArray)
            {
               petArray = new Array(0);
            }
            petArray.length = 0;
            for each(_loc4_ in param1.petArray.PetInfo)
            {
               _loc5_ = new PetInfo();
               _loc5_.decodeCGI(_loc4_);
               petArray.push(_loc5_);
            }
            return true;
         }
         retCode = new P_ReturnCode();
         retCode.code = int(param1.result.@value);
         if(param1.result.msg != undefined)
         {
            retCode.message = param1.result.msg.text();
         }
         if(!petArray)
         {
            petArray = new Array();
         }
         return false;
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
   }
}

