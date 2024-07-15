package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_MOSTPOPULAR_CMD1_ApplyVote_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "most_popular?cmd=1";
       
      
      public var petVoteArray:Array;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_MOSTPOPULAR_CMD1_ApplyVote_S2C()
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
            if(!petVoteArray)
            {
               petVoteArray = new Array(10);
            }
            petVoteArray.length = 0;
            _loc2_ = param1.petVoteArray.elements();
            for each(_loc3_ in _loc2_)
            {
               petVoteArray.push(uint(_loc3_.text()));
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
