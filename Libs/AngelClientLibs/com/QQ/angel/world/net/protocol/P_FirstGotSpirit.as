package com.QQ.angel.world.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class P_FirstGotSpirit implements IAngelDataInput, IAngelDataOutput
   {
       
      
      public var spiritID:uint;
      
      public var code:int;
      
      public function P_FirstGotSpirit(param1:uint = 0)
      {
         super();
         this.spiritID = param1;
      }
      
      public function read(param1:IDataInput) : void
      {
         this.code = param1.readInt();
         this.spiritID = param1.readUnsignedInt();
      }
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeUnsignedInt(this.spiritID);
      }
      
      public function get length() : uint
      {
         return 4;
      }
   }
}
