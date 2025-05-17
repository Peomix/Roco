package com.QQ.angel.world.vo
{
   public class RoleStateData
   {
      
      public static const FLY_BALLOON:int = 1;
      
      public static const FLY_BROOM:int = 2;
      
      public static const SWIM_BLEB:int = 67174444;
      
      public var uin:uint;
      
      public var stateType:int;
      
      public var isFlying:int;
      
      public var flyItem:uint;
      
      public var isSwiming:int;
      
      public var swimItem:uint;
      
      public var cursedType:int;
      
      public var flashType:int;
      
      public var summonType:int;
      
      public var rideType:int;
      
      public var spiritID:uint;
      
      public var guardianPetID:uint;
      
      public var guardianPetLv:uint;
      
      public var isVip:Boolean;
      
      public var vipLevel:int;
      
      public var vipLulu:int;
      
      public var vipExpiringDays:uint;
      
      public var isMagicOffset:uint;
      
      public var pkState:uint = 0;
      
      public var fishingState:uint = 0;
      
      public function RoleStateData()
      {
         super();
      }
   }
}

