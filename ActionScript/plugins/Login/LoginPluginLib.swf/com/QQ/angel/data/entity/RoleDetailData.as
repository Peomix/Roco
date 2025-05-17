package com.QQ.angel.data.entity
{
   import flash.display.BitmapData;
   
   public class RoleDetailData
   {
      
      public static var AVATAR_NUM:int = 9;
      
      public static var DAZZLE_NUM:int = 29;
      
      public static var EMBLEMS_NUM:int = 8;
      
      public var serNum:int = 0;
      
      public var id:uint;
      
      public var nickname:String;
      
      public var title:String;
      
      public var level:int;
      
      public var exp:uint;
      
      public var maxExp:uint;
      
      public var honor:uint;
      
      public var coin:uint;
      
      public var birthDate:Date;
      
      public var mood:String;
      
      public var atkp:uint;
      
      public var intp:uint;
      
      public var chmp:uint;
      
      public var skinColor:int;
      
      public var avatarVersion:int;
      
      public var avatar:Array;
      
      public var headBD:BitmapData;
      
      public var emblemsObtained:Array;
      
      public var isVip:Boolean;
      
      public var vipLevel:int;
      
      public var magicValue:uint;
      
      public var vipExpireDate:Date;
      
      public var vipExpiringDays:int;
      
      public var pvpJWin:uint;
      
      public var pvpJLost:uint;
      
      public var pvpJEscape:uint;
      
      public var pvpZWin:uint;
      
      public var pvpZLost:uint;
      
      public var pvpZEscape:uint;
      
      public var pvpZConfig:uint;
      
      public var bossInfoBraveMode:uint;
      
      public var bossInfoHeroMode:uint;
      
      public var bossInfoTreasure:uint;
      
      public var skyTowerMaxFloorNum:uint;
      
      public var trainerLevel:uint;
      
      public var trainerExp:int;
      
      public var achieveId:int;
      
      public var titleLevel:int;
      
      public var avatarEffectID:int;
      
      public var avatarTransformID:int;
      
      public var diamondNum:int;
      
      public var guardianPetID:uint;
      
      public var guardianPetLevel:uint;
      
      public var honourPoint:uint;
      
      public var fakeMedal1:uint;
      
      public var fakeMedal2:uint;
      
      public var qualifyEmblem:int;
      
      public var newAdventureLastPoint:int;
      
      public var selectedMedal:int;
      
      public var footprintID:int;
      
      public var ladderMatchLevel:int;
      
      public var namebgId:int;
      
      public var paopaoId:int;
      
      public var dazzleAvatar:Boolean;
      
      public var daAvatar:Array;
      
      public function RoleDetailData()
      {
         super();
      }
      
      public function getBossInfoTreasureStatus(param1:uint) : int
      {
         if(param1 >= 0 && param1 < 16)
         {
            return this.bossInfoTreasure >> (param1 << 1) & 3;
         }
         return -1;
      }
      
      public function getBossInfoHeroModeBossWinCount() : uint
      {
         var _loc1_:uint = this.bossInfoHeroMode;
         _loc1_ = uint((_loc1_ & 0x55555555) + (_loc1_ >> 1 & 0x55555555));
         _loc1_ = uint((_loc1_ & 0x33333333) + (_loc1_ >> 2 & 0x33333333));
         _loc1_ = uint(_loc1_ + (_loc1_ >> 4) & 0x0F0F0F0F);
         _loc1_ += _loc1_ >> 8;
         _loc1_ += _loc1_ >> 16;
         return _loc1_ & 0xFF;
      }
      
      public function getBossInfoHeroModeStatus(param1:uint) : int
      {
         if(param1 >= 0 && param1 < 22)
         {
            return this.bossInfoHeroMode & 1 << param1 ? 1 : 0;
         }
         return -1;
      }
   }
}

