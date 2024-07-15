package com.QQ.angel.api.net.protocol
{
   import flash.utils.IDataOutput;
   
   public interface IAngelDataOutput
   {
       
      
      function write(param1:IDataOutput) : void;
      
      function get length() : uint;
   }
}
