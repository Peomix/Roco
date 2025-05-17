package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   
   public class CGI_DULLBIRDAPPRECIATE_CMD2_ApplyFinishedMovie_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "dull_bird_appreciate?cmd=2";
      
      public function CGI_DULLBIRDAPPRECIATE_CMD2_ApplyFinishedMovie_S2C()
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
            return true;
         }
         return false;
      }
   }
}

