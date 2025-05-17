package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.data.entity.combatsys.PropertyDes;
   import com.QQ.angel.data.entity.combatsys.SpiritDes;
   import flash.utils.IDataInput;
   
   public class P_BagSpiritData implements IAngelDataInput
   {
      
      public var skillCls:Class = P_BagSpiritSkillData;
      
      public var id:uint;
      
      public var index:uint;
      
      public var level:int;
      
      public var expToNextLevel:uint;
      
      public var temper:int;
      
      public var temperName:String;
      
      public var sex:uint;
      
      public var skinIndex:uint;
      
      public var sexNmae:String;
      
      public var caughtTime:uint;
      
      public var caughtLocation:int;
      
      public var storageTime:uint;
      
      public var closeness:int;
      
      public var affiliation:int;
      
      public var maxHP:int;
      
      public var PA:int;
      
      public var PD:int;
      
      public var MA:int;
      
      public var MD:int;
      
      public var SP:int;
      
      public var HP:int;
      
      public var innateValue:P_SpiritValue;
      
      public var effortValue:P_SpiritValue;
      
      public var skills:Array;
      
      public var des:SpiritDes;
      
      public function P_BagSpiritData()
      {
         super();
      }
      
      public function read(param1:IDataInput) : void
      {
         var _loc5_:P_BagSpiritSkillData = null;
         this.id = param1.readUnsignedInt();
         this.level = param1.readUnsignedByte();
         this.expToNextLevel = param1.readUnsignedInt();
         this.temper = param1.readUnsignedByte();
         this.temperName = PropertyDes.TEMPERS[this.temper - 1];
         this.sex = param1.readUnsignedByte();
         if(this.sex == 1)
         {
            this.sexNmae = "雄";
         }
         else if(this.sex == 2)
         {
            this.sexNmae = "雌";
         }
         else
         {
            this.sexNmae = "未知";
         }
         this.caughtTime = param1.readUnsignedInt();
         this.caughtLocation = param1.readUnsignedShort();
         this.storageTime = param1.readUnsignedInt();
         var _loc2_:int = int(param1.readUnsignedShort());
         this.closeness = _loc2_ & 0x7F;
         this.affiliation = _loc2_ >> 7 & 7;
         this.maxHP = param1.readUnsignedShort();
         this.PA = param1.readUnsignedShort();
         this.PD = param1.readUnsignedShort();
         this.MA = param1.readUnsignedShort();
         this.MD = param1.readUnsignedShort();
         this.SP = param1.readUnsignedShort();
         this.HP = param1.readUnsignedShort();
         this.innateValue = new P_SpiritValue();
         this.innateValue.read(param1);
         this.effortValue = new P_SpiritValue();
         this.effortValue.read(param1);
         this.skills = [];
         var _loc3_:int = int(param1.readUnsignedShort());
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = new this.skillCls() as P_BagSpiritSkillData;
            _loc5_.read(param1);
            this.skills.push(_loc5_);
            _loc4_++;
         }
         param1.readInt();
         this.skinIndex = param1.readUnsignedByte();
         param1.readUnsignedByte();
         param1.readUnsignedShort();
      }
   }
}

