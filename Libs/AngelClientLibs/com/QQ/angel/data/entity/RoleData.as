package com.QQ.angel.data.entity
{
   import flash.geom.Point;
   
   public class RoleData
   {
      
      public static const GUEST:int = 0;
      
      public static const MEMBER:int = 1;
       
      
      public var id:uint;
      
      public var uin:uint;
      
      public var roleType:int;
      
      public var nickName:String;
      
      public var skinType:uint;
      
      public var avatarType:uint;
      
      public var avatarVersion:int;
      
      public var avatarURL:String;
      
      public var level:int;
      
      public var isVip:Boolean;
      
      public var vipLevel:int;
      
      public var vipExpiringDays:uint;
      
      public var direction:int = -1;
      
      public var motionType:int = -1;
      
      public var speed:Number = 4;
      
      public var locXY:Point;
      
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
      
      public var vipLulu:int;
      
      public var guardianPetID:uint;
      
      public var guardianPetLv:uint;
      
      public var isMagicOffset:uint;
      
      public var pkState:uint = 0;
      
      public var trainerLevel:uint;
      
      public var trainerExp:int;
      
      public var achieveId:int;
      
      public var titleLevel:int;
      
      public var isInBombat:Boolean;
      
      public var flag:int;
      
      public var avatarEffectID:int;
      
      public var avatarTransformID:int;
      
      public var fishingState:uint;
      
      public var qualifyEmblem:int;
      
      public var selectedMedal:int;
      
      public var footprintID:int;
      
      public var namebgId:int;
      
      public var paopaoId:int;
      
      public var dazzleAvatar:Boolean;
      
      public var daMagic:int;
      
      public var daRing:int;
      
      public var daMount:int;
      
      public var daEnvironment:int;
      
      public var daBackground:int;
      
      public var daFrame:int;
      
      public var daDoll:int;
      
      public var daStamp:int;
      
      public var daFootprint:int;
      
      public var daNamebg:int;
      
      public var daPopup:int;
      
      public function RoleData()
      {
         super();
      }
      
      public function update(param1:RoleData) : void
      {
         this.nickName = param1.nickName;
         this.skinType = param1.skinType;
         this.avatarType = param1.avatarType;
         this.avatarVersion = param1.avatarVersion;
         this.avatarURL = param1.avatarURL;
         this.level = param1.level;
         this.isVip = param1.isVip;
         this.vipLevel = param1.vipLevel;
         this.vipExpiringDays = param1.vipExpiringDays;
         this.direction = param1.direction;
         this.motionType = param1.motionType;
         this.speed = param1.speed;
         this.locXY = param1.locXY;
         this.stateType = param1.stateType;
         this.isFlying = param1.isFlying;
         this.flyItem = param1.flyItem;
         this.isSwiming = param1.isSwiming;
         this.swimItem = param1.swimItem;
         this.cursedType = param1.cursedType;
         this.flashType = param1.flashType;
         this.summonType = param1.summonType;
         this.rideType = param1.rideType;
         this.spiritID = param1.spiritID;
         this.vipLulu = param1.vipLulu;
         this.guardianPetID = param1.guardianPetID;
         this.guardianPetLv = param1.guardianPetLv;
         this.isMagicOffset = param1.isMagicOffset;
         this.pkState = param1.pkState;
         this.trainerLevel = param1.trainerLevel;
         this.trainerExp = param1.trainerExp;
         this.achieveId = param1.achieveId;
         this.titleLevel = param1.titleLevel;
         this.fishingState = param1.fishingState;
         this.avatarEffectID = param1.avatarEffectID;
         this.avatarTransformID = param1.avatarTransformID;
         this.qualifyEmblem = param1.qualifyEmblem;
         this.selectedMedal = param1.selectedMedal;
         this.footprintID = param1.footprintID;
         this.namebgId = param1.namebgId;
         this.paopaoId = param1.paopaoId;
         this.dazzleAvatar = param1.dazzleAvatar;
         this.daBackground = param1.daBackground;
         this.daDoll = param1.daDoll;
         this.daEnvironment = param1.daEnvironment;
         this.daFootprint = param1.daFootprint;
         this.daFrame = param1.daFrame;
         this.daMagic = param1.daMagic;
         this.daMount = param1.daMount;
         this.daNamebg = param1.daNamebg;
         this.daPopup = param1.daPopup;
         this.daRing = param1.daRing;
         this.daStamp = param1.daStamp;
      }
      
      public function toString() : String
      {
         return "[RoleData: id = " + this.id + ", uin = " + this.uin + ", nickName = " + this.nickName + "]";
      }
   }
}
