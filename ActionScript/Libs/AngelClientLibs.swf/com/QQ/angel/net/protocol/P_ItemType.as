package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import flash.utils.IDataOutput;
   
   public class P_ItemType implements IAngelDataOutput
   {
      
      public var itemType:int;
      
      public var itemSubType:int;
      
      public function P_ItemType()
      {
         super();
      }
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeByte(this.itemType);
         param1.writeByte(this.itemSubType);
      }
      
      public function get length() : uint
      {
         return 2;
      }
   }
}

