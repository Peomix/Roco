package com.QQ.angel.world.vo
{
   import com.QQ.angel.data.entity.combatsys.GuardianPetDes;
   import flash.geom.Point;
   
   public class GuardianPetData
   {
       
      
      public var id:uint;
      
      public var level:uint;
      
      public var name:String;
      
      public var uin:uint;
      
      public var masterName:String;
      
      public var locXY:Point;
      
      public var speed:Number = 1;
      
      public var direction:int = 0;
      
      public var motionType:int = 0;
      
      public var typeID:uint;
      
      public var avatarVersion:int = 0;
      
      public var avatarType:uint;
      
      public var guardianPetDes:GuardianPetDes;
      
      public function GuardianPetData()
      {
         super();
      }
   }
}
