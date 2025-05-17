package com.QQ.angel.data.entity.combatsys
{
   public class ObjCombatInfo
   {
      
      public var type:int;
      
      public var id:uint;
      
      public var nickName:String;
      
      public var cIndex:int;
      
      public var spirits:Array;
      
      public var modeData:int;
      
      public var guardianPetEnergy:uint;
      
      public var guardianPetAttack:uint;
      
      public var guardianPetDefend:uint;
      
      public var guardianPetMA:uint;
      
      public var guardianPetMD:uint;
      
      public var loadProgress:Number = 0;
      
      public function ObjCombatInfo()
      {
         super();
      }
   }
}

