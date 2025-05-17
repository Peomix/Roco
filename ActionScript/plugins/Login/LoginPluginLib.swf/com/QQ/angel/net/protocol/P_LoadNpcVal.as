package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import com.QQ.angel.net.ProtocolHelper;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class P_LoadNpcVal implements IAngelDataInput, IAngelDataOutput
   {
      
      public var npcID:uint;
      
      public var code:P_ReturnCode;
      
      public var value:int;
      
      public function P_LoadNpcVal(param1:uint = 0)
      {
         super();
         this.npcID = param1;
      }
      
      public function read(param1:IDataInput) : void
      {
         this.code = ProtocolHelper.ReadCode(param1);
         if(this.code.isError())
         {
            return;
         }
         this.npcID = param1.readUnsignedInt();
         this.value = param1.readUnsignedByte();
      }
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeUnsignedInt(this.npcID);
      }
      
      public function get length() : uint
      {
         return 4;
      }
   }
}

