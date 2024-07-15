package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import flash.utils.IDataOutput;
   
   public class P_UInt implements IAngelDataOutput
   {
       
      
      public var num:uint = 0;
      
      public function P_UInt(param1:int = 0)
      {
         super();
         this.num = param1;
      }
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeUnsignedInt(this.num);
      }
      
      public function get length() : uint
      {
         return 4;
      }
   }
}
