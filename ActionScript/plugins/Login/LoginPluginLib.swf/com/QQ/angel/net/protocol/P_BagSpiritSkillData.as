package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.data.entity.combatsys.SpiritSkillDes;
   import flash.utils.IDataInput;
   
   public class P_BagSpiritSkillData implements IAngelDataInput
   {
      
      public var id:uint;
      
      public var ppLeft:int;
      
      public var isHeredity:int;
      
      public var des:SpiritSkillDes;
      
      public function P_BagSpiritSkillData()
      {
         super();
      }
      
      public function read(param1:IDataInput) : void
      {
         this.id = param1.readUnsignedShort();
         this.ppLeft = param1.readUnsignedByte();
         this.isHeredity = param1.readUnsignedByte();
      }
   }
}

