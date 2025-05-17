package com.QQ.angel.plugs.Login.data
{
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import flash.utils.IDataOutput;
   
   public class ReqFastLoginData implements IAngelDataOutput
   {
      
      public var sessionKey:String;
      
      public function ReqFastLoginData()
      {
         super();
      }
      
      public function get length() : uint
      {
         return 64;
      }
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeUTFBytes(sessionKey);
      }
   }
}

