package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import com.QQ.angel.net.ProtocolHelper;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class P_CommonData implements IAngelDataInput, IAngelDataOutput
   {
       
      
      public var pCode:P_ReturnCode;
      
      public function P_CommonData()
      {
         super();
      }
      
      public function read(param1:IDataInput) : void
      {
         this.pCode = ProtocolHelper.ReadCode(param1);
      }
      
      public function write(param1:IDataOutput) : void
      {
      }
      
      public function get length() : uint
      {
         return 0;
      }
   }
}
