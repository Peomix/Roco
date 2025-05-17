package com.QQ.angel.net
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.net.protocol.P_DetailRoleInfo;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.QQ.angel.net.protocol.P_RoleInfo;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public class ProtocolHelper
   {
      
      public static const RETURNCODE:Class = P_ReturnCode;
      
      public static const USERINFO:Class = P_RoleInfo;
      
      public static const USERDETAILINFO:Class = P_DetailRoleInfo;
      
      public static var USERUIN:uint = 0;
      
      public function ProtocolHelper()
      {
         super();
      }
      
      public static function CreateADF(param1:int, param2:uint = 0) : ADF
      {
         var _loc3_:ADF = new ADF();
         _loc3_.head.cmdID = param1;
         if(param2 != 0)
         {
            _loc3_.head.uin = param2;
         }
         else
         {
            _loc3_.head.uin = USERUIN;
         }
         return _loc3_;
      }
      
      public static function ReadObject(param1:Class, param2:IDataInput) : Object
      {
         var _loc3_:IExternalizable = new param1() as IExternalizable;
         _loc3_.readExternal(param2);
         return _loc3_;
      }
      
      public static function ReadCode(param1:IDataInput) : P_ReturnCode
      {
         var _loc2_:P_ReturnCode = new P_ReturnCode();
         _loc2_.readExternal(param1);
         return _loc2_;
      }
      
      public static function ReadRoleData(param1:IDataInput) : RoleData
      {
         var _loc2_:RoleData = new RoleData();
         _loc2_.avatarType = _loc2_.uin = _loc2_.id = param1.readUnsignedInt();
         _loc2_.roleType = _loc2_.uin > 10000 ? RoleData.MEMBER : RoleData.GUEST;
         _loc2_.nickName = DEFINE.ReadChars(param1,DEFINE.L_NICKNAME);
         _loc2_.level = param1.readUnsignedShort();
         _loc2_.skinType = param1.readUnsignedInt();
         _loc2_.avatarVersion = param1.readUnsignedShort();
         if(_loc2_.avatarType < 10000)
         {
            _loc2_.avatarType = 9527;
         }
         else if(_loc2_.avatarVersion == 0)
         {
            _loc2_.avatarType = _loc2_.skinType;
         }
         _loc2_.avatarURL = DEFINE.ReadChars(param1,32);
         _loc2_.locXY = DEFINE.ReadPoint(param1);
         _loc2_.direction = param1.readShort();
         _loc2_.stateType = param1.readUnsignedByte();
         _loc2_.isFlying = param1.readUnsignedByte();
         _loc2_.flyItem = param1.readUnsignedInt();
         _loc2_.isSwiming = param1.readUnsignedByte();
         _loc2_.swimItem = param1.readUnsignedInt();
         _loc2_.cursedType = param1.readUnsignedShort();
         _loc2_.flashType = param1.readUnsignedShort();
         _loc2_.summonType = param1.readUnsignedShort();
         _loc2_.rideType = param1.readUnsignedShort();
         _loc2_.spiritID = param1.readUnsignedInt();
         _loc2_.isVip = param1.readBoolean();
         _loc2_.vipLevel = param1.readUnsignedByte();
         _loc2_.vipExpiringDays = param1.readUnsignedInt();
         _loc2_.vipLulu = param1.readUnsignedByte();
         _loc2_.isMagicOffset = param1.readUnsignedByte();
         _loc2_.pkState = param1.readUnsignedByte();
         _loc2_.trainerLevel = param1.readUnsignedByte();
         _loc2_.trainerExp = param1.readUnsignedInt();
         _loc2_.achieveId = param1.readUnsignedByte();
         _loc2_.titleLevel = param1.readUnsignedByte();
         _loc2_.avatarTransformID = param1.readUnsignedInt();
         _loc2_.avatarEffectID = param1.readUnsignedInt();
         _loc2_.guardianPetID = param1.readUnsignedInt();
         _loc2_.guardianPetLv = param1.readUnsignedInt();
         _loc2_.fishingState = param1.readUnsignedByte();
         _loc2_.qualifyEmblem = param1.readUnsignedByte();
         _loc2_.selectedMedal = param1.readUnsignedByte();
         _loc2_.footprintID = param1.readUnsignedInt();
         if(param1.bytesAvailable)
         {
            _loc2_.namebgId = param1.readUnsignedInt();
            _loc2_.paopaoId = param1.readUnsignedInt();
         }
         if(param1.bytesAvailable)
         {
            _loc2_.dazzleAvatar = param1.readUnsignedByte() == 1;
            _loc2_.daMagic = param1.readUnsignedInt();
            _loc2_.daRing = param1.readUnsignedInt();
            _loc2_.daMount = param1.readUnsignedInt();
            _loc2_.daEnvironment = param1.readUnsignedInt();
            _loc2_.daBackground = param1.readUnsignedInt();
            _loc2_.daFrame = param1.readUnsignedInt();
            _loc2_.daDoll = param1.readUnsignedInt();
            _loc2_.daStamp = param1.readUnsignedInt();
            _loc2_.daFootprint = param1.readUnsignedInt();
            _loc2_.daNamebg = param1.readUnsignedInt();
            _loc2_.daPopup = param1.readUnsignedInt();
         }
         return _loc2_;
      }
      
      public static function printBytes(param1:ByteArray, param2:int = 0, param3:int = 16) : String
      {
         var _loc9_:* = null;
         var _loc4_:* = "";
         var _loc5_:int = int(param1.length);
         var _loc6_:int = param2;
         var _loc7_:int = 1;
         var _loc8_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_ = int(param1[_loc6_]).toString(16).toLocaleUpperCase();
            if(_loc9_.length == 1)
            {
               _loc9_ += " ";
            }
            _loc4_ += _loc8_ != 0 ? " " + _loc9_ : "[" + _loc7_ + "]" + _loc9_;
            _loc8_++;
            if(_loc8_ == param3)
            {
               _loc7_++;
               _loc4_ += "\n";
               _loc8_ = 0;
            }
            _loc6_++;
         }
         return _loc4_;
      }
   }
}

