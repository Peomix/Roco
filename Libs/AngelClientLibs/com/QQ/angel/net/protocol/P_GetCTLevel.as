package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.net.ProtocolHelper;
   import flash.utils.IDataInput;
   
   public class P_GetCTLevel implements IAngelDataInput
   {
       
      
      public var code:P_ReturnCode;
      
      public var level:int = 0;
      
      public var display:int = 0;
      
      public function P_GetCTLevel()
      {
         super();
      }
      
      public function read(param1:IDataInput) : void
      {
         this.code = ProtocolHelper.ReadCode(param1);
         this.level = param1.readUnsignedByte();
         this.display = param1.readUnsignedByte();
      }
   }
}
