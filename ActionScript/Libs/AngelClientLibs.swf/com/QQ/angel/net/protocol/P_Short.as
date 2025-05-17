package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import flash.utils.IDataOutput;
   
   public class P_Short implements IAngelDataOutput
   {
      
      public var num:int = 0;
      
      public function P_Short(param1:int = 0)
      {
         super();
         this.num = param1;
      }
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeShort(this.num);
      }
      
      public function get length() : uint
      {
         return 2;
      }
   }
}

