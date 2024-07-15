package com.QQ.angel.actions.ui.net
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class ReqOnLineTime implements IAngelDataInput, IAngelDataOutput
   {
       
      
      public var code:P_ReturnCode;
      
      public var time:int;
      
      public function ReqOnLineTime()
      {
         super();
      }
      
      public function read(param1:IDataInput) : void
      {
         this.code = ProtocolHelper.ReadCode(param1);
         if(this.code.isError())
         {
            return;
         }
         this.time = param1.readUnsignedInt();
      }
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeByte(0);
      }
      
      public function get length() : uint
      {
         return 1;
      }
   }
}
