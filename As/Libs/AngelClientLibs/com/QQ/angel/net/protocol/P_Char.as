package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import flash.utils.IDataOutput;
   
   public class P_Char implements IAngelDataOutput
   {
       
      
      public var num:int;
      
      public function P_Char(param1:int = 0)
      {
         super();
         this.num = param1;
      }
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeByte(this.num);
      }
      
      public function get length() : uint
      {
         return 1;
      }
   }
}
