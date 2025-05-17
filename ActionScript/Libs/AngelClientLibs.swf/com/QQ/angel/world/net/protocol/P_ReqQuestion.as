package com.QQ.angel.world.net.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class P_ReqQuestion implements IAngelDataInput
   {
      
      public var code:P_ReturnCode;
      
      public var question:String;
      
      public var answer:int;
      
      public function P_ReqQuestion()
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
         this.question = DEFINE.ReadString(param1);
         this.answer = param1.readUnsignedByte();
      }
   }
}

