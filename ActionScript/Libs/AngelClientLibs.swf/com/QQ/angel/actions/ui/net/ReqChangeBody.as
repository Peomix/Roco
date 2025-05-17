package com.QQ.angel.actions.ui.net
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class ReqChangeBody implements IAngelDataInput, IAngelDataOutput
   {
      
      public var type:int = 8;
      
      public var faceID:uint;
      
      public var code:P_ReturnCode;
      
      public var version:int;
      
      public function ReqChangeBody(param1:uint = 0)
      {
         super();
         this.faceID = param1;
      }
      
      public function read(param1:IDataInput) : void
      {
         this.code = ProtocolHelper.ReadCode(param1);
         if(this.code.isError())
         {
            return;
         }
         this.version = param1.readUnsignedShort();
      }
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeByte(this.type);
         param1.writeUnsignedInt(this.faceID);
      }
      
      public function get length() : uint
      {
         return 5;
      }
   }
}

