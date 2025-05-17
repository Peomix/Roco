package com.QQ.angel.data.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x030015_QueryUserDetailInfo_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 196629;
      
      public var level:uint;
      
      public var pvpFreePkLose:uint;
      
      public var bossInfoTreasure:uint;
      
      public var birthDate:uint;
      
      public var isVip:Boolean;
      
      public var bossInfoHeroMode:uint;
      
      public var maxExp:uint;
      
      public var qqUin:uint;
      
      public var pvpMatchEscape:uint;
      
      public var exp:uint;
      
      public var badge:uint;
      
      public var pvpMatchWin:uint;
      
      public var trainerExp:uint;
      
      public var retCode:P_ReturnCode;
      
      public var achieveTitleLevel:uint;
      
      public var avatarVersion:uint;
      
      public var money:uint;
      
      public var strength:uint;
      
      public var magicValue:uint;
      
      public var bossInfoBraveMode:uint;
      
      public var pvpFreePkEscape:uint;
      
      public var pvpFreePkWin:uint;
      
      public var achieveId:uint;
      
      public var trainerLevel:uint;
      
      public var skyTowerMaxFloorNum:uint;
      
      public var charm:uint;
      
      public var avatar:Array;
      
      public var vipRemainDays:uint;
      
      public var intelligence:uint;
      
      public var avatarEffectID:uint;
      
      public var vipLevel:uint;
      
      public var honor:uint;
      
      public var nickname:String;
      
      public var pvpMatchLose:uint;
      
      public var vipExpireDate:int;
      
      public var pvpFreePkConfig:uint;
      
      public var avatarTransformID:uint;
      
      public function SKT_0x030015_QueryUserDetailInfo_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         retCode = ProtocolHelper.ReadCode(param1);
         if(retCode.code < 0)
         {
            return false;
         }
         qqUin = param1.readUnsignedInt();
         nickname = DEFINE.ReadChars(param1,16);
         birthDate = param1.readUnsignedInt();
         level = param1.readUnsignedShort();
         exp = param1.readUnsignedInt();
         maxExp = param1.readUnsignedInt();
         honor = param1.readUnsignedInt();
         strength = param1.readUnsignedInt();
         intelligence = param1.readUnsignedInt();
         charm = param1.readUnsignedInt();
         money = param1.readUnsignedInt();
         avatarVersion = param1.readUnsignedShort();
         avatar = new Array();
         avatar.length = 9;
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            avatar[_loc2_] = param1.readUnsignedInt();
            _loc2_++;
         }
         badge = param1.readUnsignedByte();
         isVip = param1.readByte() != 0;
         vipLevel = param1.readUnsignedByte();
         magicValue = param1.readUnsignedInt();
         vipExpireDate = param1.readInt();
         vipRemainDays = param1.readUnsignedInt();
         pvpMatchWin = param1.readUnsignedInt();
         pvpMatchLose = param1.readUnsignedInt();
         pvpMatchEscape = param1.readUnsignedInt();
         pvpFreePkWin = param1.readUnsignedInt();
         pvpFreePkLose = param1.readUnsignedInt();
         pvpFreePkEscape = param1.readUnsignedInt();
         pvpFreePkConfig = param1.readUnsignedByte();
         bossInfoBraveMode = param1.readUnsignedInt();
         bossInfoHeroMode = param1.readUnsignedInt();
         bossInfoTreasure = param1.readUnsignedInt();
         skyTowerMaxFloorNum = param1.readUnsignedByte();
         trainerLevel = param1.readUnsignedByte();
         trainerExp = param1.readUnsignedInt();
         achieveId = param1.readUnsignedByte();
         achieveTitleLevel = param1.readUnsignedByte();
         avatarTransformID = param1.readUnsignedInt();
         avatarEffectID = param1.readUnsignedInt();
         return true;
      }
   }
}

