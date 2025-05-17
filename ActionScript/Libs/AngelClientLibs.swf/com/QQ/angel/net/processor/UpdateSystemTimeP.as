package com.QQ.angel.net.processor
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.net.vo.SystemTimeVo;
   import flash.utils.IDataInput;
   
   public class UpdateSystemTimeP implements IAngelDataInput
   {
      
      public var vo:SystemTimeVo;
      
      public function UpdateSystemTimeP()
      {
         super();
      }
      
      public function read(param1:IDataInput) : void
      {
         this.vo = new SystemTimeVo();
         this.vo.year = param1.readUnsignedByte() + 2010;
         this.vo.month = param1.readUnsignedByte();
         this.vo.day = param1.readUnsignedByte();
         this.vo.h = param1.readUnsignedByte();
         this.vo.m = param1.readUnsignedByte();
         this.vo.s = param1.readUnsignedByte();
      }
   }
}

