package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import flash.utils.IDataInput;
   
   public class P_SpiritValue implements IAngelDataInput
   {
       
      
      public var PA:int;
      
      public var PD:int;
      
      public var MA:int;
      
      public var MD:int;
      
      public var SP:int;
      
      public var HP:int;
      
      public function P_SpiritValue()
      {
         super();
      }
      
      public function read(param1:IDataInput) : void
      {
         this.PA = param1.readUnsignedByte();
         this.PD = param1.readUnsignedByte();
         this.MA = param1.readUnsignedByte();
         this.MD = param1.readUnsignedByte();
         this.SP = param1.readUnsignedByte();
         this.HP = param1.readUnsignedByte();
      }
   }
}
